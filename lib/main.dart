import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/routes/app_router.dart';
import 'core/providers/app_providers.dart';
import 'core/theme/app_theme.dart';

void main() => runApp(const CreatorGrowthApp());

class CreatorGrowthApp extends StatelessWidget {
  const CreatorGrowthApp({super.key});
  @override
  Widget build(BuildContext context) => MultiProvider(
    providers: AppProviders.providers,
    child: MaterialApp(
      title: 'Creator Growth',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      initialRoute: AppRouter.splash,
      onGenerateRoute: AppRouter.generateRoute,
    ),
  );
}
