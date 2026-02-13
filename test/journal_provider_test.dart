import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:my_tiny_journal/models/journal_model.dart';
import 'package:my_tiny_journal/providers/journal_provider.dart';
import 'package:my_tiny_journal/services/journal_service.dart';

// Import file mock yang digenerate
import 'auth_provider_test.mocks.dart'; 
// Catatan: Jika kamu menaruh @GenerateMocks di file lain, sesuaikan importnya. 
// Saran: Lebih rapi jika @GenerateMocks dikumpulkan di satu file khusus atau di test masing-masing.
// Untuk kemudahan, anggap kita pakai file mocks yang sama.

void main() {
  late JournalProvider journalProvider;
  late MockJournalService mockJournalService;

  setUp(() {
    mockJournalService = MockJournalService();
    journalProvider = JournalProvider(service: mockJournalService);
  });

  // Data Dummy untuk test
  final dummyJournals = [
    JournalModel(
      id: '1', 
      userId: 'user1', 
      title: 'Hari ini Coding', 
      content: 'Seru banget!', 
      createdAt: DateTime.now()
    ),
  ];

  group('JournalProvider Test', () {
    
    // TEST 1: Fungsi Future (Tambah Jurnal)
    // Ini mirip test Login sebelumnya
    test('addJournal sukses: harus return true & loading false', () async {
      // ARRANGE
      // Karena addJournal return void di Service, kita pakai thenAnswer((_) async => null)
      when(mockJournalService.addJournal(any)).thenAnswer((_) async => null);

      // ACT
      final futureResult = journalProvider.addJournal(
        userId: 'user1', title: 'Judul', content: 'Isi'
      );

      // ASSERT
      expect(journalProvider.isLoading, true); // Cek loading nyala
      
      final result = await futureResult;
      
      expect(result, true); // Sukses
      expect(journalProvider.isLoading, false); // Loading mati
    });

    // TEST 2: Fungsi Stream (Ambil Data) -> INI YANG BARU!
    test('getJournals: harus memancarkan (emit) data list journal', () {
      // ARRANGE
      // Kita harus memalsukan "Aliran Data".
      // Stream.value(...) adalah cara membuat stream palsu yang langsung mengirim data.
      when(mockJournalService.getJournal('user1'))
          .thenAnswer((_) => Stream.value(dummyJournals));

      // ACT
      final streamResult = journalProvider.getJournals('user1');

      // ASSERT
      // Kita pakai 'expectLater' karena stream butuh waktu.
      // 'emitsInOrder' memastikan data yang keluar urutannya benar.
      expectLater(
        streamResult, 
        emitsInOrder([
          dummyJournals, // Harapan: Keluar data dummyJournals
          // emitsDone, // (Opsional) Jika stream selesai
        ])
      );
    });
  });
}