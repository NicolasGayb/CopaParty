import 'package:flutter/material.dart';
import 'create_party_screen.dart';
import 'join_party_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Copa Party')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text('Criar Festa'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => CreatePartyScreen()));
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Entrar em Festa'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => JoinPartyScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
