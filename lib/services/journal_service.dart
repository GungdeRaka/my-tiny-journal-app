import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_tiny_journal/models/journal_model.dart';

class JournalService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'journals';

  Future<void> addJournal(JournalModel journalData) async {
    try {
      await _firestore.collection(_collection).add(journalData.toMap());
    } catch (e) {
      rethrow;
    }
  }

  Stream<List<JournalModel>> getJournal(String userId) {
    return _firestore
        .collection(_collection)
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => JournalModel.fromSnapshot(doc))
              .toList(),
        );
  }
}
