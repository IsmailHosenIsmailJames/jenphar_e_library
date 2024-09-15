import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jenphar_e_library/src/screens/auth/login/login_screens.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 3, 73, 131),
      body: Column(
        children: [
          const Spacer(
            flex: 1,
          ),
          Center(
            child: Container(
              height: 100,
              width: 260,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                image: const DecorationImage(
                  image: AssetImage('assets/jenphar_elibrary_logo.png'),
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
          ),
          const Spacer(
            flex: 2,
          ),
          const Text(
            'Welcome to',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          const Text(
            "Jenphar E-Library",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w900,
              color: Colors.lightBlue,
            ),
          ),
          const Spacer(
            flex: 2,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              Get.to(
                () => const LoginScreens(),
              );
            },
            child: const Text(
              "LOGIN",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Spacer(
            flex: 1,
          ),
        ],
      ),
    );
  }
}
