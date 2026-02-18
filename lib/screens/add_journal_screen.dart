import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_tiny_journal/providers/journal_provider.dart';
import 'package:provider/provider.dart';

class AddJournalScreen extends StatefulWidget {
  const AddJournalScreen({super.key});

  @override
  State<AddJournalScreen> createState() => _AddJournalScreenState();
}

class _AddJournalScreenState extends State<AddJournalScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add new note"), actions: const []),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  label: Text("Title"),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please give title to your new note!";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20.0),
              Expanded(
                child: TextFormField(
                  controller: _contentController,
                  maxLines: null,
                  minLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(
                    label: Text("Write your note here"),
                    border: OutlineInputBorder(),
                    alignLabelWithHint: true,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Let's write something in your note!";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
      floatingActionButton: Consumer<JournalProvider>(
        builder: (context, journalProvider, child) {
          return FloatingActionButton(
            child: Icon(Icons.check),
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                final user = FirebaseAuth.instance.currentUser;

                if (user == null) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text("User not found!")));
                  return;
                }
                final success = await journalProvider.addJournal(
                  userId: user.uid,
                  title: _titleController.text,
                  content: _contentController.text,
                );

                if (success && context.mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Succeed to add new journal! ✅")),
                  );
                } else if (context.mounted){
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(journalProvider.errorMessage ?? "Failed to save new journal!")),
                  );
                }
              }
            },
          );
        },
      ),
    );
  }
}
