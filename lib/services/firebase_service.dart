import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

class FirebaseService {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<User?> signInAnonymously() async {
    final result = await auth.signInAnonymously();
    return result.user;
  }

  Future<String> createParty(String name) async {
    String id = Uuid().v4();
    String code = Uuid().v4().substring(0, 6).toUpperCase();
    await firestore.collection('parties').doc(id).set({
      'name': name,
      'hostId': auth.currentUser!.uid,
      'code': code,
      'createdAt': FieldValue.serverTimestamp()
    });
    await addParticipant(id, auth.currentUser!.uid, "Você");
    return id;
  }

  Future<String?> joinParty(String code, String userId, String name) async {
    var query = await firestore.collection('parties').where('code', isEqualTo: code).get();
    if (query.docs.isEmpty) return null;
    String partyId = query.docs.first.id;
    await addParticipant(partyId, userId, name);
    return partyId;
  }

  Future<void> addParticipant(String partyId, String userId, String name) async {
    await firestore.collection('parties').doc(partyId)
        .collection('participants').doc(userId).set({
      'name': name,
      'cups': 0,
    });
  }

  Future<void> incrementCups(String partyId, String userId) async {
    final doc = firestore.collection('parties').doc(partyId)
        .collection('participants').doc(userId);
    final snapshot = await doc.get();
    int cups = snapshot['cups'] ?? 0;
    await doc.update({'cups': cups + 1});
  }

  Stream<QuerySnapshot> getParticipants(String partyId) {
    return firestore.collection('parties').doc(partyId)
        .collection('participants')
        .orderBy('cups', descending: true)
        .snapshots();
  }
}
