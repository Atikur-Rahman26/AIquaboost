import 'dart:io';

import 'package:aiquaboost/constants.dart';
import 'package:aiquaboost/domain/user_info_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

import './user_data_managing.dart';

class UserAuthenticationAndRegistration {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _database = FirebaseDatabase.instance.ref();
  final Reference _storageReference = FirebaseStorage.instance.ref();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<User?> createAccountEmailAndPassword(
      {required Map<String, dynamic> userInputsList,
      required String password}) async {
    try {
      UserCredential _userCredential =
          await _auth.createUserWithEmailAndPassword(
              email: userInputsList['email'], password: password);
      String userID = _auth.currentUser!.uid;
      UserDataUploading userDataUploading = new UserDataUploading();
      UserInfoData userInfoData = UserInfoData(
          userID: userID,
          full_name: userInputsList['full_name']!,
          email: userInputsList['email']!,
          phone_number: userInputsList['phone_number']!,
          preference: userInputsList['preference']!,
          role: userInputsList['role']!,
          age: userInputsList['age']!,
          user_profile_photo: userInputsList['user_profile_photo']!);
      userDataUploading.uploadUserData(userInfoData, true);
      User? user = _userCredential.user;
      print("point");
      if (user != null && !user.emailVerified) {
        print("Come");
        await user.sendEmailVerification();
        showToast(message: 'Sent a verification email');
      }
      return _auth.currentUser;
    } catch (e) {
      print("Error creating account: $e");
      return null;
    }
  }

  Future<void> signOutUser() async {
    // Sign out from Firebase
    await FirebaseAuth.instance.signOut();

    // Sign out from Google
    await GoogleSignIn().signOut();
  }

  Future<String?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = credential.user;

      if (user != null && !user.emailVerified) {
        // Email is not verified

        await _auth.signOut();
        return 'Please verify your email before signing in';
      }

      return 'Logged in';
    } on FirebaseAuthException catch (e) {
      return 'Failed to log in';
    }
  }

  Future<bool> signInWithGoogle() async {
    try {
      await InternetAddress.lookup('google.com');
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return false; // User canceled the sign-in
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        // Check if the user has previously signed up
        final userDoc =
            _firestore.collection('users_personal_info').doc(user.uid);
        final userData = await userDoc.get();

        if (!userData.exists) {
          // User is new, store their information in the database
          UserInfoData userInfoData = UserInfoData(
            userID: user.uid,
            full_name: user.displayName ?? '',
            email: user.email ?? '',
            phone_number: "xxxxxxxxxxxxx",
            preference: "N/A",
            role: "N/A",
            age: "NF",
            user_profile_photo: user.photoURL ?? '',
          );

          try {
            await _database
                .child('users/personal_info/${userInfoData.userID}')
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
          } on FirebaseException catch (e) {
            return false;
          }
        }
        return true;
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
