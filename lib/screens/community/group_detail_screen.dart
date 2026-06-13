import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../core/services/dummy_data.dart';
import '../../core/routes/app_router.dart';
import '../../core/models/community_model.dart';

class GroupDetailScreen extends StatefulWidget {
  final String groupId;
  final String groupName;

  const GroupDetailScreen({
    super.key,
    required this.groupId,
    required this.groupName,
  });

  @override
  State<GroupDetailScreen> createState() => _GroupDetailScreenState();
}

class _GroupDetailScreenState extends State<GroupDetailScreen> {
  final TextEditingController _messageController = TextEditingController();
  late List<GroupMessageModel> messages;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    messages = DummyData.getGroupMessages(widget.groupId);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    final newMessage = GroupMessageModel(
      id: 'gmsg_${DateTime.now().millisecondsSinceEpoch}',
      groupId: widget.groupId,
      senderId: 'user_1',
      senderName: 'You',
      content: _messageController.text.trim(),
      senderImage:
          'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?w=150',
      createdAt: DateTime.now(),
    );

    setState(() {
      messages.add(newMessage);
      _messageController.clear();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
        }
      });
    });
  }

  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) {
      return 'now';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inDays < 1) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return '${dateTime.month}/${dateTime.day}/${dateTime.year}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.groupName),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: messages.length,
              itemBuilder: (ctx, i) {
                final msg = messages[i];
                final isCurrentUser = msg.senderId == 'user_1';

                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    mainAxisAlignment: isCurrentUser
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                    children: [
                      if (!isCurrentUser) ...[
                        CircleAvatar(
                          backgroundImage: msg.senderImage != null
                              ? NetworkImage(msg.senderImage!)
                              : null,
                          radius: 18,
                          child: msg.senderImage == null
                              ? const Icon(Icons.person, size: 18)
                              : null,
                        ),
                        const SizedBox(width: 8),
                      ],
                      Flexible(
                        child: Column(
                          crossAxisAlignment: isCurrentUser
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          children: [
                            if (!isCurrentUser) ...[
                              Text(msg.senderName,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11)),
                              const SizedBox(height: 4),
                            ],
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: isCurrentUser
                                    ? AppTheme.primaryColor
                                    : AppTheme.backgroundColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(msg.content,
                                  style: TextStyle(
                                    color: isCurrentUser
                                        ? Colors.white
                                        : AppTheme.textPrimary,
                                    fontSize: 13,
                                  )),
                            ),
                            const SizedBox(height: 4),
                            Text(_formatTime(msg.createdAt),
                                style: const TextStyle(
                                    color: AppTheme.textSecondary,
                                    fontSize: 10)),
                          ],
                        ),
                      ),
                      if (isCurrentUser) ...[
                        const SizedBox(width: 8),
                        CircleAvatar(
                          backgroundImage: msg.senderImage != null
                              ? NetworkImage(msg.senderImage!)
                              : null,
                          radius: 18,
                          child: msg.senderImage == null
                              ? const Icon(Icons.person, size: 18)
                              : null,
                        ),
                      ],
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: AppTheme.backgroundColor)),
              color: Colors.white,
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      hintStyle: const TextStyle(color: AppTheme.textSecondary),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide(color: AppTheme.backgroundColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: const BorderSide(color: AppTheme.primaryColor),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                    ),
                    maxLines: null,
                  ),
                ),
                const SizedBox(width: 12),
                CircleAvatar(
                  backgroundColor: AppTheme.primaryColor,
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white, size: 18),
                    onPressed: _sendMessage,
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