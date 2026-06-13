class CommunityModel {
  final String id, name, description, image, category;
  final int membersCount, postsCount;
  final bool isJoined;
  final DateTime createdAt;
  CommunityModel(
      {required this.id,
      required this.name,
      required this.description,
      required this.image,
      required this.category,
      this.membersCount = 0,
      this.postsCount = 0,
      this.isJoined = false,
      required this.createdAt});
}

class PostModel {
  final String id, communityId, userId, userName, content;
  final String? userImage, image;
  final int likesCount, commentsCount;
  final bool isLiked, isSaved;
  final DateTime createdAt;
  PostModel(
      {required this.id,
      required this.communityId,
      required this.userId,
      required this.userName,
      required this.content,
      this.userImage,
      this.image,
      this.likesCount = 0,
      this.commentsCount = 0,
      this.isLiked = false,
      this.isSaved = false,
      required this.createdAt});
}

class CommentModel {
  final String id, postId, userId, userName, content;
  final String? userImage;
  final int likesCount;
  final DateTime createdAt;
  CommentModel(
      {required this.id,
      required this.postId,
      required this.userId,
      required this.userName,
      required this.content,
      this.userImage,
      this.likesCount = 0,
      required this.createdAt});
}

class GroupModel {
  final String id, name, description, image;
  final List<String> memberIds;
  final bool isPrivate;
  final DateTime createdAt;
  GroupModel(
      {required this.id,
      required this.name,
      required this.description,
      required this.image,
      required this.memberIds,
      this.isPrivate = false,
      required this.createdAt});
}

class GroupMessageModel {
  final String id, groupId, senderId, senderName, content;
  final String? senderImage;
  final DateTime createdAt;
  GroupMessageModel(
      {required this.id,
      required this.groupId,
      required this.senderId,
      required this.senderName,
      required this.content,
      this.senderImage,
      required this.createdAt});
}

class ChatModel {
  final String id, userId, userName, lastMessage;
  final String? userImage;
  final DateTime lastMessageTime;
  final int unreadCount;
  final bool isOnline;
  ChatModel(
      {required this.id,
      required this.userId,
      required this.userName,
      required this.lastMessage,
      required this.lastMessageTime,
      this.userImage,
      this.unreadCount = 0,
      this.isOnline = false});
}

class MessageModel {
  final String id, chatId, senderId, senderName, content;
  final String? senderImage;
  final bool isRead;
  final DateTime createdAt;
  MessageModel(
      {required this.id,
      required this.chatId,
      required this.senderId,
      required this.senderName,
      required this.content,
      this.senderImage,
      this.isRead = false,
      required this.createdAt});
}

class NotificationModel {
  final String id, type, title, message;
  final String? image;
  final bool isRead;
  final DateTime createdAt;
  NotificationModel(
      {required this.id,
      required this.type,
      required this.title,
      required this.message,
      this.image,
      this.isRead = false,
      required this.createdAt});
}
