import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user_model.dart';
import '../models/task_model.dart';
import '../models/community_model.dart';
import '../services/dummy_data.dart';

class UserProvider extends ChangeNotifier {
  UserModel? _currentUser;
  bool get isLoggedIn => _currentUser != null;
  UserModel? get currentUser => _currentUser;

  void login(UserModel user) {
    _currentUser = user;
    notifyListeners();
  }

  void logout() {
    _currentUser = null;
    notifyListeners();
  }

  void updateUser(UserModel user) {
    _currentUser = user;
    notifyListeners();
  }

  void addCredits(int c) {
    if (_currentUser != null) {
      _currentUser = _currentUser!.copyWith(
          credits: _currentUser!.credits + c,
          creditsEarned: _currentUser!.creditsEarned + c);
      notifyListeners();
    }
  }

  void spendCredits(int c) {
    if (_currentUser != null) {
      _currentUser = _currentUser!.copyWith(
          credits: _currentUser!.credits - c,
          creditsSpent: _currentUser!.creditsSpent + c);
      notifyListeners();
    }
  }

  void addPoints(int p) {
    if (_currentUser != null) {
      _currentUser = _currentUser!.copyWith(points: _currentUser!.points + p);
      notifyListeners();
    }
  }

  void completeTask() {
    if (_currentUser != null) {
      _currentUser = _currentUser!
          .copyWith(tasksCompleted: _currentUser!.tasksCompleted + 1);
      notifyListeners();
    }
  }

  void createTask() {
    if (_currentUser != null) {
      _currentUser =
          _currentUser!.copyWith(tasksCreated: _currentUser!.tasksCreated + 1);
      notifyListeners();
    }
  }
}

class TaskProvider extends ChangeNotifier {
  List<TaskModel> _tasks = [];
  List<TaskProofModel> _pendingProofs = [];
  List<TaskModel> get tasks => _tasks;
  List<TaskProofModel> get pendingProofs => _pendingProofs;

  TaskProvider() {
    loadTasks();
    loadProofs();
  }
  void loadTasks() {
    _tasks = DummyData.tasks;
    notifyListeners();
  }

  void loadProofs() {
    _pendingProofs = DummyData.pendingProofs;
    notifyListeners();
  }

  void addTask(TaskModel t) {
    _tasks.insert(0, t);
    notifyListeners();
  }

  void submitProof(String taskId, String link) {
    notifyListeners();
  }

  void approveProof(String id) {
    _pendingProofs.removeWhere((p) => p.id == id);
    notifyListeners();
  }

  void rejectProof(String id) {
    _pendingProofs.removeWhere((p) => p.id == id);
    notifyListeners();
  }
}

class CommunityProvider extends ChangeNotifier {
  List<CommunityModel> _communities = [];
  List<PostModel> _posts = [];
  List<CommunityModel> get communities => _communities;
  List<PostModel> get posts => _posts;

  CommunityProvider() {
    loadCommunities();
    loadPosts();
  }
  void loadCommunities() {
    _communities = DummyData.communities;
    notifyListeners();
  }

  void loadPosts() {
    _posts = DummyData.posts;
    notifyListeners();
  }

  void toggleLikePost(String id) {
    notifyListeners();
  }
}

class NotificationProvider extends ChangeNotifier {
  List<NotificationModel> _notifications = [];
  List<NotificationModel> get notifications => _notifications;
  int get unreadCount => _notifications.where((n) => !n.isRead).length;

  NotificationProvider() {
    loadNotifications();
  }
  void loadNotifications() {
    _notifications = DummyData.notifications;
    notifyListeners();
  }

  void markAsRead(String id) {
    notifyListeners();
  }

  void markAllAsRead() {
    notifyListeners();
  }
}

class ChatProvider extends ChangeNotifier {
  List<ChatModel> _chats = [];
  List<ChatModel> get chats => _chats;

  ChatProvider() {
    loadChats();
  }
  void loadChats() {
    _chats = DummyData.chats;
    notifyListeners();
  }

  List<MessageModel> getMessages(String chatId) =>
      DummyData.getMessages(chatId);
  void sendMessage(String chatId, String content, String senderId) {
    notifyListeners();
  }
}

class AppProviders {
  static final providers = [
    ChangeNotifierProvider(
        create: (_) => UserProvider()..login(DummyData.currentUser)),
    ChangeNotifierProvider(create: (_) => TaskProvider()),
    ChangeNotifierProvider(create: (_) => CommunityProvider()),
    ChangeNotifierProvider(create: (_) => NotificationProvider()),
    ChangeNotifierProvider(create: (_) => ChatProvider()),
  ];
}
