import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/models/user_model.dart';
import '../../core/providers/app_providers.dart';
import '../../core/routes/app_router.dart';
import '../../core/theme/app_theme.dart';
import '../../widgets/task_card_widget.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});
  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    final user = Provider.of<UserProvider>(context).currentUser!;

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
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildAvailableTab(context, taskProvider),
          _buildMyTasksTab(context, user),
          _buildReviewTab(context, taskProvider),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pushNamed(context, AppRouter.createTask),
        icon: const Icon(Icons.add),
        label: const Text('Create Task'),
      ),
    );
  }

  Widget _buildAvailableTab(BuildContext context, TaskProvider provider) =>
      ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: provider.tasks.length,
        itemBuilder: (ctx, i) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: TaskCardWidget(task: provider.tasks[i])),
      );

  Widget _buildMyTasksTab(BuildContext context, UserModel user) => Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text('Tasks Created: ${user.tasksCreated}',
              style: const TextStyle(fontSize: 18)),
          Text('Tasks Completed: ${user.tasksCompleted}',
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
                Text(proof.submittedLink,
                    style: const TextStyle(color: AppTheme.textSecondary)),
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
