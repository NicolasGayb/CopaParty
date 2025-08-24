import 'package:flutter/material.dart';
import '../services/firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/participant_card.dart';

class PartyScreen extends StatelessWidget {
  final String partyId;
  final FirebaseService firebaseService = FirebaseService();

  PartyScreen({required this.partyId});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      appBar: AppBar(title: Text('Copa Party - Festa')),
      body: StreamBuilder<QuerySnapshot>(
        stream: firebaseService.getParticipants(partyId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

          final participants = snapshot.data!.docs;
          participants.sort((a, b) => b['cups'].compareTo(a['cups']));

          return ListView.builder(
            itemCount: participants.length,
            itemBuilder: (context, index) {
              final participant = participants[index];
              return ParticipantCard(
                name: participant['name'],
                cups: participant['cups'],
                rank: index,
                isCurrentUser: participant.id == user.uid,
                onIncrement: () => firebaseService.incrementCups(partyId, user.uid),
              );
            },
          );
        },
      ),
    );
  }
}
