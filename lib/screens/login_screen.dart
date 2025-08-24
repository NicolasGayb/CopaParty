import 'package:flutter/material.dart';
import 'home_screen.dart';
import '../services/firebase_service.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatelessWidget {
  final FirebaseService firebaseService = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text('Entrar Anonimamente'),
          onPressed: () async {
            await firebaseService.signInAnonymously();
            Fluttertoast.showToast(msg: 'Login realizado!');
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen()));
          },
        ),
      ),
    );
  }
}
