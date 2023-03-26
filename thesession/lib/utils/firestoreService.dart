import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/tunes/tuneInfo.dart';

class FireStoreService {
  static final user = FirebaseAuth.instance.currentUser;
  static final _db = FirebaseFirestore.instance;
  static Map<String, dynamic> LikesMap = {};
  static Map<String, dynamic> BookmarkedTunesMap = {};

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

  static Future<bool> getBookmarkedTunes() async {
    try {
      var docRef = _db.collection('users').doc(user!.uid);
      bool isReady = await docRef.get().then(
        (DocumentSnapshot doc) {
          final data = doc.data() as Map<String, dynamic>;
          BookmarkedTunesMap = data["bookmarkedTunes"] as Map<String, dynamic>;
          return true;
        },
        onError: (e) => print("Error getting document: $e"),
      );
      return isReady;
    } catch (Exception) {
      return true;
    }
  }

  static bool checkIfLiked(int tuneId, int settingId) {
    if (LikesMap == null) return false;
    if (LikesMap.containsKey(tuneId.toString())) {
      var likedSettings = LikesMap[tuneId.toString()] as List<dynamic>;
      if (likedSettings.contains(settingId)) return true;
    }
    return false;
  }

  static bool checkIfBookmarkedTune(int tuneId, int settingId) {
    if (BookmarkedTunesMap == null) return false;
    if (BookmarkedTunesMap.containsKey(tuneId.toString())) {
      var bookMarkedTunes =
          BookmarkedTunesMap[tuneId.toString()] as List<dynamic>;
      if (bookMarkedTunes.contains(settingId)) return true;
    }
    return false;
  }

  static likePost(int tuneId, int settingId) async {
    if (LikesMap == null) LikesMap = new HashMap<String, dynamic>();
    if (!LikesMap.containsKey(tuneId.toString())) {
      LikesMap[tuneId.toString()] = [settingId];
    } else {
      var settingIds = LikesMap[tuneId.toString()] as List<dynamic>;
      if (settingIds.contains(settingId))
        settingIds.remove(settingId);
      else
        settingIds.add(settingId);

      LikesMap[tuneId.toString()] = settingIds;
    }
    removeTunesWithNoLikes();
    var docRef = _db.collection('users').doc(user!.uid);
    bool isReady = await docRef.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        data["likes"] = LikesMap;
        docRef.set(data);
        return true;
      },
      onError: (e) => print("Error getting document: $e"),
    );
  }

  static bookmarkPost(int tuneId, int settingId) async {
    if (BookmarkedTunesMap == null)
      BookmarkedTunesMap = new HashMap<String, dynamic>();
    if (!BookmarkedTunesMap.containsKey(tuneId.toString())) {
      BookmarkedTunesMap[tuneId.toString()] = [settingId];
    } else {
      var settingIds = BookmarkedTunesMap[tuneId.toString()] as List<dynamic>;
      if (settingIds.contains(settingId))
        settingIds.remove(settingId);
      else
        settingIds.add(settingId);

      BookmarkedTunesMap[tuneId.toString()] = settingIds;
    }
    removeTunesWithNoBookmarks();
    var docRef = _db.collection('users').doc(user!.uid);
    bool isReady = await docRef.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        data["bookmarkedTunes"] = BookmarkedTunesMap;
        docRef.set(data);
        return true;
      },
      onError: (e) => print("Error getting document: $e"),
    );
  }

  static void removeTunesWithNoLikes() {
    LikesMap.removeWhere((key, value) => value.isEmpty);
  }

  static void removeTunesWithNoBookmarks() {
    BookmarkedTunesMap.removeWhere((key, value) => value.isEmpty);
  }
}
