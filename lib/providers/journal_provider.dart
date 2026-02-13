import 'package:flutter/material.dart';
import 'package:my_tiny_journal/models/journal_model.dart';
import '../services/journal_service.dart';

class JournalProvider extends ChangeNotifier {
  final JournalService _journalService;

  JournalProvider({JournalService? service})
    : _journalService = service ?? JournalService();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Stream<List<JournalModel>> getJournals(String userId) {
    return _journalService.getJournal(userId);
  }

  Future<bool> addJournal({
    required String userId,
    required String title,
    required String content,
  }) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();
    try {
      final newJournal = JournalModel(
        id: '',
        userId: userId,
        title: title,
        content: content,
        createdAt: DateTime.now(),
      );
      await _journalService.addJournal(newJournal);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }
}
