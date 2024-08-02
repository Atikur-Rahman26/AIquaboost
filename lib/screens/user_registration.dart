import 'dart:async';
import 'dart:io';

import 'package:aiquaboost/constants.dart';
import 'package:aiquaboost/data/user_authentication.dart';
import 'package:aiquaboost/screens/components/users_logistics.dart';
import 'package:aiquaboost/screens/user_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';

class Registration extends StatefulWidget {
  static const id = "registration";
  const Registration({super.key});

  @override
  State<Registration> createState() => _LoginState();
}

class _LoginState extends State<Registration> {
  bool isUploadedImage = false;
  bool _clickedUserPhotoUpload = false;
  bool _isLoading = false;
  XFile? _userImage;
  var userInputsList = {
    'full_name': '',
    'email': '',
    'phone_number': '',
    'password': '',
    'confirm_password': '',
    'preference': '',
    'role': '',
    'user_profile_photo': '',
    'age': 'NF'
  };

  Map<String, TextEditingController> userPersonalInfoController = {
    'full_name': TextEditingController(),
    'email': TextEditingController(),
    'phone_number': TextEditingController(),
    'preference': TextEditingController(),
    'role': TextEditingController(),
    'password': TextEditingController(),
    'confirm_password': TextEditingController(),
  };
  Widget inputWithIcon({
    required String hintText,
    required IconData iconData,
    required VoidCallback onPressedAction,
    required String fieldName,
    required bool textFieldOrNot,
    required bool passwordField,
  }) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 30,
        right: 30,
      ),
      child: textFieldOrNot
          ? TextField(
              obscureText: passwordField,
              controller: userPersonalInfoController[fieldName],
              style: const TextStyle(fontSize: 18, fontFamily: 'Arial'),
              decoration: InputDecoration(
                  prefixIcon: Icon(iconData), hintText: "${hintText}"),
              onChanged: (value) {
                userInputsList[fieldName!] = value;
              },
              onTap: () {},
            )
          : DropdownButtonFormField<String>(
              items: fieldName == 'preference'
                  ? ['English', 'Bangla'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList()
                  : [
                      'Admin',
                      'Hatchary Expert',
                      'Hatchary Worker',
                      'Hatchary Owner',
                      'General'
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
              onChanged: (value) {
                setState(() {
                  userInputsList[fieldName] = value!;
                });
              },
              decoration: InputDecoration(
                prefixIcon: Icon(iconData),
                hintText: hintText,
              ),
            ),
    );
  }

  void clearTextEditingController() {
    userPersonalInfoController['full_name']!.clear();
    userPersonalInfoController['email']!.clear();
    userPersonalInfoController['phone_number']!.clear();
    userPersonalInfoController['preference']!.clear();
    userPersonalInfoController['role']!.clear();
    userPersonalInfoController['password']!.clear();
    userPersonalInfoController['confirm_password']!.clear();
  }

  final ImagePicker picker = ImagePicker();
  Future getImage(ImageSource media) async {
    var image = await picker.pickImage(source: media);
    setState(() {
      if (image != null) {
        _clickedUserPhotoUpload = true;
        _userImage = image;
        userInputsList['user_profile_photo'] = _userImage!.path;
      }
    });
  }

  void imagePickingAlertBox() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Color.fromRGBO(2, 62, 138, 1),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            title: const Text(
              "Please choose a media",
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.normal),
            ),
            content: Container(
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: <Widget>[
                  ElevatedButton(
                    //if user click this button, user can upload image from gallery
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.gallery);
                      print("Why it failed? ");
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.image),
                        Text('From Gallery'),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    //if user click this button, user can upload image from gallery
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.camera);
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.image),
                        Text('From Camera'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(2, 62, 138, 1),
          leading: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Colors.white,
              size: 30,
            ),
          ),
          title: const Text(
            "Sign Up",
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Stack(children: [
            Column(
              children: <Widget>[
                sizedBoxH50,
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 30),
                    child: Text(
                      'Welcome Back',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 30,
                          color: Color.fromRGBO(2, 62, 138, 1),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                sizedBoxH10,
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 30),
                    child: Text(
                      'Create an account',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 18,
                        color: Color.fromRGBO(72, 202, 227, 1),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                sizedBoxH20,
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(250, 250),
                      maximumSize: Size(250, 250),
                      backgroundColor: Color.fromRGBO(239, 239, 239, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ) // Set the background color
                      ),
                  onPressed: () {
                    imagePickingAlertBox();
                  },
                  child: _clickedUserPhotoUpload
                      ? Image.file(
                          File(_userImage!.path),
                          fit: BoxFit.contain,
                        )
                      : const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.add,
                                size: 50,
                                weight: 900,
                                color: Color.fromRGBO(2, 62, 138, 1),
                              ),
                              Text(
                                "Add Your\nPhoto", // Use \n to break the text into 2 lines
                                softWrap: true,
                                textAlign:
                                    TextAlign.center, // Center-align the text
                                style: TextStyle(
                                  color: Color.fromRGBO(2, 62, 138, 1),
                                  fontSize: 30,
                                ),
                              ),
                            ],
                          ),
                        ),
                ),
                sizedBoxH10,
                inputWithIcon(
                  fieldName: 'full_name',
                  hintText: 'Full Name',
                  iconData: Icons.person,
                  onPressedAction: () {},
                  textFieldOrNot: true,
                  passwordField: false,
                ),
                sizedBoxH20,
                inputWithIcon(
                  fieldName: 'email',
                  hintText: 'Email',
                  iconData: Icons.email_outlined,
                  onPressedAction: () {},
                  textFieldOrNot: true,
                  passwordField: false,
                ),
                sizedBoxH20,
                inputWithIcon(
                  fieldName: 'phone_number',
                  hintText: 'Phone Number',
                  iconData: Icons.call_outlined,
                  onPressedAction: () {},
                  textFieldOrNot: true,
                  passwordField: false,
                ),
                sizedBoxH20,
                inputWithIcon(
                  fieldName: 'password',
                  hintText: 'Password',
                  iconData: Icons.lock_outline,
                  onPressedAction: () {},
                  textFieldOrNot: true,
                  passwordField: true,
                ),
                sizedBoxH20,
                inputWithIcon(
                  fieldName: 'confirm_password',
                  hintText: 'Confirm Password',
                  iconData: Icons.lock_outline,
                  onPressedAction: () {},
                  textFieldOrNot: true,
                  passwordField: true,
                ),
                sizedBoxH20,
                inputWithIcon(
                  fieldName: 'preference',
                  hintText: 'Preference',
                  iconData: Icons.language_outlined,
                  onPressedAction: () {},
                  textFieldOrNot: false,
                  passwordField: false,
                ),
                sizedBoxH20,
                inputWithIcon(
                  fieldName: 'role',
                  hintText: 'Role',
                  iconData: Icons.person_2_outlined,
                  onPressedAction: () {},
                  textFieldOrNot: false,
                  passwordField: false,
                ),
                sizedBoxH10,
                Container(
                  padding: const EdgeInsets.only(
                    left: 30,
                    right: 30,
                  ),
                  margin: const EdgeInsets.only(
                    left: 30,
                    right: 30,
                  ),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: <Color>[
                        Color(0xFF0074b1),
                        Color(0xFF0066a9),
                        Color(0xFF024d8e),
                        Color(0xFF02438e),
                      ],
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _isLoading = true;
                      });
                      final message = (getMessageOfRegistrationFieldsChecking(
                          userInputList: userInputsList));
                      if (message == 'Account created successfully.') {
                        UserAuthenticationAndRegistration()
                            .createAccountEmailAndPassword(
                                userInputsList: userInputsList,
                                password: userInputsList['password']!);
                        setState(() {
                          _isLoading = false;
                        });
                        Navigator.pop(context);
                        clearTextEditingController();
                        return;
                      }
                      showToast(message: message);
                      setState(() {
                        _isLoading = false;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                    ),
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      "Already have an account?",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    TextButton(
                        onPressed: () {
                          clearTextEditingController();
                          Navigator.pushNamed(context, Login.id);
                        },
                        child: const Text(
                          "Sign In",
                          style: TextStyle(
                            color: Color.fromRGBO(2, 62, 138, 1),
                            fontSize: 20,
                          ),
                        ))
                  ],
                )
              ],
            ),
            if (_isLoading)
              const Positioned.fill(
                child: Center(
                  child: SpinKitFadingCircle(
                    color: Color.fromRGBO(2, 62, 138, 1),
                    size: 100,
                  ),
                ),
              ),
          ]),
        ),
      ),
    );
  }
}
