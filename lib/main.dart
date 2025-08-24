import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(CopaPartyApp());
}

class CopaPartyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Copa Party',
      theme: ThemeData(primarySwatch: Colors.red),
      home: LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
