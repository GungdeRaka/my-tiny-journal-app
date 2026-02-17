import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_tiny_journal/providers/auth_provider.dart';
import 'package:my_tiny_journal/providers/journal_provider.dart';
import 'package:my_tiny_journal/screens/home_screen.dart';
import 'package:my_tiny_journal/screens/login_screen.dart';
import 'package:my_tiny_journal/statics/app_theme.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart'; // File ini otomatis dibuat oleh langkah 2 tadi

void main() async {
  // 1. Pastikan engine Flutter siap sebelum jalankan kode async
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Nyalakan Firebase sesuai konfigurasi platform (Android/iOS)
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) =>FirebaseAuthProvider()),
        ChangeNotifierProvider(create: (_) =>JournalProvider())
      ],
      child: MaterialApp(
        title: 'My Tiny Journal',
        theme: ThemeData(appBarTheme: AppBarTheme(backgroundColor: AppColors.background,)),
        home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return HomeScreen();
            } 
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator(),);
            }
            return LoginScreen();
          },
        ), 
        
        
    ));
  }
}
