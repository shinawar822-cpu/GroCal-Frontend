import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/models/user_model.dart';
import '../../core/providers/app_providers.dart';
import '../../core/routes/app_router.dart';
import '../../core/theme/app_theme.dart';
import '../../widgets/task_card_widget.dart';
import '../../widgets/filter_bottom_sheet.dart';
import '../../widgets/search_bar_widget.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});
  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _searchController = TextEditingController();
  String _searchQuery = '';
  Map<String, String> _filters = {
    'niche': 'All',
    'platform': 'All',
    'country': 'All Countries',
    'language': 'English',
    'followers': 'All',
    'activity': 'All'
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  List _filteredTasks(TaskProvider provider) {
    return provider.tasks.where((task) {
      final query = _searchQuery.toLowerCase();
      return query.isEmpty ||
          task.title.toLowerCase().contains(query) ||
          task.creatorName.toLowerCase().contains(query) ||
          task.niche.toLowerCase().contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    final user = Provider.of<UserProvider>(context).currentUser!;
    final tasks = _filteredTasks(taskProvider);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text('Tasks'),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                  color: AppTheme.accentColor,
                  borderRadius: BorderRadius.circular(16)),
              child: Row(children: [
                const Icon(Icons.stars, size: 16, color: Colors.white),
                const SizedBox(width: 4),
                Text('${user.credits}',
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ]),
            ),
          ],
        ),
        bottom: TabBar(controller: _tabController, tabs: const [
          Tab(text: 'Available'),
          Tab(text: 'My Tasks'),
          Tab(text: 'Review')
        ]),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: SearchBarWidget(
              controller: _searchController,
              placeholder: 'Search tasks, creators, platforms',
              onChanged: (value) => setState(() => _searchQuery = value),
              onTapFilter: () async {
                final result = await FilterBottomSheet.open(context, _filters);
                if (result != null) setState(() => _filters = result);
              },
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildAvailableTab(context, taskProvider, tasks),
                _buildMyTasksTab(context, user),
                _buildReviewTab(context, taskProvider),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pushNamed(context, AppRouter.createTask),
        icon: const Icon(Icons.add),
        label: const Text('Create Task'),
      ),
    );
  }

  Widget _buildAvailableTab(
          BuildContext context, TaskProvider provider, List tasks) =>
      tasks.isEmpty
          ? const Center(child: Text('No tasks found'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: tasks.length,
              itemBuilder: (ctx, i) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: TaskCardWidget(task: tasks[i])),
            );

  Widget _buildMyTasksTab(BuildContext context, UserModel user) => Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text('Tasks Created: ${user.tasksCreated}',
              style: const TextStyle(fontSize: 18)),
          const SizedBox(height: 12),
          Text('Tasks Completed: ${user.tasksCompleted}',
              style: const TextStyle(fontSize: 18)),
          const SizedBox(height: 12),
          Text('Reviewer Level: ${user.reviewerTrustLevel}',
              style: const TextStyle(fontSize: 18)),
        ]),
      );

  Widget _buildReviewTab(BuildContext context, TaskProvider provider) {
    if (provider.pendingProofs.isEmpty) {
      return const Center(child: Text('No pending reviews'));
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: provider.pendingProofs.length,
      itemBuilder: (ctx, i) {
        final proof = provider.pendingProofs[i];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  CircleAvatar(
                      backgroundImage: proof.userImage != null
                          ? NetworkImage(proof.userImage!)
                          : null),
                  const SizedBox(width: 12),
                  Text(proof.userName,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ]),
                const SizedBox(height: 12),
                Text('Submitted: ${proof.submittedLink}',
                    style: const TextStyle(color: AppTheme.textSecondary)),
                const SizedBox(height: 8),
                Text('Status: ${proof.status}',
                    style: const TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => provider.approveProof(proof.id),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.successColor),
                        child: const Text('Approve'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => provider.rejectProof(proof.id),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.errorColor),
                        child: const Text('Reject'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
