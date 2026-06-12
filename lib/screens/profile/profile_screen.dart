import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/providers/app_providers.dart';
import '../../core/theme/app_theme.dart';
import '../../core/routes/app_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).currentUser!;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [
                  AppTheme.primaryColor,
                  AppTheme.secondaryColor
                ])),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                          radius: 50,
                          backgroundImage: user.profileImage != null
                              ? NetworkImage(user.profileImage!)
                              : null),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(user.fullName,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold)),
                          if (user.isVerified) ...[
                            const SizedBox(width: 8),
                            const Icon(Icons.verified, color: Colors.white)
                          ]
                        ],
                      ),
                      Text('@${user.username.replaceAll('@', '')}',
                          style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.8))),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 6),
                        decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(16)),
                        child: Text(user.level,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            actions: [
              IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () =>
                      Navigator.pushNamed(context, AppRouter.settingsRoute)),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStat(context, user.followers, 'Followers'),
                      _buildStat(context, user.following, 'Following'),
                      _buildStat(context, user.points, 'Points'),
                      _buildStat(context, user.tasksCompleted, 'Tasks'),
                    ],
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () =>
                          Navigator.pushNamed(context, AppRouter.editProfile),
                      icon: const Icon(Icons.edit),
                      label: const Text('Edit Profile'),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: AppTheme.backgroundColor,
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Achievements',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            _buildBadge(context, 'Early Adopter', true),
                            _buildBadge(context, 'First Task', true),
                            _buildBadge(context, 'Pro Reviewer',
                                user.reviewerTrustLevel >= 2),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStat(BuildContext context, int value, String label) =>
      Column(children: [
        Text(_formatNum(value),
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.bold)),
        Text(label,
            style:
                const TextStyle(color: AppTheme.textSecondary, fontSize: 12)),
      ]);

  Widget _buildBadge(BuildContext context, String title, bool unlocked) =>
      Padding(
        padding: const EdgeInsets.only(right: 12),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: unlocked ? AppTheme.primaryColor : AppTheme.textLight,
                  shape: BoxShape.circle),
              child:
                  const Icon(Icons.emoji_events, color: Colors.white, size: 20),
            ),
            const SizedBox(height: 4),
            Text(title,
                style: TextStyle(
                    fontSize: 10,
                    color:
                        unlocked ? AppTheme.textPrimary : AppTheme.textHint)),
          ],
        ),
      );

  String _formatNum(int n) =>
      n >= 1000 ? '${(n / 1000).toStringAsFixed(1)}K' : n.toString();
}
