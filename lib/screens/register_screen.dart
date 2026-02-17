import 'package:flutter/material.dart';
import 'package:my_tiny_journal/statics/app_theme.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create New Account"),
        actions: const [],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(color: Colors.blueGrey),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {},
            ),
            const SizedBox(height: 12.0),
            TextFormField(
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(color: Colors.blueGrey),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {},
            ),
            // const SizedBox(height: 12.0),
            // TextFormField(
            //   obscureText: true,
            //   decoration: const InputDecoration(
            //     labelText: 'Confirm Password',
            //     labelStyle: TextStyle(color: Colors.blueGrey),
            //     border: OutlineInputBorder(),
            //   ),
            //   onChanged: (value) {},
            // ),
            const SizedBox(height: 20.0),
            ElevatedButton.icon(
              icon: const Icon(Icons.person_add),
              label: const Text("Create account!"),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.secondary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
