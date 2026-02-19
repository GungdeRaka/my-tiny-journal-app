import 'package:flutter/material.dart';
import 'package:my_tiny_journal/models/journal_model.dart';

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
        isThreeLine: true,
      ),
    );
  }
}
