import 'dart:io';

import 'package:aiquaboost/domain/message.dart';
import 'package:aiquaboost/screens/user_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ChattingServicesData {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();
  final Reference _storageReference = FirebaseStorage.instance.ref();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Map<String, dynamic>>> getChattingListStreamRealtimeDatabase(
      {required String userID}) {
    return _database.child('ChattingLists/$userID').onValue.map((event) {
      final snapshotValue = event.snapshot.value;

      if (snapshotValue == null) {
        print('No data in snapshot');
        return [];
      }

      // Initialize an empty list to manually add maps
      List<Map<String, dynamic>> result = [];

      // Ensure the data is a Map
      if (snapshotValue is Map) {
        final data = Map<dynamic, dynamic>.from(snapshotValue);

        // Manually add each map to the result list
        data.values.forEach((value) {
          if (value is Map) {
            result
                .add(Map<String, dynamic>.from(value as Map<dynamic, dynamic>));
          } else {
            print('Unexpected value format: $value');
          }
        });
      } else {
        print('Unexpected data format: $snapshotValue');
      }

      return result;
    });
  }

  Stream<List<Map<String, dynamic>>> getChattingListStreamRealtimeDatabaseTemp(
      {required String userID}) {
    return _database.child('ChattingListsTemp/').onValue.map((event) {
      final snapshotValue = event.snapshot.value;

      if (snapshotValue == null) {
        print('No data in snapshot');
        return [];
      }

      // Initialize an empty list to manually add maps
      List<Map<String, dynamic>> result = [];

      // Ensure the data is a Map
      if (snapshotValue is Map) {
        final data = Map<dynamic, dynamic>.from(snapshotValue);

        // Manually add each map to the result list
        data.values.forEach((value) {
          if (value is Map) {
            if (value['userID'] != Profile.userInfoData!.userID) {
              result.add(
                  Map<String, dynamic>.from(value as Map<dynamic, dynamic>));
            }
          } else {
            print('Unexpected value format: $value');
          }
        });
      } else {
        print('Unexpected data format: $snapshotValue');
      }

      return result;
    });
  }

  Future<void> sendMessage(
      {required String receiverId,
      required String message,
      required String image,
      required bool uploadedPhoto}) async {
    final myUserID = Profile.userInfoData!.userID;
    bool firebaseOk = false;
    bool firestoreOk = false;
    String uniqueCId = getIndividualId();
    final Timestamp timestamp = Timestamp.now();
    List<String> ids = [myUserID, receiverId];
    ids.sort();
    String chatRoomID = ids.join('_');

    if (uploadedPhoto) {
      String imageFileName =
          'chatting_to_friend/${myUserID}/${receiverId}/${uniqueCId}.jpg';
      await _storageReference.child(imageFileName).putFile(File(image));

      // Get the download URL of the image
      image = await _storageReference.child(imageFileName).getDownloadURL();
    }
    //uploading personal info to firebase
    try {
      Message newMessage = Message(
          senderId: myUserID,
          receiverId: receiverId,
          message: message,
          messagePhoto: image,
          timeStamp: timestamp,
          messageID: uniqueCId);
      await _firestore
          .collection('chat_rooms')
          .doc(chatRoomID)
          .collection('messages')
          .add(newMessage.toMap());
      firestoreOk = true;
    } on FirebaseException catch (e) {
      firestoreOk = false;
    }
  }

  Stream<QuerySnapshot> getMessagesStream(String myUserID, String receiverId) {
    List<String> ids = [myUserID, receiverId];
    ids.sort();
    String chatRoomID = ids.join('_');
    return _firestore
        .collection('chat_rooms')
        .doc(chatRoomID)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}

String getIndividualId() {
  print(DateTime.now());
  int year = DateTime.now().year;

  int month = DateTime.now().month;

  int day = DateTime.now().day;

  int hour = DateTime.now().hour;
  int minute = DateTime.now().minute;

  int second = DateTime.now().second;

  var total_time = year * 10000000000 +
      month * 100000000 +
      day * 1000000 +
      hour * 10000 +
      minute * 100 +
      second;

  String time = '${total_time}';
  print(time);
  return time;
}
