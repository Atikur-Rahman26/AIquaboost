import 'package:aiquaboost/firebase_options.dart';
import 'package:aiquaboost/screens/update_profile.dart';
import 'package:aiquaboost/screens/user_login.dart';
import 'package:aiquaboost/screens/user_profile.dart';
import 'package:aiquaboost/screens/user_registration.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AIquaBoost',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'home page'),
      routes: {
        Login.id: (context) => Login(),
        Registration.id: (context) => Registration(),
        Profile.id: (context) => Profile(),
        UpdateProfile.id: (context) => UpdateProfile(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
