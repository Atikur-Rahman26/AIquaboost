import 'dart:io';

import 'package:aiquaboost/domain/user_academic_data.dart';
import 'package:aiquaboost/domain/user_address_data.dart';
import 'package:aiquaboost/domain/user_experience_data.dart';
import 'package:aiquaboost/domain/user_info_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UserDataUploading {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();
  final Reference _storageReference = FirebaseStorage.instance.ref();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> uploadUserData(
    UserInfoData userInfoData,
    bool uploadedPhoto,
  ) async {
    bool firebaseOk = false;
    bool firestoreOk = false;

    if (uploadedPhoto) {
      String imageFileName = 'user_profile/${userInfoData.userID}.jpg';
      await _storageReference
          .child(imageFileName)
          .putFile(File(userInfoData.user_profile_photo));

      // Get the download URL of the image
      String imageUrl =
          await _storageReference.child(imageFileName).getDownloadURL();
      userInfoData.user_profile_photo = imageUrl;
    }
    //uploading personal info to firebase
    try {
      await _database.child('users/personal_info/${userInfoData.userID}').set({
        'userID': userInfoData.userID,
        'user_profile_photo': userInfoData.user_profile_photo,
        'full_name': userInfoData.full_name,
        'email': userInfoData.email,
        'phone_number': userInfoData.phone_number,
        'age': userInfoData.age, // Store the image URL
        'preference': userInfoData.preference, // Store the image URL
        'role': userInfoData.role, // Store the image URL
      });
      firestoreOk = true;
    } on FirebaseException catch (e) {
      firestoreOk = false;
    }

    try {
      await _firestore
          .collection('users_personal_info')
          .doc(userInfoData.userID)
          .set({
        'userID': userInfoData.userID,
        'user_profile_photo': userInfoData.user_profile_photo,
        'full_name': userInfoData.full_name,
        'email': userInfoData.email,
        'phone_number': userInfoData.phone_number,
        'age': userInfoData.age,
        'preference': userInfoData.preference,
        'role': userInfoData.role,
      });
      firestoreOk = true;
    } on FirebaseException catch (e) {
      firestoreOk = false;
    }

    if (firestoreOk && firebaseOk) {
      return true;
    }
    return false;
  }

  Future<bool> uploadUserAddress(
    UserAddressData userAddressData,
  ) async {
    bool firebaseOk = false;
    bool firestoreOk = false;

    //address adding
    try {
      await _database
          .child(
              'users/addresses/${userAddressData.userID}/${'AD' + userAddressData.addressID}')
          .set({
        'userID': userAddressData.userID,
        'addressID': 'AD' + userAddressData.addressID,
        'house': userAddressData.house,
        'road': userAddressData.road,
        'village_or_town': userAddressData.village_or_town,
        'upzilla_or_thana': userAddressData.upzilla_or_thana,
        'district': userAddressData.district,
        'division': userAddressData.division,
      });
      firestoreOk = true;
    } on FirebaseException catch (e) {
      firestoreOk = false;
    }

    try {
      await _firestore
          .collection('users_addresses_data')
          .doc(userAddressData.userID + 'AD' + userAddressData.addressID)
          .set({
        'userID': userAddressData.userID,
        'addressID': 'AD' + userAddressData.addressID,
        'house': userAddressData.house,
        'road': userAddressData.road,
        'village_or_town': userAddressData.village_or_town,
        'upzilla_or_thana': userAddressData.upzilla_or_thana,
        'district': userAddressData.district,
        'division': userAddressData.division,
      });
      firestoreOk = true;
    } on FirebaseException catch (e) {
      firestoreOk = false;
    }

    if (firestoreOk && firebaseOk) {
      return true;
    }
    return false;
  }

  Future<bool> uploadUserAcademicDetails(
    UserAcademicData userAcademicData,
  ) async {
    bool firebaseOk = false;
    bool firestoreOk = false;

    //address adding
    try {
      await _database
          .child(
              'users/academics/${userAcademicData.userID}/${'AC' + userAcademicData.academicID}')
          .set({
        'userID': userAcademicData.userID,
        'academicID': 'AC' + userAcademicData.academicID,
        'institute': userAcademicData.institute,
        'degree_or_exam': userAcademicData.degree_or_exam,
        'grade_or_marks': userAcademicData.grade_or_marks,
        'passing_year': userAcademicData.passing_year,
      });
      firestoreOk = true;
    } on FirebaseException catch (e) {
      firestoreOk = false;
    }

    try {
      await _firestore
          .collection('users_academic_data')
          .doc(userAcademicData.userID + 'AC' + userAcademicData.academicID)
          .set({
        'userID': userAcademicData.userID,
        'academicID': 'AC' + userAcademicData.academicID,
        'institute': userAcademicData.institute,
        'degree_or_exam': userAcademicData.degree_or_exam,
        'grade_or_marks': userAcademicData.grade_or_marks,
        'passing_year': userAcademicData.passing_year,
      });
      firestoreOk = true;
    } on FirebaseException catch (e) {
      firestoreOk = false;
    }

    if (firestoreOk && firebaseOk) {
      return true;
    }
    return false;
  }

  Future<bool> uploadUserExeperiences(
    UserExperienceData userExperienceData,
  ) async {
    bool firebaseOk = false;
    bool firestoreOk = false;

    //address adding
    try {
      await _database
          .child(
              'users/experiences/${userExperienceData.userID}/${'EX' + userExperienceData.experienceID}')
          .set({
        'userID': userExperienceData.userID,
        'experienceID': 'EX' + userExperienceData.experienceID,
        'designation': userExperienceData.designation,
        'institute': userExperienceData.institute,
        'location': userExperienceData.location,
        'joining_date': userExperienceData.joining_date,
        'last_date_of_this_office': userExperienceData.last_date_of_this_office,
      });
      firestoreOk = true;
    } on FirebaseException catch (e) {
      firestoreOk = false;
    }

    try {
      await _firestore
          .collection('users_experience_data')
          .doc(userExperienceData.userID +
              'EX' +
              userExperienceData.experienceID)
          .set({
        'userID': userExperienceData.userID,
        'experienceID': 'EX' + userExperienceData.experienceID,
        'designation': userExperienceData.designation,
        'institute': userExperienceData.institute,
        'location': userExperienceData.location,
        'joining_date': userExperienceData.joining_date,
        'last_date_of_this_office': userExperienceData.last_date_of_this_office,
      });
      firestoreOk = true;
    } on FirebaseException catch (e) {
      firestoreOk = false;
    }

    if (firestoreOk && firebaseOk) {
      return true;
    }
    return false;
  }
}
