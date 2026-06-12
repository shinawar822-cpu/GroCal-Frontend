import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/routes/app_router.dart';
import '../../core/providers/app_providers.dart';
import '../../core/services/dummy_data.dart';
import '../../core/theme/app_theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() { _emailController.dispose(); _passwordController.dispose(); super.dispose(); }

  void _login() => Provider.of<UserProvider>(context, listen: false).login(DummyData.currentUser);

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(leading: BackButton(onPressed: () => Navigator.pushNamed(context, AppRouter.welcome))),
    body: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Welcome Back!', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('Sign in to continue', style: TextStyle(color: AppTheme.textSecondary)),
          const SizedBox(height: 40),
          TextField(controller: _emailController, decoration: const InputDecoration(labelText: 'Email', prefixIcon: Icon(Icons.email))),
          const SizedBox(height: 16),
          TextField(controller: _passwordController, decoration: const InputDecoration(labelText: 'Password', prefixIcon: Icon(Icons.lock)), obscureText: true),
          const SizedBox(height: 24),
          SizedBox(width: double.infinity, height: 56,
            child: ElevatedButton(onPressed: () { _login(); Navigator.pushReplacementNamed(context, AppRouter.main); }, child: const Text('Login'))),
          const SizedBox(height: 16),
          TextButton(onPressed: () => Navigator.pushNamed(context, AppRouter.register), child: const Text("Don't have an account? Sign Up")),
        ],
      ),
    ),
  );
}
