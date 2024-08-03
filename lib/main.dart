import 'package:aiquaboost/domain/user_info_data.dart';
import 'package:aiquaboost/firebase_options.dart';
import 'package:aiquaboost/screens/home%20_screen/home_screen.dart';
import 'package:aiquaboost/screens/notification_screen/Notification.dart';
import 'package:aiquaboost/screens/update_profile.dart';
import 'package:aiquaboost/screens/user_login.dart';
import 'package:aiquaboost/screens/user_profile.dart';
import 'package:aiquaboost/screens/user_registration.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  static const String loginKey = "LoggedIn";
  static const String userKey = "Users";
  late SharedPreferences preferences;

  Future<bool> loggedIn() async {
    preferences = await SharedPreferences.getInstance();
    bool? temp = preferences.getBool(loginKey);
    return temp ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AIquaBoost',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: FutureBuilder<bool>(
        future: loggedIn(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data == true) {
            List<String>? strlists = preferences.getStringList(userKey);
            if (strlists != null && strlists.length >= 8) {
              String email = strlists[0];
              String full_name = strlists[1];
              String phone_number = strlists[2];
              String user_profile_photo = strlists[3];
              String preference = strlists[4];
              String role = strlists[5];
              String age = strlists[6];
              String userID = strlists[7];

              UserInfoData userInfo = UserInfoData(
                userID: userID,
                full_name: full_name,
                email: email,
                phone_number: phone_number,
                preference: preference,
                role: role,
                age: age,
                user_profile_photo: user_profile_photo,
              );

              Profile.userInfoData = userInfo;
              return HomeScreen();
            } else {
              return MyHomePage(); // Fallback to home page if user data is incomplete
            }
          } else {
            return MyHomePage();
          }
        },
      ),
      routes: {
        Login.id: (context) => Login(),
        Registration.id: (context) => Registration(),
        Profile.id: (context) => Profile(),
        UpdateProfile.id: (context) => UpdateProfile(),
        HomeScreen.id: (context) => HomeScreen(),
        MyHomePage.id: (context) => MyHomePage(),
        NotificationScreen.id: (context) => NotificationScreen(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  static const id = 'MyHomeScreen';
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> signOutUser() async {
    // Sign out from Firebase
    await FirebaseAuth.instance.signOut();

    // Sign out from Google
    await GoogleSignIn().signOut();
  }

  @override
  void initState() {
    super.initState();
    signOutUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              Color(0xFF0074b1),
              Color(0xFF0066a9),
              Color(0xFF024d8e),
              Color(0xFF02438e),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset('asssets/images/logo.webp'),
              Container(
                height: 20,
              ),
              SizedBox(
                height: 50,
                width: 300,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Login.id);
                  },
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 50,
                width: 300,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Registration.id);
                  },
                  child: const Text(
                    "Registration",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
