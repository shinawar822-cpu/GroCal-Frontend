import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/providers/app_providers.dart';
import '../../core/utils/constants.dart';
import '../../core/theme/app_theme.dart';
import '../../core/models/task_model.dart';

class CreateTaskScreen extends StatefulWidget {
  const CreateTaskScreen({super.key});
  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  final _titleController = TextEditingController();
  final _linkController = TextEditingController();
  String _taskType = 'Watch Video';
  String _platform = 'YouTube';
  String _niche = 'Technology';
  int _reward = 10;
  int _verificationReward = 3;
  int _participants = 50;

  int get _totalCost => (_reward + _verificationReward) * _participants;

  @override
  void dispose() { _titleController.dispose(); _linkController.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.currentUser!;
    final canAfford = user.credits >= _totalCost;

    return Scaffold(
      appBar: AppBar(title: const Text('Create Task')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(gradient: const LinearGradient(colors: [AppTheme.primaryColor, AppTheme.secondaryColor]), borderRadius: BorderRadius.circular(16)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    const Text('Available Credits', style: TextStyle(color: Colors.white70, fontSize: 12)),
                    Text('${user.credits}', style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
                  ]),
                  const Icon(Icons.account_balance_wallet, color: Colors.white, size: 40),
                ],
              ),
            ),
            const SizedBox(height: 24),
            TextField(controller: _titleController, decoration: const InputDecoration(labelText: 'Task Title', prefixIcon: Icon(Icons.title))),
            const SizedBox(height: 16),
            DropdownButtonFormField(
              initialValue: _taskType,
              decoration: const InputDecoration(labelText: 'Task Type', prefixIcon: Icon(Icons.category)),
              items: AppConstants.taskTypes.map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
              onChanged: (v) => setState(() => _taskType = v!),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField(
              initialValue: _platform,
              decoration: const InputDecoration(labelText: 'Platform', prefixIcon: Icon(Icons.devices)),
              items: AppConstants.platforms.map((p) => DropdownMenuItem(value: p, child: Text(p))).toList(),
              onChanged: (v) => setState(() => _platform = v!),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField(
              initialValue: _niche,
              decoration: const InputDecoration(labelText: 'Niche', prefixIcon: Icon(Icons.label)),
              items: AppConstants.niches.map((n) => DropdownMenuItem(value: n, child: Text(n))).toList(),
              onChanged: (v) => setState(() => _niche = v!),
            ),
            const SizedBox(height: 16),
            TextField(controller: _linkController, decoration: const InputDecoration(labelText: 'Task Link', prefixIcon: Icon(Icons.link))),
            const SizedBox(height: 24),
            Text('Reward Settings', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      const Text('Reward/User'),
                      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                        IconButton(icon: const Icon(Icons.remove), onPressed: _reward > 5 ? () => setState(() => _reward -= 5) : null),
                        Text('$_reward', style: Theme.of(context).textTheme.titleLarge),
                        IconButton(icon: const Icon(Icons.add), onPressed: _reward < 100 ? () => setState(() => _reward += 5) : null),
                      ]),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      const Text('Verification'),
                      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                        IconButton(icon: const Icon(Icons.remove), onPressed: _verificationReward > 1 ? () => setState(() => _verificationReward--) : null),
                        Text('$_verificationReward', style: Theme.of(context).textTheme.titleLarge),
                        IconButton(icon: const Icon(Icons.add), onPressed: _verificationReward < 10 ? () => setState(() => _verificationReward++) : null),
                      ]),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text('Participants: $_participants'),
            Slider(value: _participants.toDouble(), min: 10, max: 500, divisions: 49, onChanged: (v) => setState(() => _participants = v.round())),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: AppTheme.backgroundColor, borderRadius: BorderRadius.circular(12)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total Cost', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('$_totalCost Credits', style: TextStyle(color: canAfford ? AppTheme.successColor : AppTheme.errorColor, fontWeight: FontWeight.bold, fontSize: 18)),
                ],
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity, height: 56,
              child: ElevatedButton(
                onPressed: canAfford ? () {
                  userProvider.spendCredits(_totalCost);
                  final task = TaskModel(
                    id: 'task_${DateTime.now().millisecondsSinceEpoch}',
                    title: _titleController.text, description: '', taskType: _taskType, platform: _platform, niche: _niche,
                    taskLink: _linkController.text, thumbnail: 'https://images.pexels.com/photos/607812/pexels-photo-607812.jpeg?w=400',
                    reward: _reward, verificationReward: _verificationReward, participantsNeeded: _participants,
                    creatorId: user.id, creatorName: user.fullName, creatorImage: user.profileImage, createdAt: DateTime.now(),
                  );
                  Provider.of<TaskProvider>(context, listen: false).addTask(task);
                  userProvider.createTask();
                  Navigator.pop(context);
                } : null,
                child: Text(canAfford ? 'Create Task' : 'Insufficient Credits'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
