import 'package:aiquaboost/domain/user_info_data.dart';
import 'package:aiquaboost/screens/update_profile.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class Profile extends StatefulWidget {
  static const id = "profile";
  static UserInfoData? userInfoData;
  static List<Map<String, String>>? userAddressData;
  static List<Map<String, String>>? userAcademicData;
  static List<Map<String, String>>? userExperienceData;
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var userDetails = {
    'name': 'Andrew Bernard',
    'email': 'andrewbernard@gmail.com',
    'phone_number': '+8801511117733',
    'role': 'CEO',
    'user_profile_photo': ''
  };

  @override
  void initState() {
    userDetails['name'] = Profile.userInfoData!.full_name;
    userDetails['email'] = Profile.userInfoData!.email;
    userDetails['phone_number'] = '+88' + Profile.userInfoData!.phone_number;
    userDetails['role'] = Profile.userInfoData!.role;
    userDetails['user_profile_photo'] =
        Profile.userInfoData!.user_profile_photo;

    super.initState();
  }

  Widget profileInfo({
    required String fieldName,
    required IconData iconData,
  }) {
    return Container(
      margin: EdgeInsets.only(left: 50),
      child: Row(
        children: <Widget>[
          Icon(
            iconData,
            size: 30,
            color: kPrimaryBlueColor,
          ),
          const SizedBox(
            width: 25,
          ),
          Text(
            userDetails[fieldName]!,
            style: TextStyle(
              fontSize: 21,
              fontWeight:
                  (fieldName == 'name') ? FontWeight.bold : FontWeight.normal,
              color: kPrimaryBlueColor,
            ),
            softWrap: true,
            overflow: TextOverflow.visible,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print("full name: ${Profile.userInfoData?.full_name}");
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
            "My Profile",
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 30,
              ),
              FutureBuilder(
                future: precacheImage(
                    NetworkImage(userDetails['user_profile_photo']!), context),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircleAvatar(
                        minRadius: 10,
                        maxRadius: 100,
                        backgroundColor: Colors.blueAccent,
                        child: Icon(
                          Icons.person_outline, // Use the icon you want
                          size: 80, // Adjust size as needed
                          color: Colors.white, // Set the color of the icon
                        ), // Optional: Set a background color for the CircleAvatar
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else {
                    return Center(
                      child: CircleAvatar(
                        backgroundImage:
                            NetworkImage(userDetails['user_profile_photo']!),
                        minRadius: 10,
                        maxRadius: 100,
                      ),
                    );
                  }
                },
              ),
              const SizedBox(
                height: 50,
              ),
              profileInfo(
                fieldName: 'name',
                iconData: Icons.person_outline_sharp,
              ),
              const SizedBox(
                height: 25,
              ),
              profileInfo(
                fieldName: 'email',
                iconData: Icons.email_outlined,
              ),
              const SizedBox(
                height: 25,
              ),
              profileInfo(
                fieldName: 'phone_number',
                iconData: Icons.call_outlined,
              ),
              const SizedBox(
                height: 25,
              ),
              profileInfo(
                fieldName: 'role',
                iconData: Icons.person,
              ),
              const SizedBox(
                height: 50,
              ),
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
                    Navigator.pushNamed(context, UpdateProfile.id);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                  child: const Text(
                    "Update Profile",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
    ;
  }
}
