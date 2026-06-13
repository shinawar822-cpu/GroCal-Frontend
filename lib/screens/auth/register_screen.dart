import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/routes/app_router.dart';
import '../../core/providers/app_providers.dart';
import '../../core/utils/constants.dart';
import '../../core/models/user_model.dart';
import '../../core/theme/app_theme.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  String _selectedNiche = 'Technology';

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _register() {
    if (_formKey.currentState?.validate() ?? false) {
      final user = UserModel(
        id: 'user_${DateTime.now().millisecondsSinceEpoch}',
        fullName: _nameController.text,
        username: '@${_nameController.text.toLowerCase().replaceAll(' ', '')}',
        email: _emailController.text,
        niche: _selectedNiche,
        country: 'United States',
        platforms: ['YouTube'],
        level: 'Beginner',
        createdAt: DateTime.now(),
      );
      Provider.of<UserProvider>(context, listen: false).login(user);
      Navigator.pushReplacementNamed(context, AppRouter.main);
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
            leading: BackButton(
                onPressed: () =>
                    Navigator.pushNamed(context, AppRouter.welcome))),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text('Create Account',
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                const Text('Join the creator community',
                    style: TextStyle(color: AppTheme.textSecondary)),
                const SizedBox(height: 40),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                      labelText: 'Full Name', prefixIcon: Icon(Icons.person)),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Full name is required'
                      : null,
                ),
                const SizedBox(height: 16),
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
                DropdownButtonFormField<String>(
                  initialValue: _selectedNiche,
                  decoration: const InputDecoration(
                      labelText: 'Niche', prefixIcon: Icon(Icons.category)),
                  items: AppConstants.niches
                      .map((n) => DropdownMenuItem(value: n, child: Text(n)))
                      .toList(),
                  onChanged: (v) => setState(() => _selectedNiche = v!),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                      labelText: 'Password', prefixIcon: Icon(Icons.lock)),
                  obscureText: true,
                  validator: (value) => value == null || value.length < 6
                      ? 'Password must be at least 6 characters'
                      : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _confirmPasswordController,
                  decoration: const InputDecoration(
                      labelText: 'Confirm Password',
                      prefixIcon: Icon(Icons.lock_outline)),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm password';
                    }
                    if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                        onPressed: _register,
                        child: const Text('Create Account'))),
                const SizedBox(height: 16),
                TextButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, AppRouter.login),
                    child: const Text('Already have an account? Login')),
              ],
            ),
          ),
        ),
      );
}
