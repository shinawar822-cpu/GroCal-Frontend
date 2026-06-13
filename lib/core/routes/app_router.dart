import 'package:flutter/material.dart';
import '../../screens/auth/splash_screen.dart';
import '../../screens/auth/welcome_screen.dart';
import '../../screens/auth/login_screen.dart';
import '../../screens/auth/register_screen.dart';
import '../../screens/home/main_screen.dart';
import '../../screens/discover/discover_screen.dart';
import '../../screens/discover/niche_page.dart';
import '../../screens/community/community_screen.dart';
import '../../screens/community/community_detail_screen.dart';
import '../../screens/tasks/tasks_screen.dart';
import '../../screens/tasks/create_task_screen.dart';
import '../../screens/tasks/task_detail_screen.dart';
import '../../screens/tasks/submit_proof_screen.dart';
import '../../screens/profile/profile_screen.dart';
import '../models/user_model.dart';
import '../../screens/profile/edit_profile_screen.dart';
import '../../screens/notifications/notifications_screen.dart';
import '../../screens/settings/settings_screen.dart';
import '../../screens/settings/credit_history_screen.dart';
import '../../screens/messaging/messages_screen.dart';
import '../../screens/messaging/chat_screen.dart';

class AppRouter {
  static const String splash = '/',
      welcome = '/welcome',
      login = '/login',
      register = '/register';
  static const String main = '/main',
      discover = '/discover',
      nichePage = '/niche',
      community = '/community',
      tasks = '/tasks',
      profile = '/profile';
  static const String createTask = '/create-task',
      taskDetail = '/task-detail',
      submitProof = '/submit-proof';
  static const String communityDetail = '/community-detail',
      editProfile = '/edit-profile',
      settingsRoute = '/settings';
  static const String creditHistory = '/credit-history',
      messages = '/messages',
      chat = '/chat',
      notifications = '/notifications';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments as Map<String, dynamic>?;
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case welcome:
        return MaterialPageRoute(builder: (_) => const WelcomeScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case main:
        return MaterialPageRoute(builder: (_) => const MainScreen());
      case discover:
        return MaterialPageRoute(builder: (_) => const DiscoverScreen());
      case nichePage:
        return MaterialPageRoute(
            builder: (_) => NichePage(niche: args?['niche'] ?? 'All'));
      case community:
        return MaterialPageRoute(builder: (_) => const CommunityScreen());
      case communityDetail:
        return MaterialPageRoute(
            builder: (_) =>
                CommunityDetailScreen(communityId: args?['communityId'] ?? ''));
      case tasks:
        return MaterialPageRoute(builder: (_) => const TasksScreen());
      case createTask:
        return MaterialPageRoute(builder: (_) => const CreateTaskScreen());
      case taskDetail:
        return MaterialPageRoute(
            builder: (_) => TaskDetailScreen(taskId: args?['taskId'] ?? ''));
      case submitProof:
        return MaterialPageRoute(
            builder: (_) => SubmitProofScreen(taskId: args?['taskId'] ?? ''));
      case profile:
        final UserModel? userArg = args?['user'] as UserModel?;
        final String? userIdArg = args?['userId'] as String?;
        return MaterialPageRoute(
            builder: (_) => ProfileScreen(user: userArg, userId: userIdArg));
      case editProfile:
        return MaterialPageRoute(builder: (_) => const EditProfileScreen());
      case notifications:
        return MaterialPageRoute(builder: (_) => const NotificationsScreen());
      case settingsRoute:
        return MaterialPageRoute(builder: (_) => const SettingsScreen());
      case creditHistory:
        return MaterialPageRoute(builder: (_) => const CreditHistoryScreen());
      case messages:
        return MaterialPageRoute(builder: (_) => const MessagesScreen());
      case chat:
        return MaterialPageRoute(
            builder: (_) => ChatScreen(
                chatId: args?['chatId'] ?? '',
                userName: args?['userName'] ?? ''));
      default:
        return MaterialPageRoute(
            builder: (_) =>
                const Scaffold(body: Center(child: Text('Page not found'))));
    }
  }
}
