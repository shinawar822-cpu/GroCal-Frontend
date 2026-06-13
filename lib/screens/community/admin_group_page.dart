import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../core/services/dummy_data.dart';
import '../../core/routes/app_router.dart';
import '../../core/models/community_model.dart';

class AdminGroupPage extends StatefulWidget {
  const AdminGroupPage({super.key});

  @override
  State<AdminGroupPage> createState() => _AdminGroupPageState();
}

class _AdminGroupPageState extends State<AdminGroupPage> {
  late List<GroupMessageModel> messages;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    messages = DummyData.getGroupMessages(DummyData.platformAdminGroup.id);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  void _scrollToBottom() {
    if (!_scrollController.hasClients) return;

    Future.microtask(() {
      if (_scrollController.hasClients && mounted) {
        _scrollController.jumpTo(
          _scrollController.position.maxScrollExtent,
        );
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) return 'now';
    if (difference.inHours < 1) return '${difference.inMinutes}m ago';
    if (difference.inDays < 1) return '${difference.inHours}h ago';
    if (difference.inDays < 7) return '${difference.inDays}d ago';

    return '${dateTime.month}/${dateTime.day}/${dateTime.year}';
  }

  @override
  Widget build(BuildContext context) {
    final adminGroup = DummyData.platformAdminGroup;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Creator Growth Guidance'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          // HEADER
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppTheme.primaryColor,
                  AppTheme.primaryColor.withOpacity(0.7),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    adminGroup.image,
                    width: double.infinity,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  adminGroup.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  adminGroup.description,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.people, color: Colors.white70, size: 16),
                    const SizedBox(width: 6),
                    Text(
                      '${adminGroup.memberIds.length} members',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'Official',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // MESSAGES
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: messages.length,
              itemBuilder: (ctx, i) {
                final msg = messages[i];
                final isAdmin = msg.senderId == 'admin';

                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundImage: msg.senderImage != null
                            ? NetworkImage(msg.senderImage!)
                            : null,
                        child: msg.senderImage == null
                            ? Icon(
                                isAdmin ? Icons.shield : Icons.person,
                                color: Colors.white,
                              )
                            : null,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: isAdmin
                                    ? AppTheme.primaryColor.withOpacity(0.1)
                                    : AppTheme.backgroundColor,
                                borderRadius: BorderRadius.circular(12),
                                border: isAdmin
                                    ? Border.all(
                                        color:
                                            AppTheme.primaryColor.withOpacity(0.3),
                                      )
                                    : null,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        msg.senderName,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: isAdmin
                                              ? AppTheme.primaryColor
                                              : Colors.black,
                                        ),
                                      ),
                                      if (isAdmin) ...[
                                        const SizedBox(width: 6),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 6,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: AppTheme.primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: const Text(
                                            'Admin',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 9,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    msg.content,
                                    style: const TextStyle(fontSize: 13),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              _formatTime(msg.createdAt),
                              style: const TextStyle(
                                color: AppTheme.textSecondary,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // FOOTER INFO
          Container(
            padding: const EdgeInsets.all(16),
            color: AppTheme.primaryColor.withOpacity(0.05),
            child: const Row(
              children: [
                Icon(Icons.info, color: AppTheme.primaryColor, size: 18),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'This is an official platform group. Messages from the admin contain important guidance and announcements.',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppTheme.primaryColor,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}