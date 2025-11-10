import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final displayNameController = TextEditingController();
  final photoUrlController = TextEditingController();
  bool loading = false;

  final user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    displayNameController.text = user?.displayName ?? '';
    photoUrlController.text = user?.photoURL ?? '';
  }

  @override
  void dispose() {
    displayNameController.dispose();
    photoUrlController.dispose();
    super.dispose();
  }

  Future<void> updateProfile() async {
    setState(() => loading = true);

    try {
      await user?.updateDisplayName(displayNameController.text.trim());
      await user?.updatePhotoURL(photoUrlController.text.trim());
      await user?.reload(); // reload user data

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Profile updated successfully!")),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? e.code)),
      );
    } finally {
      if (mounted) setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: displayNameController,
                decoration: InputDecoration(
                  hintText: "Display Name",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: photoUrlController,
                decoration: InputDecoration(
                  hintText: "Profile Photo URL",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 20),
              loading
                  ? const CircularProgressIndicator()
                  : SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: updateProfile,
                        child: const Text("Update Profile"),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
