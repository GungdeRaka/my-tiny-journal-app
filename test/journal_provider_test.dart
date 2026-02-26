import 'package:flutter_test/flutter_test.dart';

import 'package:mockito/mockito.dart';
import 'package:my_tiny_journal/models/journal_model.dart';
import 'package:my_tiny_journal/providers/journal_provider.dart';


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
      when(mockJournalService.addJournal(any)).thenAnswer((_) async {});

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

  // test 3 Update journal

  test("Test 3: berhasil update journal, return true, ubah loading", () async {
    when(mockJournalService.updateJournal(any, any, any)).thenAnswer((_)async{});
    final futureResult = journalProvider.updateJournal(id: '123', title: "New Title", content: "New content");

    expect(journalProvider.isLoading, true);
    final result = await futureResult;
    expect(result, true);
    expect(journalProvider.isLoading, false);
    verify(mockJournalService.updateJournal('123', 'New Title', "New content")).called(1);
  });

  test("Test 4: Delete journal, Return true, isLoading berubah", ()async{
    when(mockJournalService.deleteJournal(any)).thenAnswer((_)async{});

    final delete = journalProvider.deleteJournal('123');
    expect(journalProvider.isLoading, true);
    final deletedJournal = await delete;
    expect(deletedJournal, true);
    expect(journalProvider.isLoading, false);
    verify(mockJournalService.deleteJournal("123")).called(1);
  });
}