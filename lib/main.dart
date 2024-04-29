import 'package:app_crud/firebase_options.dart';
import 'package:app_crud/project1/add.dart';
import 'package:app_crud/project1/update.dart';
import 'package:app_crud/project1/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
      debugShowCheckedModeBanner: false,
      title: 'demo',
      routes: {
        '/': (context) => const Homepage(),
        '/add': (context) => const AddUsers(),
        '/update': (context) => const UpdateDonor(),
      },
      initialRoute: '/',
    );
  }
}
