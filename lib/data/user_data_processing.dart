import 'package:aiquaboost/domain/user_academic_data.dart';
import 'package:aiquaboost/domain/user_address_data.dart';
import 'package:aiquaboost/domain/user_experience_data.dart';
import 'package:aiquaboost/domain/user_info_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UserDataProcessing {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();
  final Reference _storageReference = FirebaseStorage.instance.ref();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  UserInfoData? _userInfoData;
  UserExperienceData? _userExperienceData;
  UserAcademicData? _userAcademicData;
  UserAddressData? _userAddressData;

  Future<User?> getCurrentUser() async {
    return _auth.currentUser;
  }

  Future<String> getUserID() async {
    final user = _auth.currentUser;
    return user!.uid;
  }

  Future<UserInfoData?> getUserPersonalInfo() async {
    if (_userInfoData != null) {
      return _userInfoData;
    }
    final userID = await getUserID();
    if (userID != null) {
      final userDoc =
          await _firestore.collection('users_personal_info').doc(userID).get();
      if (userDoc.exists) {
        final userPersonalInfoData = userDoc.data() as Map<String, dynamic>;
        _userInfoData = UserInfoData(
          userID: userPersonalInfoData['userID'],
          full_name: userPersonalInfoData['full_name'],
          email: userPersonalInfoData['email'],
          phone_number: userPersonalInfoData['phone_number'],
          preference: userPersonalInfoData['preference'],
          role: userPersonalInfoData['role'],
          age: userPersonalInfoData['age'],
          user_profile_photo: userPersonalInfoData['user_profile_photo'],
        );
        return _userInfoData;
      }
    }
    return null;
  }

  Future<List<Map<String, String>>> getUserAddressInfo(
      {required String userID}) async {
    List<Map<String, String>> addresses = [];

    try {
      DatabaseReference ref = _database.child('users/addresses/$userID');
      DataSnapshot snapshot = await ref.get();

      if (snapshot.exists) {
        Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
        values.forEach((key, value) {
          addresses.add(Map<String, String>.from(value));
        });
      }
    } on FirebaseException catch (e) {
      print('Error getting addresses from Realtime Database: $e');
    }

    return addresses;
  }

  Future<List<Map<String, String>>> getUserAcademicInfo(
      {required String userID}) async {
    List<Map<String, String>> academics = [];

    try {
      DatabaseReference ref = _database.child('users/academics/$userID');
      DataSnapshot snapshot = await ref.get();

      if (snapshot.exists) {
        Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
        values.forEach((key, value) {
          academics.add(Map<String, String>.from(value));
        });
      }
    } on FirebaseException catch (e) {
      print('Error getting addresses from Realtime Database: $e');
    }

    return academics;
  }

  Future<List<Map<String, String>>> getFisheriesInfo(
      {required String userID}) async {
    List<Map<String, String>> fisheries = [];

    try {
      DatabaseReference ref = _database.child('users/fisheries/$userID');
      DataSnapshot snapshot = await ref.get();

      if (snapshot.exists) {
        Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
        values.forEach((key, value) {
          fisheries.add(Map<String, String>.from(value));
        });
      }
    } on FirebaseException catch (e) {
      print('Error getting addresses from Realtime Database: $e');
    }

    return fisheries;
  }

  Future<List<Map<String, String>>> getUserExperienceInfo(
      {required String userID}) async {
    List<Map<String, String>> experiences = [];

    try {
      DatabaseReference ref = _database.child('users/experiences/$userID');
      DataSnapshot snapshot = await ref.get();

      if (snapshot.exists) {
        Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
        values.forEach((key, value) {
          experiences.add(Map<String, String>.from(value));
        });
      }
    } on FirebaseException catch (e) {
      print('Error getting addresses from Realtime Database: $e');
    }

    return experiences;
  }
}
