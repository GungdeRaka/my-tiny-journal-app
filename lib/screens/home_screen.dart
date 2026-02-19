import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_tiny_journal/models/journal_model.dart';
import 'package:my_tiny_journal/providers/journal_provider.dart';
import 'package:my_tiny_journal/services/auth_service.dart';
import 'package:provider/provider.dart';
import '../widgets/journal_card.dart';
import 'add_journal_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    final journalProvider = Provider.of<JournalProvider>(
      context,
      listen: false,
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Tiny Journal"),
        actions: [
          IconButton(
            onPressed: () async {
              await AuthService().signOut();
            },
            icon: const Icon(Icons.logout_outlined, size: 24.0),
          ),
        ],
      ),
      body: StreamBuilder<List<JournalModel>>(
        stream: journalProvider.getJournals(currentUser?.uid ?? ''),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(
                "Error: ${snapshot.error}",
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.red[400],
                ),
              ),
            );
          }
          final journals = snapshot.data ?? [];
          if (journals.isEmpty) {
            return Center(
              child: Text("No journals yet, add your first journal!"),
            );
          }
          return ListView.builder(
            itemCount: journals.length,
            itemBuilder: (context, index) {
              final journal = journals[index];
              return JournalCard(journal: journal);
            },
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.note_alt_rounded),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddJournalScreen()),
          );
        },
      ),
    );
  }
}
