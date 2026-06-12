import 'package:flutter/material.dart';
import '../core/models/community_model.dart';
import '../core/theme/app_theme.dart';
import '../core/routes/app_router.dart';

class CommunityCardWidget extends StatelessWidget {
  final CommunityModel community;
  final double? width;
  const CommunityCardWidget({super.key, required this.community, this.width});

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => Navigator.pushNamed(context, AppRouter.communityDetail,
            arguments: {'communityId': community.id}),
        child: Container(
          width: width,
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(12)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(12)),
                child: Stack(
                  children: [
                    Image.network(community.image,
                        height: 80, width: double.infinity, fit: BoxFit.cover),
                    Positioned(
                        bottom: 8,
                        left: 8,
                        child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                                color: Colors.black54,
                                borderRadius: BorderRadius.circular(4)),
                            child: Row(children: [
                              const Icon(Icons.people,
                                  size: 12, color: Colors.white),
                              const SizedBox(width: 4),
                              Text('${community.membersCount}',
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 11))
                            ]))),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(community.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        maxLines: 1),
                    const SizedBox(height: 4),
                    Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                            color: AppTheme.primaryColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(4)),
                        child: Text(community.category,
                            style: const TextStyle(
                                fontSize: 10, color: AppTheme.primaryColor))),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
