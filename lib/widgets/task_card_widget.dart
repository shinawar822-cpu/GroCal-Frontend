import 'package:flutter/material.dart';
import '../core/models/task_model.dart';
import '../core/theme/app_theme.dart';
import '../core/routes/app_router.dart';

class TaskCardWidget extends StatelessWidget {
  final TaskModel task;
  final double? width;
  const TaskCardWidget({super.key, required this.task, this.width});

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => Navigator.pushNamed(context, AppRouter.taskDetail,
            arguments: {'taskId': task.id}),
        child: Container(
          width: width,
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(12)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(12)),
                child: Stack(
                  children: [
                    Image.network(task.thumbnail,
                        height: 100, width: double.infinity, fit: BoxFit.cover),
                    Positioned(
                        top: 8,
                        left: 8,
                        child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                                color: _getColor(task.platform),
                                borderRadius: BorderRadius.circular(4)),
                            child: Text(task.platform,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 10)))),
                    Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                                color: Colors.black54,
                                borderRadius: BorderRadius.circular(4)),
                            child: Row(children: [
                              const Icon(Icons.stars,
                                  size: 12, color: AppTheme.accentColor),
                              const SizedBox(width: 4),
                              Text('${task.reward}',
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 12))
                            ]))),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(task.title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        CircleAvatar(
                            radius: 10,
                            backgroundImage: task.creatorImage != null
                                ? NetworkImage(task.creatorImage!)
                                : null),
                        const SizedBox(width: 8),
                        Expanded(
                            child: Text(task.creatorName,
                                style: const TextStyle(
                                    color: AppTheme.textSecondary,
                                    fontSize: 12))),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                            value: task.completionPercentage / 100,
                            backgroundColor: AppTheme.backgroundColor,
                            minHeight: 4)),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  Color _getColor(String platform) => switch (platform.toLowerCase()) {
        'youtube' => const Color(0xFFFF0000),
        'instagram' => const Color(0xFFE1306C),
        'tiktok' => Colors.black,
        _ => AppTheme.primaryColor,
      };
}
