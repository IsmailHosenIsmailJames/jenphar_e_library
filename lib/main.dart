import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jenphar_e_library/src/screens/auth/auth_controller_getx.dart';
import 'package:jenphar_e_library/src/screens/auth/login/model/login_response_model.dart';
import 'package:jenphar_e_library/src/screens/home/home_screen.dart';
import 'package:jenphar_e_library/src/screens/setup/welcome_screen.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('info');
  await Hive.openBox('questions');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      defaultTransition: Transition.leftToRight,
      theme: ThemeData(
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
        await Future.delayed(
          const Duration(milliseconds: 100),
        );
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
      },
    );
  }
}

class InitLoadingScreen extends StatelessWidget {
  const InitLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LoadingAnimationWidget.threeRotatingDots(
          color: Colors.blue.shade900,
          size: 30,
        ),
      ),
    );
  }
}
