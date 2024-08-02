import 'package:aiquaboost/constants.dart';
import 'package:aiquaboost/screens/chatting_screen/chat.dart';
import 'package:aiquaboost/screens/devices_screen/devices.dart';
import 'package:aiquaboost/screens/home%20_screen/home.dart';
import 'package:aiquaboost/screens/notification_screen/Notification.dart';
import 'package:aiquaboost/screens/services_screen/services.dart';
import 'package:aiquaboost/screens/settings_screen/settings.dart';
import 'package:aiquaboost/screens/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  static const id = 'Home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _index = 0;
  ImageProvider? _cachedImage;

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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (userDetails['user_profile_photo']!.isNotEmpty) {
      _cachedImage = NetworkImage(userDetails['user_profile_photo']!);
      precacheImage(_cachedImage!, context);
    }
  }

  final ScreenIDs = [
    HomeScreen.id,
    Devices.id,
    Services.id,
    Chat.id,
    Settings.id,
  ];

  final bodyList = [Home(), Devices(), Services(), Chat(), Settings()];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryBlueColor,
          title: Text(
            ScreenIDs[_index],
            style: const TextStyle(
              fontSize: 30,
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, NotificationScreen.id);
              },
              icon: const Icon(
                Icons.notifications,
                size: 40,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              width: 25,
            ),
            _cachedImage != null
                ? Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, Profile.id);
                      },
                      child: CircleAvatar(
                        backgroundImage: _cachedImage!,
                        maxRadius: 20,
                      ),
                    ),
                  )
                : const Center(
                    child: CircleAvatar(
                      maxRadius: 20,
                      backgroundColor: Colors.blueAccent,
                      child: Icon(
                        Icons.person_outline,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                  ),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
        body: bodyList[_index],
        bottomNavigationBar: Container(
          color: kPrimaryBlueColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 5,
              vertical: 7,
            ),
            child: GNav(
              backgroundColor: kPrimaryBlueColor,
              color: Colors.white,
              activeColor: Colors.white,
              tabBackgroundColor: Colors.grey.shade800,
              gap: 8,
              onTabChange: (index) {
                setState(() {
                  _index = index;
                });
              },
              padding: EdgeInsets.all(16),
              tabs: const [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.devices_other_sharp,
                  text: 'Devices',
                ),
                GButton(
                  icon: Icons.manage_accounts_outlined,
                  text: 'Services',
                ),
                GButton(
                  icon: Icons.chat_bubble_outline,
                  text: 'Chat',
                ),
                GButton(
                  icon: Icons.settings,
                  text: 'Settings',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
