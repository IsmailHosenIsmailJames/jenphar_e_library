import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jenphar_e_library/src/screens/auth/auth_controller_getx.dart';
import 'package:jenphar_e_library/src/screens/home/home_screen.dart';
import 'package:jenphar_e_library/src/screens/setup/welcome_screen.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('info');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
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
        final userNamae = infoBox.get('userName', defaultValue: null);
        final password = infoBox.get('password', defaultValue: null);
        if (userNamae != null && password != null) {
          final authControllerGetx = Get.put(AuthControllerGetx());
          authControllerGetx.password.value = password;
          authControllerGetx.userName.value = userNamae;

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
