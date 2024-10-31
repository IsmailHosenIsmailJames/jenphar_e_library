import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jenphar_e_library/src/screens/auth/auth_controller_getx.dart';
import 'package:jenphar_e_library/src/screens/auth/login/model/login_response_model.dart';
import 'package:jenphar_e_library/src/screens/common/internet_connection_off_notify.dart';
import 'package:jenphar_e_library/src/screens/home/home_screen.dart';
import 'package:jenphar_e_library/src/screens/setup/welcome_screen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'src/core/in_app_update/in_app_android_update/in_app_update_android.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('info');
  await Hive.openBox('questions');
  runApp(const MyApp());
}

bool isUpdateChecked = false;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.leftToRight,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 217, 238, 255),
        ),
        scaffoldBackgroundColor: const Color.fromARGB(255, 217, 238, 255),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue.shade900),
        brightness: Brightness.light,
        useMaterial3: true,
      ),
      home: const InitLoadingScreen(),
      onInit: () async {
        final connectivityResult = await Connectivity().checkConnectivity();
        if (connectivityResult.contains(ConnectivityResult.mobile) ||
            connectivityResult.contains(ConnectivityResult.ethernet) ||
            connectivityResult.contains(ConnectivityResult.wifi)) {
          isUpdateChecked = false;
          while (!isUpdateChecked) {
            await Future.delayed(Duration(milliseconds: 100));
          }

          final infoBox = Hive.box('info');
          final userInfo = infoBox.get('userInfo', defaultValue: null);

          if (userInfo != null) {
            await Future.delayed(const Duration(milliseconds: 200));
            final authControllerGetx = Get.put(AuthControllerGetx());
            authControllerGetx.loginResponseModel.value = [
              LoginResponseModel.fromMap(Map<String, dynamic>.from(userInfo))
            ];
            Get.offAll(
              () => const HomeScreen(),
            );
          } else {
            Get.offAll(
              () => const WelcomeScreen(),
            );
          }
        } else {
          Get.to(
            () => const InternetConnectionOffNotify(),
          );
        }
      },
    );
  }
}

class InitLoadingScreen extends StatelessWidget {
  const InitLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    inAppUpdateAndroid(context);

    return const Scaffold(
      body: Center(
        child: CupertinoActivityIndicator(
          color: Colors.blue,
          radius: 20,
        ),
      ),
    );
  }
}
