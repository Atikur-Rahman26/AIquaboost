import 'package:aiquaboost/data/user_authentication.dart';
import 'package:aiquaboost/screens/components/users_logistics.dart';
import 'package:aiquaboost/screens/user_profile.dart';
import 'package:aiquaboost/screens/user_registration.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  static const id = "login";

  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var email = '';
  var password = '';

  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  void clearTextFields() {
    emailTextEditingController.clear();
    passwordTextEditingController.clear();
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
            "Login",
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
              Center(
                child: Image.asset('asssets/images/login.png'),
              ),
              const SizedBox(
                height: 50,
              ),
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
              const SizedBox(
                height: 10,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 30),
                  child: Text(
                    'Login to your account',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 18,
                      color: Color.fromRGBO(72, 202, 227, 1),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 30,
                  right: 30,
                ),
                child: TextField(
                  style: const TextStyle(fontSize: 18, fontFamily: 'Arial'),
                  decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.email,
                        size: 18,
                      ),
                      hintText: "Email"),
                  onChanged: (value) {
                    email = value;
                  },
                  onTap: () {},
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 30,
                  right: 30,
                ),
                child: TextField(
                  obscureText: true,
                  style: const TextStyle(fontSize: 18, fontFamily: 'Arial'),
                  decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.lock,
                        size: 18,
                      ),
                      hintText: "Password"),
                  onChanged: (value) {
                    password = value;
                  },
                  onTap: () {},
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.only(right: 30),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      textAlign: TextAlign.end,
                      "Forgot password?",
                      style: TextStyle(
                        color: Color.fromRGBO(151, 200, 225, 1),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
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
                  onPressed: () async {
                    String message = await getMessageForLogin(
                        email: email, password: password);
                    if (message == 'Login successful') {
                      await setUsersInfo();
                      clearTextFields();
                      Navigator.pushNamed(context, Profile.id);
                    } else {
                      print(message);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                  child: const Text(
                    "Login",
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(left: 30, right: 10),
                    width: 125,
                    child: const Divider(
                      thickness: 1,
                      height: 10,
                      color: Colors.black,
                    ),
                  ),
                  const Text("or login with"),
                  Container(
                    margin: const EdgeInsets.only(left: 10, right: 30),
                    width: 125,
                    child: const Divider(
                      thickness: 1,
                      height: 10,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 50),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: MaterialButton(
                  onPressed: () async {
                    bool isDone = await UserAuthenticationAndRegistration()
                        .signInWithGoogle();
                    if (isDone) {
                      bool isOkay = await setUsersInfo();
                      if (isOkay) {
                        clearTextFields();
                        Navigator.pushNamed(context, Profile.id);
                      } else {
                        isOkay = await setUsersInfo();
                      }
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        "asssets/images/google_logo.png",
                        height: 50,
                        width: 50,
                      ),
                      const Text(
                        "Google",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
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
                    "Don't have an account?",
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  TextButton(
                    onPressed: () {
                      clearTextFields();
                      Navigator.pushNamed(context, Registration.id);
                    },
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                          color: Color.fromRGBO(2, 62, 138, 1), fontSize: 20),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
