import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/providers/app_providers.dart';
import '../../core/utils/constants.dart';
import '../../core/theme/app_theme.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});
  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _nameController;
  late TextEditingController _bioController;
  String _niche = 'Technology';

  @override
  void initState() {
    super.initState();
    final user = Provider.of<UserProvider>(context, listen: false).currentUser!;
    _nameController = TextEditingController(text: user.fullName);
    _bioController = TextEditingController(text: user.bio);
    _niche = user.niche;
  }

  @override
  void dispose() { _nameController.dispose(); _bioController.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Edit Profile'),
      actions: [
        TextButton(onPressed: () {
          final userProvider = Provider.of<UserProvider>(context, listen: false);
          final user = userProvider.currentUser!;
          userProvider.updateUser(user.copyWith(fullName: _nameController.text, bio: _bioController.text, niche: _niche));
          Navigator.pop(context);
        }, child: const Text('Save')),
      ],
    ),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Center(child: Stack(
            children: [
              CircleAvatar(radius: 60, child: Icon(Icons.person, size: 60)),
              Positioned(bottom: 0, right: 0, child: CircleAvatar(radius: 18,
                backgroundColor: AppTheme.primaryColor, child: Icon(Icons.camera_alt, color: Colors.white, size: 18))),
            ],
          )),
          const SizedBox(height: 24),
          TextField(controller: _nameController, decoration: const InputDecoration(labelText: 'Name', prefixIcon: Icon(Icons.person))),
          const SizedBox(height: 16),
          TextField(controller: _bioController, decoration: const InputDecoration(labelText: 'Bio', prefixIcon: Icon(Icons.edit)), maxLines: 3),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            initialValue: _niche,
            decoration: const InputDecoration(labelText: 'Niche', prefixIcon: Icon(Icons.label)),
            items: AppConstants.niches.map((n) => DropdownMenuItem(value: n, child: Text(n))).toList(),
            onChanged: (v) => setState(() => _niche = v!),
          ),
        ],
      ),
    ),
  );
}
