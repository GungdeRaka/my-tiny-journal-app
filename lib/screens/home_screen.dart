import 'package:flutter/material.dart';
import 'package:my_tiny_journal/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Tiny Journal"),
        actions: [
          IconButton(
            onPressed: () {
              context.read<FirebaseAuthProvider>().signOut();
            },
            icon: const Icon(Icons.logout_outlined, size: 24.0),
          ),
        ],
      ),
      body: Center(child: const Column(children: [])),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.note_add_outlined),
        onPressed: () {
          //
        },
      ),
    );
  }
}
