import 'package:flutter/material.dart';
import 'package:my_tiny_journal/models/journal_model.dart';
import 'package:my_tiny_journal/providers/journal_provider.dart';
import 'package:provider/provider.dart';

import '../screens/add_journal_screen.dart';

class JournalCard extends StatelessWidget {
  final JournalModel journal;
  const JournalCard({super.key, required this.journal});

  @override
  Widget build(BuildContext context) {
    final date = journal.createdAt;
    final dateString =
        "${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}";
    return Card(
      child: ListTile(
        title: Text(
          journal.title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4.0),
            Text(journal.content, maxLines: 2, overflow: TextOverflow.ellipsis),
            const SizedBox(height: 8.0),
            Text(
              dateString,
              style: TextStyle(fontSize: 8.0, color: Colors.green[600]),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              style: IconButton.styleFrom(backgroundColor: Colors.blue[100]),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AddJournalScreen(journalToEdit: journal),
                  ),
                );
              },
              icon: const Icon(Icons.edit, size: 24.0, color: Colors.blue),
            ),
            const SizedBox(width: 4.0),
            IconButton(
              style: IconButton.styleFrom(backgroundColor: Colors.red[100]),
              onPressed: () async {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Hapus Jurnal?"),
                      content: const Text(
                        "Jurnal ini akan hilang selamanya loh.",
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: Text("Cancel"),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: Text(
                            "Delete",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    );
                  },
                );
                if (confirm == true && context.mounted) {
                  final provider = Provider.of<JournalProvider>(
                    context,
                    listen: false,
                  );
                  provider.deleteJournal(journal.id);
                  final succeed = await provider.deleteJournal(journal.id);
                  if (succeed && context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Succeed to delete journal!")),
                    );
                  }
                }
              },
              icon: const Icon(Icons.delete, color: Colors.red, size: 24.0),
            ),
          ],
        ),
        isThreeLine: true,
      ),
    );
  }
}
