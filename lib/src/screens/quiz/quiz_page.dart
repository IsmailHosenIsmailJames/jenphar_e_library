import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:jenphar_e_library/src/screens/setup/welcome_screen.dart';

import '../home/home_screen.dart';
import 'quiz_list_screen/quiz_screens.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Jenphar E-Library",
              style: TextStyle(fontSize: 13),
            ),
            Text(
              "Quiz Topics",
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
      ),
      body: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
        padding: const EdgeInsets.only(top: 100, left: 20, right: 20),
        children: [
          cardOfTopices(
            svg:
                '''<svg stroke="currentColor" fill="currentColor" stroke-width="0" viewBox="0 0 24 24" class="icon" height="1em" width="1em" xmlns="http://www.w3.org/2000/svg">
              <path fill="none" d="M0 0h24v24H0z"></path>
              <path d="M12 2c-5.33 4.55-8 8.48-8 11.8 0 4.98 3.8 8.2 8 8.2s8-3.22 8-8.2c0-3.32-2.67-7.25-8-11.8zM7.83 14c.37 0 .67.26.74.62.41 2.22 2.28 2.98 3.64 2.87.43-.02.79.32.79.75 0 .4-.32.73-.72.75-2.13.13-4.62-1.09-5.19-4.12a.75.75 0 01.74-.87z"></path>
            </svg>''',
            name: "Hematology",
            color: Colors.red,
            onPressed: () {
              Get.to(
                () => const QuizScreens(title: "Hematology"),
              );
            },
          ),
          cardOfTopices(
            svg:
                '''<svg stroke="currentColor" fill="currentColor" stroke-width="0" viewBox="0 0 448 512" class="icon" height="1em" width="1em" xmlns="http://www.w3.org/2000/svg">
              <path d="M6.1 444.3c-9.6 10.8-7.5 27.6 4.5 35.7l68.8 27.9c9.9 6.7 23.3 5 31.3-3.8l91.8-101.9-79.2-87.9-117.2 130zm435.8 0s-292-324.6-295.4-330.1c15.4-8.4 40.2-17.9 77.5-17.9s62.1 9.5 77.5 17.9c-3.3 5.6-56 64.6-56 64.6l79.1 87.7 34.2-38c28.7-31.9 33.3-78.6 11.4-115.5l-43.7-73.5c-4.3-7.2-9.9-13.3-16.8-18-40.7-27.6-127.4-29.7-171.4 0-6.9 4.7-12.5 10.8-16.8 18l-43.6 73.2c-1.5 2.5-37.1 62.2 11.5 116L337.5 504c8 8.9 21.4 10.5 31.3 3.8l68.8-27.9c11.9-8 14-24.8 4.3-35.6z"></path>
            </svg>''',
            name: "Oncology",
            color: Colors.pink.shade300,
            onPressed: () {
              Get.to(
                () => const QuizScreens(title: "Oncology"),
              );
            },
          ),
          cardOfTopices(
            svg:
                '''<svg stroke="currentColor" fill="currentColor" stroke-width="0" viewBox="0 0 512 512" class="icon" height="1em" width="1em" xmlns="http://www.w3.org/2000/svg">
              <path d="M483.55,227.55H462c-50.68,0-76.07-61.27-40.23-97.11L437,115.19A28.44,28.44,0,0,0,396.8,75L381.56,90.22c-35.84,35.83-97.11,10.45-97.11-40.23V28.44a28.45,28.45,0,0,0-56.9,0V50c0,50.68-61.27,76.06-97.11,40.23L115.2,75A28.44,28.44,0,0,0,75,115.19l15.25,15.25c35.84,35.84,10.45,97.11-40.23,97.11H28.45a28.45,28.45,0,1,0,0,56.89H50c50.68,0,76.07,61.28,40.23,97.12L75,396.8A28.45,28.45,0,0,0,115.2,437l15.24-15.25c35.84-35.84,97.11-10.45,97.11,40.23v21.54a28.45,28.45,0,0,0,56.9,0V462c0-50.68,61.27-76.07,97.11-40.23L396.8,437A28.45,28.45,0,0,0,437,396.8l-15.25-15.24c-35.84-35.84-10.45-97.12,40.23-97.12h21.54a28.45,28.45,0,1,0,0-56.89ZM224,272a48,48,0,1,1,48-48A48,48,0,0,1,224,272Zm80,56a24,24,0,1,1,24-24A24,24,0,0,1,304,328Z"></path>
            </svg>''',
            name: "Virology",
            color: Colors.lightGreen,
            onPressed: () {
              Get.to(
                () => const QuizScreens(title: "Virology"),
              );
            },
          ),
          cardOfTopices(
            svg:
                '''<svg stroke="currentColor" fill="currentColor" stroke-width="0" viewBox="0 0 24 24" class="icon" height="1em" width="1em" xmlns="http://www.w3.org/2000/svg">
              <path d="M12 2C17.5228 2 22 6.47715 22 12C22 17.5228 17.5228 22 12 22C6.47715 22 2 17.5228 2 12C2 6.47715 6.47715 2 12 2ZM9 8C6.792 8 5 9.792 5 12C5 14.208 6.792 16 9 16C10.104 16 11.104 15.552 11.828 14.828L10.4144 13.4144C10.0525 13.7762 9.5525 14 9 14C7.895 14 7 13.105 7 12C7 10.895 7.895 10 9 10C9.55299 10 10.0534 10.2241 10.4153 10.5866L11.829 9.173C11.1049 8.44841 10.1045 8 9 8ZM16 8C13.792 8 12 9.792 12 12C12 14.208 13.792 16 16 16C17.104 16 18.104 15.552 18.828 14.828L17.4144 13.4144C17.0525 13.7762 16.5525 14 16 14C14.895 14 14 13.105 14 12C14 10.895 14.895 10 16 10C16.553 10 17.0534 10.2241 17.4153 10.5866L18.829 9.173C18.1049 8.44841 17.1045 8 16 8Z"></path>
            </svg>''',
            name: "Combined",
            onPressed: () {
              Get.to(
                () => const QuizScreens(title: "Combined"),
              );
            },
          ),
        ],
      ),
    );
  }
}
