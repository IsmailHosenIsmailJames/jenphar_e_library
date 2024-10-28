// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:jenphar_e_library/src/screens/e_library/e_library_page.dart';
import 'package:jenphar_e_library/src/screens/leader_board/leader_board.dart';
import 'package:jenphar_e_library/src/screens/quiz/quiz_page.dart';
import 'package:jenphar_e_library/src/screens/quiz_results/quiz_results.dart';

import '../setup/welcome_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // Future.delayed(const Duration(milliseconds: 500)).then(
    //   (value) => showDialog(
    //     // ignore: use_build_context_synchronously
    //     context: context,
    //     builder: (context) => Dialog(
    //       insetPadding: EdgeInsets.zero,
    //       backgroundColor: Colors.transparent,
    //       child: Container(
    //         height: MediaQuery.of(context).size.width * 0.85,
    //         width: MediaQuery.of(context).size.width * 0.85,
    //         decoration: const BoxDecoration(
    //           image: DecorationImage(
    //             image: AssetImage("assets/poster_1725353869082.jpeg"),
    //           ),
    //         ),
    //         alignment: Alignment.topRight,
    //         child: IconButton(
    //           style: IconButton.styleFrom(
    //             backgroundColor: Colors.black,
    //             foregroundColor: Colors.white,
    //           ),
    //           onPressed: () {
    //             Navigator.pop(context);
    //           },
    //           icon: const Icon(Icons.close),
    //         ),
    //       ),
    //     ),
    //   ),
    // );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context, "Home"),
      body: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 15, mainAxisSpacing: 15),
        padding: const EdgeInsets.only(top: 100, left: 20, right: 20),
        children: [
          cardOfTopices(
            svg:
                '''<svg stroke="currentColor" fill="currentColor" stroke-width="0" viewBox="0 0 512 512" class="icon" height="1em" width="1em" xmlns="http://www.w3.org/2000/svg">
              <path d="M64 480H48a32 32 0 01-32-32V112a32 32 0 0132-32h16a32 32 0 0132 32v336a32 32 0 01-32 32zm176-304a32 32 0 00-32-32h-64a32 32 0 00-32 32v28a4 4 0 004 4h120a4 4 0 004-4zM112 448a32 32 0 0032 32h64a32 32 0 0032-32v-30a2 2 0 00-2-2H114a2 2 0 00-2 2z"></path>
              <rect width="128" height="144" x="112" y="240" rx="2" ry="2"></rect>
              <path d="M320 480h-32a32 32 0 01-32-32V64a32 32 0 0132-32h32a32 32 0 0132 32v384a32 32 0 01-32 32zm175.89-34.55l-32.23-340c-1.48-15.65-16.94-27-34.53-25.31l-31.85 3c-17.59 1.67-30.65 15.71-29.17 31.36l32.23 340c1.48 15.65 16.94 27 34.53 25.31l31.85-3c17.59-1.67 30.65-15.71 29.17-31.36z"></path>
            </svg>''',
            name: "E-Library",
            onPressed: () {
              Get.to(
                () => ELibraryPage(),
              );
            },
          ),
          cardOfTopices(
            svg:
                '''<svg class="icon" stroke="currentColor" fill="currentColor" stroke-width="0" viewBox="0 0 16 16" height="1em" width="1em" xmlns="http://www.w3.org/2000/svg">
              <path d="M5.933.87a2.89 2.89 0 0 1 4.134 0l.622.638.89-.011a2.89 2.89 0 0 1 2.924 2.924l-.01.89.636.622a2.89 2.89 0 0 1 0 4.134l-.637.622.011.89a2.89 2.89 0 0 1-2.924 2.924l-.89-.01-.622.636a2.89 2.89 0 0 1-4.134 0l-.622-.637-.89.011a2.89 2.89 0 0 1-2.924-2.924l.01-.89-.636-.622a2.89 2.89 0 0 1 0-4.134l.637-.622-.011-.89a2.89 2.89 0 0 1 2.924-2.924l.89.01.622-.636zM7.002 11a1 1 0 1 0 2 0 1 1 0 0 0-2 0zm1.602-2.027c.04-.534.198-.815.846-1.26.674-.475 1.05-1.09 1.05-1.986 0-1.325-.92-2.227-2.262-2.227-1.02 0-1.792.492-2.1 1.29A1.71 1.71 0 0 0 6 5.48c0 .393.203.64.545.64.272 0 .455-.147.564-.51.158-.592.525-.915 1.074-.915.61 0 1.03.446 1.03 1.084 0 .563-.208.885-.822 1.325-.619.433-.926.914-.926 1.64v.111c0 .428.208.745.585.745.336 0 .504-.24.554-.627z"></path>
            </svg>''',
            name: "Quiz Topics",
            onPressed: () {
              Get.to(
                () => const QuizPage(),
              );
            },
          ),
          cardOfTopices(
            svg:
                '''<svg class="icon" stroke="currentColor" fill="currentColor" stroke-width="0" viewBox="0 0 384 512" height="1em" width="1em" xmlns="http://www.w3.org/2000/svg">
              <path d="M0 448c0 35.3 28.7 64 64 64H224V384c0-17.7 14.3-32 32-32H384V64c0-35.3-28.7-64-64-64H64C28.7 0 0 28.7 0 64V448zM171.3 75.3l-96 96c-6.2 6.2-16.4 6.2-22.6 0s-6.2-16.4 0-22.6l96-96c6.2-6.2 16.4-6.2 22.6 0s6.2 16.4 0 22.6zm96 32l-160 160c-6.2 6.2-16.4 6.2-22.6 0s-6.2-16.4 0-22.6l160-160c6.2-6.2 16.4-6.2 22.6 0s6.2 16.4 0 22.6zM384 384H256V512L384 384z"></path>
            </svg>''',
            name: "Quiz Results",
            onPressed: () {
              Get.to(
                () => const QuizResults(),
              );
            },
          ),
          cardOfTopices(
            svg:
                '''<svg class="icon" stroke="currentColor" fill="currentColor" stroke-width="0" viewBox="0 0 24 24" height="1em" width="1em" xmlns="http://www.w3.org/2000/svg">
              <path fill="none" d="M0 0h24v24H0z"></path>
              <path d="M7.5 21H2V9h5.5v12zm7.25-18h-5.5v18h5.5V3zM22 11h-5.5v10H22V11z"></path>
            </svg>''',
            name: "LeaderBoard",
            onPressed: () {
              Get.to(
                () => const LeaderBoard(),
              );
            },
          ),
        ],
      ),
    );
  }
}

Widget cardOfTopices(
    {required String svg,
    required String name,
    Color? color,
    required void Function() onPressed}) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color.fromARGB(255, 245, 254, 255),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400,
            blurRadius: 20,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.string(
            svg,
            color: color ?? Colors.blue,
            height: 50,
            width: 50,
          ),
          const Gap(10),
          Text(
            name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}

AppBar getAppBar(BuildContext context, String title) {
  return AppBar(
    title: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Jenphar E-Library",
          style: TextStyle(fontSize: 13),
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
      ],
    ),
    actions: [
      GestureDetector(
        onTap: () {
          final infoBox = Hive.box('info');
          final userInfo = infoBox.get('userInfo', defaultValue: null);
          final workAreaT = userInfo['work_area_t'];
          showDialog(
            context: context,
            builder: (context) => Dialog(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Gap(20),
                  Container(
                    height: 80,
                    width: 80,
                    margin: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage('assets/dummy-profile.png'),
                      ),
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                        color: Colors.grey,
                        width: 2,
                      ),
                    ),
                  ),
                  const Gap(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "ID: ",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        workAreaT,
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blue,
                          shadowColor: Colors.transparent),
                      onPressed: () async {
                        await Hive.box('info').clear();
                        await (await Hive.openBox('questions')).clear();
                        Get.offAll(
                          () => const WelcomeScreen(),
                        );
                      },
                      child: const Text("Log Out"),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        child: Container(
          height: 50,
          width: 50,
          margin: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: AssetImage('assets/dummy-profile.png'),
            ),
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              color: Colors.grey,
              width: 2,
            ),
          ),
        ),
      ),
    ],
  );
}
