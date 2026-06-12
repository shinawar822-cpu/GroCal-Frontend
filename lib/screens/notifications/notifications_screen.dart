import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/providers/app_providers.dart';
import '../../core/theme/app_theme.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NotificationProvider>(context);
    final notifications = provider.notifications;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          TextButton(onPressed: () => provider.markAllAsRead(), child: const Text('Mark all read')),
        ],
      ),
      body: notifications.isEmpty
        ? const Center(child: Text('No notifications'))
        : ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: notifications.length,
          itemBuilder: (ctx, i) {
            final n = notifications[i];
            return Card(
              color: n.isRead ? null : AppTheme.primaryColor.withValues(alpha: 0.05),
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                onTap: () => provider.markAsRead(n.id),
                leading: Container(
                  width: 44, height: 44,
                  decoration: BoxDecoration(color: AppTheme.primaryColor, borderRadius: BorderRadius.circular(12)),
                  child: Icon(_getIcon(n.type), color: Colors.white),
                ),
                title: Text(n.title, style: TextStyle(fontWeight: n.isRead ? FontWeight.normal : FontWeight.bold)),
                subtitle: Text(n.message, maxLines: 2),
                trailing: n.isRead ? null : Container(width: 8, height: 8, decoration: const BoxDecoration(color: AppTheme.primaryColor, shape: BoxShape.circle)),
              ),
            );
          },
        ),
    );
  }

  IconData _getIcon(String type) => switch (type) {
    'follow' => Icons.person_add,
    'task_reward' => Icons.stars,
    'comment' => Icons.comment,
    _ => Icons.notifications,
  };
}
