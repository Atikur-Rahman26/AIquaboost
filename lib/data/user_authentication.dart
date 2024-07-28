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
      return _auth.currentUser;
    } catch (e) {
      print("Error creating account: $e");
      return null;
    }
  }

  Future<bool?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      return false;
    }
  }

  Future<bool> signInWithGoogle() async {
    try {
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

        if (userData.exists) {
          print(userData.id);
          return true;
        } else {
          // User has not signed up, restrict access
          await _auth.signOut();
          return false;
        }
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> signUpWithGoogle() async {
    bool firebaseOk = false;
    bool firestoreOk = false;
    try {
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
        print("uid: ${user.uid}");
        print("name: ${user.displayName}");
        print("email: ${user.email}");
        print("phone: ${user.phoneNumber}");
        print("photo: ${user.photoURL}");
        UserInfoData userInfoData = UserInfoData(
            userID: user.uid,
            full_name: user.displayName!,
            email: user.email!,
            phone_number: "xxxxxxxxxxxxx",
            preference: "N/A",
            role: "N/A",
            age: "NF",
            user_profile_photo: user.photoURL!);
        try {
          await _database
              .child('users/personal_info/${userInfoData.userID}')
              .set({
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

        return true;
      }

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
