import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:my_tiny_journal/providers/auth_provider.dart';
import 'package:my_tiny_journal/services/auth_service.dart';
import 'package:my_tiny_journal/services/journal_service.dart';

@GenerateMocks([AuthService,JournalService])
import 'auth_provider_test.mocks.dart';

void main() {
  late FirebaseAuthProvider authProvider;
  late MockAuthService mockAuthService;

  setUp(() {
    // 1. Siapkan Service Palsu
    mockAuthService = MockAuthService();
    // 2. Masukkan Service Palsu ke Provider
    authProvider = FirebaseAuthProvider(service: mockAuthService);
  });

  test('Login Sukses: isLoading harus true lalu false, dan return true', () async {
    // ARRANGE (Siapkan Skenario)
    // "Hei Service Palsu, kalau nanti signIn dipanggil, pura-pura sukses ya (return null)"
    when(mockAuthService.signIn(any, any)).thenAnswer((_) async{});

    // ACT (Lakukan Aksi)
    // Kita panggil fungsi login, tapi jangan ditunggu (await) dulu biar bisa cek loading
    final futureLogin = authProvider.signIn('test@email.com', 'password');

    // ASSERT (Cek Hasil)
    // 1. Cek apakah saat proses berjalan, loading nyala?
    expect(authProvider.isLoading, true);

    // 2. Tunggu proses selesai
    final result = await futureLogin;

    // 3. Cek hasil akhirnya
    expect(result, true); // Harus return true
    expect(authProvider.isLoading, false); // Loading harus mati lagi

    // 4. Pastikan service palsu benar-benar dipanggil 1 kali
    verify(mockAuthService.signIn('test@email.com', 'password')).called(1);
  });

  test('Login Gagal: isLoading harus false dan errorMessage terisi', () async {
    // ARRANGE
    // "Hei Service Palsu, kalau signIn dipanggil, lempar error ya!"
    when(mockAuthService.signIn(any, any)).thenThrow('Password salah');

    // ACT
    final result = await authProvider.signIn('test@email.com', 'salah');

    // ASSERT
    expect(result, false); // Harus return false
    expect(authProvider.isLoading, false);
    expect(authProvider.errorMessage, 'Password salah');
  });

  test('Logout: pastikan memanggil user logout', () async {
    when(mockAuthService.signOut()).thenAnswer((_) async {});

    await authProvider.signOut();

    // memastikan bahwa fungsi signOut pada service terpanggil
    verify(mockAuthService.signOut()).called(1);
  });
}
