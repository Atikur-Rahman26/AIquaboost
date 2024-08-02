import 'package:aiquaboost/data/user_authentication.dart';
import 'package:aiquaboost/data/user_data_managing.dart';
import 'package:aiquaboost/data/user_data_processing.dart';
import 'package:aiquaboost/domain/user_academic_data.dart';
import 'package:aiquaboost/domain/user_address_data.dart';
import 'package:aiquaboost/domain/user_experience_data.dart';
import 'package:aiquaboost/screens/user_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';

String getMessageOfRegistrationFieldsChecking(
    {required Map<String, String> userInputList}) {
  String message = 'Account created successfully.';
  print("from : \nfull_name: ${userInputList['full_name']!.length}"
      "\nemail:${userInputList['email']!.length}"
      "\nphone_number:${userInputList['phone_number']!.length}"
      "\nrole:${userInputList['role']!.length}"
      "\npreference:${userInputList['preference']!.length}"
      "\npassword:${userInputList['password']!.length}"
      "\nconfirm_password:${userInputList['confirm_password']!.length}");
  if (userInputList['full_name']!.length == 0 ||
      userInputList['email']!.length == 0 ||
      userInputList['phone_number']!.length == 0 ||
      userInputList['role']!.length == 0 ||
      userInputList['preference']!.length == 0 ||
      userInputList['password']!.length == 0 ||
      userInputList['confirm_password']!.length == 0) {
    message = 'No field can be left empty';
  } else if (userInputList['user_profile_photo']!.length == 0) {
    message = 'Please upload your profile picture';
  } else if (userInputList['password']!.length < 8) {
    message = 'Password should be at least 8 characters';
  } else if (userInputList['password'] != userInputList['confirm_password']) {
    message = 'Password didn\'t matched';
  } else if (userInputList['phone_number']!.length != 11) {
    message = 'Phone number must be of 11 digits';
  } else if (userInputList['phone_number']!.length == 11) {
    String temp = userInputList['phone_number']!;
    if (!isNumeric(temp)) {
      message = ('The phone number contains invalid characters.');
    }
  } else if (!isValidEmail(userInputList['email']!)) {
    message = 'Invalid email';
  }
  print(message);
  return message;
}

bool isValidEmail(String email) {
  final emailRegex =
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  return emailRegex.hasMatch(email);
}

bool isNumeric(String s) {
  final numericRegex = RegExp(r'^[0-9]+$');
  return numericRegex.hasMatch(s);
}

Future<String> getMessageForLogin({
  required String email,
  required String password,
}) async {
  if (email.isEmpty || password.isEmpty) {
    return 'No field can be left empty';
  } else if (!isValidEmail(email)) {
    return 'Invalid Email type';
  } else if (password.length < 8) {
    return 'Valid passwords have at least 8 characters';
  }

  try {
    // Sign in with email and password
    String? correct = await UserAuthenticationAndRegistration()
        .signInWithEmailAndPassword(email: email, password: password);
    return correct!;
  } on FirebaseAuthException catch (e) {
    // Handle specific FirebaseAuthException errors
    switch (e.code) {
      case 'user-not-found':
        return 'No user found for that email.';
      case 'wrong-password':
        return 'Wrong password provided for that user.';
      case 'invalid-email':
        return 'The email address is badly formatted.';
      default:
        return 'An error occurred: ${e.message}';
    }
  } catch (e) {
    return 'An unexpected error occurred: ${e.toString()}';
  }
}

Future<bool> setUsersInfo() async {
  try {
    UserDataProcessing userDataProcessing = new UserDataProcessing();
    String? userID = await userDataProcessing.getUserID();
    Profile.userInfoData = await userDataProcessing.getUserPersonalInfo();
    Profile.userAddressData =
        await userDataProcessing.getUserAddressInfo(userID: userID);
    Profile.userExperienceData =
        await userDataProcessing.getUserExperienceInfo(userID: userID);
    Profile.userAcademicData =
        await userDataProcessing.getUserAcademicInfo(userID: userID);
    print("Updated");
    return true;
  } catch (e) {
    print(e);
    return false;
  }
}

Map<String, String> userInfoChangeOrNot({
  required Map<String, String> userInputsList,
  required Map<String, String> storedInputsList,
}) {
  Map<String, String> temp = {
    'full_name': '',
    'email': '',
    'phone_number': '',
    'preference': '',
    'role': '',
    'age': '',
    'user_profile_photo': '',
  };

  if (userInputsList['full_name']!.length != 0) {
    temp['full_name'] = userInputsList['full_name']!;
  } else {
    temp['full_name'] = storedInputsList['full_name']!;
  }

  if (userInputsList['email']!.length != 0) {
    temp['email'] = userInputsList['email']!;
  } else {
    temp['email'] = storedInputsList['email']!;
  }

  if (userInputsList['user_profile_photo']!.length != 0) {
    temp['user_profile_photo'] = userInputsList['user_profile_photo']!;
  } else {
    temp['user_profile_photo'] = storedInputsList['user_profile_photo']!;
  }

  if (userInputsList['phone_number']!.length != 0) {
    temp['phone_number'] = userInputsList['phone_number']!;
  } else {
    temp['phone_number'] = storedInputsList['phone_number']!;
  }

  if (userInputsList['preference']!.length != 0) {
    temp['preference'] = userInputsList['preference']!;
  } else {
    temp['preference'] = storedInputsList['preference']!;
  }

  if (userInputsList['role']!.length != 0) {
    temp['role'] = userInputsList['role']!;
  } else {
    temp['role'] = storedInputsList['role']!;
  }

  if (userInputsList['age']!.length != 0) {
    temp['age'] = userInputsList['age']!;
  } else {
    temp['age'] = storedInputsList['age']!;
  }

  return temp;
}

Future<bool> usersDataProcessing({
  required List<Map<String, String>> userAcademicLists,
  required List<Map<String, String>> userExperienceLists,
  required List<Map<String, String>> userAddressLists,
}) async {
  try {
    if (userAcademicLists.isNotEmpty) {
      for (int i = 0; i < userAcademicLists.length; i++) {
        UserAcademicData userAcademicData = UserAcademicData(
          userID: Profile.userInfoData!.userID,
          academicID: '${i}',
          institute: userAcademicLists[i]['institute']!,
          degree_or_exam: userAcademicLists[i]['degree_or_exam']!,
          grade_or_marks: userAcademicLists[i]['grade_or_marks']!,
          passing_year: userAcademicLists[i]['passing_year']!,
        );
        await UserDataUploading().uploadUserAcademicDetails(userAcademicData);
      }
    }

    if (userExperienceLists.isNotEmpty) {
      for (int i = 0; i < userExperienceLists.length; i++) {
        UserExperienceData userExperienceData = UserExperienceData(
          userID: Profile.userInfoData!.userID,
          experienceID: '${i}',
          designation: userExperienceLists[i]['designation']!,
          institute: userExperienceLists[i]['institute']!,
          location: userExperienceLists[i]['location']!,
          joining_date: userExperienceLists[i]['joining_date']!,
          last_date_of_this_office: userExperienceLists[i]
              ['last_date_of_this_office']!,
        );
        await UserDataUploading().uploadUserExeperiences(userExperienceData);
      }
    }

    if (userAddressLists.isNotEmpty) {
      for (int i = 0; i < userAddressLists.length; i++) {
        UserAddressData userAddressData = UserAddressData(
          userID: Profile.userInfoData!.userID,
          addressID: '${i}',
          house: userAddressLists[i]['house']!,
          road: userAddressLists[i]['road']!,
          village_or_town: userAddressLists[i]['village_or_town']!,
          upzilla_or_thana: userAddressLists[i]['upzilla_or_thana']!,
          district: userAddressLists[i]['district']!,
          division: userAddressLists[i]['division']!,
        );

        await UserDataUploading().uploadUserAddress(userAddressData);
      }
    }
    return true;
  } catch (e) {
    print("error: ${e}");
    return false;
  }
}
