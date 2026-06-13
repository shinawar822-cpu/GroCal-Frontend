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
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    if (_formKey.currentState?.validate() ?? false) {
      Provider.of<UserProvider>(context, listen: false)
          .login(DummyData.currentUser);
      Navigator.pushReplacementNamed(context, AppRouter.main);
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
            leading: BackButton(
                onPressed: () =>
                    Navigator.pushNamed(context, AppRouter.welcome))),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Welcome Back!',
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                const Text('Sign in to continue',
                    style: TextStyle(color: AppTheme.textSecondary)),
                const SizedBox(height: 40),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                      labelText: 'Email', prefixIcon: Icon(Icons.email)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is required';
                    }
                    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+\$')
                        .hasMatch(value)) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                      labelText: 'Password', prefixIcon: Icon(Icons.lock)),
                  obscureText: true,
                  validator: (value) => value == null || value.isEmpty
                      ? 'Password is required'
                      : null,
                ),
                const SizedBox(height: 24),
                SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                        onPressed: _login, child: const Text('Login'))),
                const SizedBox(height: 16),
                TextButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, AppRouter.register),
                    child: const Text("Don't have an account? Sign Up")),
              ],
            ),
          ),
        ),
      );
}
