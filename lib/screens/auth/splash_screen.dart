import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/routes/app_router.dart';
import '../../core/providers/app_providers.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      Navigator.pushReplacementNamed(context, userProvider.isLoggedIn ? AppRouter.main : AppRouter.welcome);
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Container(
      width: double.infinity,
      decoration: BoxDecoration(gradient: LinearGradient(
        begin: Alignment.topLeft, end: Alignment.bottomRight,
        colors: [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.secondary])),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
            child: Icon(Icons.trending_up_rounded, size: 80, color: Theme.of(context).colorScheme.primary)),
          const SizedBox(height: 32),
          const Text('Creator Growth', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text('Grow Together, Succeed Faster', style: TextStyle(color: Colors.white.withValues(alpha: 0.9), fontSize: 16)),
          const SizedBox(height: 64),
          const CircularProgressIndicator(color: Colors.white),
        ],
      ),
    ),
  );
}
