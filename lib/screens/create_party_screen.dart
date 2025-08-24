import 'package:flutter/material.dart';
import '../services/firebase_service.dart';
import 'party_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CreatePartyScreen extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final FirebaseService firebaseService = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Criar Festa')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: _nameController, decoration: InputDecoration(labelText: 'Nome da Festa')),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Criar Festa'),
              onPressed: () async {
                String partyId = await firebaseService.createParty(_nameController.text);
                Fluttertoast.showToast(msg: 'Festa criada!');
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => PartyScreen(partyId: partyId)));
              },
            ),
          ],
        ),
      ),
    );
  }
}
