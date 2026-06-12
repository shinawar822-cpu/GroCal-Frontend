import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/providers/app_providers.dart';
import '../../core/theme/app_theme.dart';

class SubmitProofScreen extends StatefulWidget {
  final String taskId;
  const SubmitProofScreen({super.key, required this.taskId});

  @override
  State<SubmitProofScreen> createState() => _SubmitProofScreenState();
}

class _SubmitProofScreenState extends State<SubmitProofScreen> {
  final _linkController = TextEditingController();

  @override
  void dispose() { _linkController.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final task = Provider.of<TaskProvider>(context).tasks.firstWhere((t) => t.id == widget.taskId);

    return Scaffold(
      appBar: AppBar(title: const Text('Submit Proof')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Task: ${task.title}', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text('Reward: ${task.reward} credits', style: const TextStyle(color: AppTheme.accentColor, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            TextField(
              controller: _linkController,
              decoration: const InputDecoration(
                labelText: 'Proof Link',
                prefixIcon: Icon(Icons.link),
                hintText: 'https://...',
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: AppTheme.infoColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
              child: Text('Your submission will be reviewed. You will receive ${task.reward} credits upon approval.', style: const TextStyle(color: AppTheme.infoColor, fontSize: 12)),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity, height: 56,
              child: ElevatedButton(
                onPressed: () {
                  Provider.of<UserProvider>(context, listen: false).addPoints(task.reward);
                  Provider.of<UserProvider>(context, listen: false).completeTask();
                  Provider.of<TaskProvider>(context, listen: false).submitProof(widget.taskId, _linkController.text);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Proof submitted! ${task.reward} credits will be added after review.')));
                  Navigator.pop(context);
                },
                child: const Text('Submit Proof'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
