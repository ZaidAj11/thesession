import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/tunes/tuneInfo.dart';

class FireStoreService {
  static final user = FirebaseAuth.instance.currentUser;
  static final _db = FirebaseFirestore.instance;
  static Map<String, dynamic> LikesMap = {};

  static Future<bool> getLikedTunes() async {
    var docRef = _db.collection('users').doc(user!.uid);
    bool isReady = await docRef.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        LikesMap = data["likes"] as Map<String, dynamic>;
        return true;
      },
      onError: (e) => print("Error getting document: $e"),
    );
    return isReady;
  }

  _getCurrentUserDocs() {}

  static Future likePost(int tuneId, int settingId) async {
    var settingIds = LikesMap[tuneId.toString()] as List<dynamic>;

    if (settingIds.contains(settingId))
      settingIds.remove(settingId);
    else
      settingIds.add(settingId);

    LikesMap[tuneId.toString()] = settingIds;
    var docRef = _db.collection('users').doc(user!.uid);
    bool isReady = await docRef.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        data["likes"] = LikesMap;
        docRef.set(data, SetOptions(merge: true));
        return true;
      },
      onError: (e) => print("Error getting document: $e"),
    );
  }
}
