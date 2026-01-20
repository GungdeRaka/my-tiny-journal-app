import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // File ini otomatis dibuat oleh langkah 2 tadi

void main() async {
  // 1. Pastikan engine Flutter siap sebelum jalankan kode async
  WidgetsFlutterBinding.ensureInitialized();
  
  // 2. Nyalakan Firebase sesuai konfigurasi platform (Android/iOS)
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Tiny Journal',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      // Sementara kita tampilkan Scaffold kosong dulu untuk cek error
      home: Scaffold(
        appBar: AppBar(title: const Text("Setup Ready!")),
        body: const Center(
          child: Text("Firebase sudah terhubung ✅"),
        ),
      ),
    );
  }
}