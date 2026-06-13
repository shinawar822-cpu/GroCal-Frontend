import '../models/user_model.dart';
import '../models/task_model.dart';
import '../models/community_model.dart';

class DummyData {
  static UserModel get currentUser => UserModel(
        id: 'user_1',
        fullName: 'Alex Johnson',
        username: '@alexj',
        email: 'alex@example.com',
        bio: 'Content Creator | Tech Enthusiast',
        profileImage:
            'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?w=150',
        niche: 'Technology',
        country: 'United States',
        platforms: ['YouTube', 'Instagram'],
        level: 'Creator Pro',
        followers: 12500,
        following: 890,
        points: 2350,
        credits: 485,
        creditsSpent: 320,
        creditsEarned: 805,
        tasksCompleted: 47,
        tasksCreated: 12,
        totalReviews: 89,
        reviewerTrustLevel: 2,
        isReviewer: true,
        isVerified: true,
        createdAt: DateTime(2024, 1, 15),
      );

  static List<UserModel> get suggestedCreators => [
        UserModel(
            id: 'user_2',
            fullName: 'Sarah Chen',
            username: '@sarahchen',
            email: 'sarah@example.com',
            bio: 'Tech YouTuber',
            niche: 'Technology',
            country: 'Canada',
            platforms: ['YouTube'],
            followers: 45000,
            profileImage:
                'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?w=150',
            level: 'Growth Master',
            isVerified: true,
            createdAt: DateTime(2023, 6, 20)),
        UserModel(
            id: 'user_3',
            fullName: 'Mike Rivera',
            username: '@mikecreative',
            email: 'mike@example.com',
            bio: 'Gaming Creator',
            niche: 'Gaming',
            country: 'United States',
            platforms: ['TikTok', 'YouTube'],
            followers: 89000,
            profileImage:
                'https://images.pexels.com/photos/1222271/pexels-photo-1222271.jpeg?w=150',
            level: 'Elite Creator',
            isVerified: true,
            createdAt: DateTime(2022, 3, 10)),
      ];

  static List<TaskModel> get tasks => [
        TaskModel(
            id: 'task_1',
            title: 'Watch My Latest Tech Review Video',
            description: 'Watch my comprehensive review of the new iPhone.',
            category: 'Promotion',
            taskType: 'Watch Video',
            platform: 'YouTube',
            niche: 'Technology',
            taskLink: 'https://youtube.com/watch?v=abc123',
            thumbnail:
                'https://images.pexels.com/photos/607812/pexels-photo-607812.jpeg?w=400',
            reward: 15,
            verificationReward: 3,
            participantsNeeded: 100,
            participantsCompleted: 67,
            creatorId: 'user_2',
            creatorName: 'Sarah Chen',
            creatorImage:
                'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?w=150',
            isVerified: true,
            createdAt: DateTime.now().subtract(const Duration(days: 2))),
        TaskModel(
            id: 'task_2',
            title: 'Follow My Gaming Channel',
            description: 'Subscribe for amazing gaming content!',
            category: 'Growth',
            taskType: 'Follow User',
            platform: 'YouTube',
            niche: 'Gaming',
            taskLink: 'https://youtube.com/@gamingchannel',
            thumbnail:
                'https://images.pexels.com/photos/442576/pexels-photo-442576.jpeg?w=400',
            reward: 10,
            verificationReward: 2,
            participantsNeeded: 200,
            participantsCompleted: 145,
            creatorId: 'user_3',
            creatorName: 'Mike Rivera',
            creatorImage:
                'https://images.pexels.com/photos/1222271/pexels-photo-1222271.jpeg?w=150',
            isVerified: true,
            createdAt: DateTime.now().subtract(const Duration(days: 1))),
      ];

  static List<TaskProofModel> get pendingProofs => [
        TaskProofModel(
            id: 'proof_1',
            taskId: 'task_1',
            userId: 'user_6',
            userName: 'Lisa Park',
            userImage:
                'https://images.pexels.com/photos/1542085/pexels-photo-1542085.jpeg?w=150',
            submittedLink: 'https://youtube.com/watch?v=abc123',
            status: 'pending',
            submittedAt: DateTime.now().subtract(const Duration(hours: 2))),
      ];

  static List<CommunityModel> get communities => [
        CommunityModel(
            id: 'community_1',
            name: 'Tech Creators Hub',
            description: 'A community for technology content creators.',
            image:
                'https://images.pexels.com/photos/1714208/pexels-photo-1714208.jpeg?w=400',
            category: 'Technology',
            membersCount: 3450,
            postsCount: 892,
            isJoined: true,
            createdAt: DateTime(2023, 1, 15)),
        CommunityModel(
            id: 'community_2',
            name: 'Gaming Legends',
            description: 'Connect with fellow gaming enthusiasts.',
            image:
                'https://images.pexels.com/photos/442576/pexels-photo-442576.jpeg?w=400',
            category: 'Gaming',
            membersCount: 8900,
            postsCount: 2340,
            isJoined: true,
            createdAt: DateTime(2022, 8, 20)),
      ];

  static List<PostModel> get posts => [
        PostModel(
            id: 'post_1',
            communityId: 'community_1',
            userId: 'user_2',
            userName: 'Sarah Chen',
            userImage:
                'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?w=150',
            content:
                'Just hit 50K subscribers!\n\n1. Consistency is key\n2. Engage with your audience\n3. Study your analytics',
            likesCount: 234,
            commentsCount: 45,
            isLiked: true,
            createdAt: DateTime.now().subtract(const Duration(hours: 2))),
      ];

  static List<ChatModel> get chats => [
        ChatModel(
            id: 'chat_1',
            userId: 'user_2',
            userName: 'Sarah Chen',
            userImage:
                'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?w=150',
            lastMessage: "Let's collaborate!",
            lastMessageTime:
                DateTime.now().subtract(const Duration(minutes: 15)),
            unreadCount: 2,
            isOnline: true),
      ];

  static List<NotificationModel> get notifications => [
        NotificationModel(
            id: 'notif_1',
            type: 'follow',
            title: 'New Follower',
            message: 'Sarah Chen started following you',
            image:
                'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?w=150',
            isRead: false,
            createdAt: DateTime.now().subtract(const Duration(minutes: 30))),
        NotificationModel(
            id: 'notif_2',
            type: 'task_reward',
            title: 'Task Completed!',
            message: 'You earned 15 credits',
            isRead: false,
            createdAt: DateTime.now().subtract(const Duration(hours: 2))),
      ];

  static List<MessageModel> getMessages(String chatId) => [
        MessageModel(
            id: 'msg_1',
            chatId: chatId,
            senderId: 'user_2',
            senderName: 'Sarah Chen',
            senderImage:
                'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?w=150',
            content: 'Hey! I saw your collab post.',
            isRead: true,
            createdAt: DateTime.now().subtract(const Duration(minutes: 30))),
        MessageModel(
            id: 'msg_2',
            chatId: chatId,
            senderId: 'user_1',
            senderName: 'You',
            content: "Hi Sarah! Let's collaborate.",
            isRead: true,
            createdAt: DateTime.now().subtract(const Duration(minutes: 25))),
      ];
}
