import 'package:flutter/material.dart';
import '../../core/routes/app_router.dart';
import '../../core/theme/app_theme.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const Spacer(),
                Icon(Icons.trending_up_rounded,
                    size: 80, color: Theme.of(context).colorScheme.primary),
                const SizedBox(height: 24),
                const Text('Creator Growth',
                    style:
                        TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                const Text('Grow Together, Succeed Faster',
                    style:
                        TextStyle(color: AppTheme.textSecondary, fontSize: 16)),
                const SizedBox(height: 48),
                _buildFeature(
                    context, Icons.people_outline, 'Network with Creators'),
                _buildFeature(
                    context, Icons.task_alt_outlined, 'Complete Growth Tasks'),
                _buildFeature(context, Icons.star_outline, 'Earn Rewards'),
                const Spacer(),
                SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, AppRouter.login),
                        child: const Text('Login'))),
                const SizedBox(height: 16),
                SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: OutlinedButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, AppRouter.register),
                        child: const Text('Create Account'))),
              ],
            ),
          ),
        ),
      );

  Widget _buildFeature(BuildContext context, IconData icon, String text) =>
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(children: [
          Icon(icon, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 16),
          Text(text, style: const TextStyle(fontSize: 16)),
        ]),
      );
}
