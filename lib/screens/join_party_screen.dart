import 'package:flutter/material.dart';
import '../services/firebase_service.dart';
import 'party_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';

class JoinPartyScreen extends StatelessWidget {
  final TextEditingController _codeController = TextEditingController();
  final FirebaseService firebaseService = FirebaseService();

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: AppBar(title: Text('Entrar em Festa')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: _codeController, decoration: InputDecoration(labelText: 'Código da Festa')),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Entrar'),
              onPressed: () async {
                String? partyId = await firebaseService.joinParty(_codeController.text, user.uid, "Você");
                if (partyId != null) {
                  Fluttertoast.showToast(msg: 'Entrou na festa!');
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => PartyScreen(partyId: partyId)));
                } else {
                  Fluttertoast.showToast(msg: 'Código inválido!');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
