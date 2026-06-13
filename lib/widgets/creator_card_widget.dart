import 'package:flutter/material.dart';
import '../core/models/user_model.dart';
import '../core/theme/app_theme.dart';
import '../core/routes/app_router.dart';

class CreatorCardWidget extends StatelessWidget {
  final UserModel creator;
  const CreatorCardWidget({super.key, required this.creator});

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(12)),
        child: Row(
          children: [
            InkWell(
              onTap: () => Navigator.pushNamed(context, AppRouter.profile,
                  arguments: {'user': creator}),
              child: CircleAvatar(
                  radius: 24,
                  backgroundImage: creator.profileImage != null
                      ? NetworkImage(creator.profileImage!)
                      : null),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: InkWell(
                onTap: () => Navigator.pushNamed(context, AppRouter.profile,
                    arguments: {'user': creator}),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Text(creator.fullName,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      if (creator.isVerified) ...[
                        const SizedBox(width: 4),
                        const Icon(Icons.verified,
                            size: 14, color: AppTheme.primaryColor)
                      ],
                    ]),
                    Text('@${creator.username.replaceAll('@', '')}',
                        style: const TextStyle(
                            color: AppTheme.textSecondary, fontSize: 12)),
                    Text(creator.niche,
                        style: const TextStyle(
                            color: AppTheme.textHint, fontSize: 11)),
                  ],
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 8)),
                child: const Text('Follow')),
          ],
        ),
      );
}
