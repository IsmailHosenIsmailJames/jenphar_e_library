import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart';
import 'package:jenphar_e_library/src/api/apis.dart';
import 'package:jenphar_e_library/src/screens/auth/auth_controller_getx.dart';
import 'package:jenphar_e_library/src/screens/auth/login/model/login_response_model.dart';
import 'package:jenphar_e_library/src/screens/home/home_screen.dart';
import 'package:toastification/toastification.dart';

import '../../../core/functions/show_towast.dart';

class LoginScreens extends StatefulWidget {
  const LoginScreens({super.key});

  @override
  State<LoginScreens> createState() => _LoginScreensState();
}

class _LoginScreensState extends State<LoginScreens> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool loading = false;
  final key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 3, 73, 131),
      body: Form(
        key: key,
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
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
                const Gap(100),
                const Text(
                  'User Login',
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
                const Gap(50),
                Container(
                  width: 400,
                  height: 50,
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: TextFormField(
                    validator: (value) {
                      if (value != null && value.isNotEmpty) {
                        return null;
                      } else {
                        return "User name can't be empty";
                      }
                    },
                    controller: userNameController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      hintText: "User Name",
                      hintStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade700,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const Gap(10),
                Container(
                  width: 400,
                  height: 50,
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: TextFormField(
                    validator: (value) {
                      if (value != null && value.length > 3) {
                        return null;
                      } else {
                        return "Password is too short";
                      }
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: passwordController,
                    decoration: InputDecoration(
                      hintText: "Password",
                      hintStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade700,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const Gap(30),
                SizedBox(
                  width: 400,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () async {
                      if (key.currentState!.validate()) {
                        setState(() {
                          loading = true;
                        });
                        final response = await post(
                            Uri.parse(apiBase + apiLogin),
                            headers: {"Content-Type": "application/json"},
                            body: jsonEncode({
                              "username": userNameController.text.trim(),
                              "password": passwordController.text
                            }));

                        log(response.body);
                        log(response.statusCode.toString());

                        if (response.statusCode == 200) {
                          final decoded = jsonDecode(response.body);
                          if (decoded['success'] == true) {
                            showToastNotification(
                              msg: decoded['message'],
                              context: context,
                              type: ToastificationType.success,
                            );
                            final authControllerGetx =
                                Get.put(AuthControllerGetx());
                            authControllerGetx.loginResponseModel.add(
                                LoginResponseModel.fromMap(
                                    Map<String, dynamic>.from(
                                        decoded['user'])));
                            await Hive.box('info')
                                .put('userInfo', decoded['user']);

                            Get.offAll(() => const HomeScreen());
                          } else {
                            showToastNotification(
                              msg: decoded['message'],
                              context: context,
                              type: ToastificationType.error,
                            );
                          }
                        } else {
                          showToastNotification(
                            msg: "Something went worng",
                            context: context,
                            type: ToastificationType.error,
                          );
                        }
                      }
                      setState(() {
                        loading = false;
                      });
                    },
                    child: loading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text(
                            "LOGIN",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
