import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jenphar_e_library/src/screens/quiz/question_model.dart';
import 'package:jenphar_e_library/src/screens/quiz/questions_screen.dart';

class QuizScreens extends StatefulWidget {
  final String title;
  const QuizScreens({super.key, required this.title});

  @override
  State<QuizScreens> createState() => _QuizScreensState();
}

class _QuizScreensState extends State<QuizScreens> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Jenphar E-Library",
              style: TextStyle(fontSize: 13),
            ),
            Text(
              widget.title,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ],
        ),
        actions: [
          Container(
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
        ],
      ),
      body: MediaQuery(
        data:
            const MediaQueryData().copyWith(textScaler: TextScaler.linear(0.8)),
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: List.generate(
            10,
            (index) {
              return examCard(index);
            },
          ),
        ),
      ),
    );
  }

  Widget examCard(int index) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            color: Colors.grey.shade500,
          )
        ],
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(
                  10,
                ),
                topRight: Radius.circular(10),
              ),
              color: Color.fromARGB(255, 53, 121, 177),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const Gap(5),
                  Text(
                    "Topic",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade200,
                    ),
                  ),
                  Text(
                    index % 2 == 0
                        ? "True/False 3H June & July'24"
                        : "M.C.Q 2 Hemato May'24",
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            color: Colors.green.withOpacity(0.2),
            padding:
                const EdgeInsets.only(left: 10, top: 5, bottom: 5, right: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Exam Duration",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade700,
                  ),
                ),
                const Divider(
                  color: Colors.white,
                  height: 1,
                ),
                const Text(
                  "10 Minutes",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
          Container(
            width: double.infinity,
            color: Colors.amber.withOpacity(0.2),
            padding:
                const EdgeInsets.only(left: 10, top: 5, bottom: 5, right: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Exam Start",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade700,
                  ),
                ),
                const Divider(
                  color: Colors.white,
                  height: 1,
                ),
                const Text(
                  "4:00 PM - 14th Jul, 2024",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
          Container(
            width: double.infinity,
            color: Colors.pink.withOpacity(0.2),
            padding:
                const EdgeInsets.only(left: 10, top: 5, bottom: 5, right: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Exam End",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade700,
                  ),
                ),
                const Divider(
                  color: Colors.white,
                  height: 1,
                ),
                const Text(
                  "4:10 PM - 14th Jul, 2024",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.to(
                () => QuestionsScreen(
                  quiestuons: [
                    {
                      "question":
                          "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                      "options": [
                        "option 1.",
                        "option 2.",
                        "option 3.",
                        "option 4."
                      ]
                    },
                    {
                      "question":
                          "uries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets c",
                      "options": [
                        "option 1.",
                        "option 2.",
                        "option 3.",
                        "option 4."
                      ]
                    },
                    {
                      "question":
                          "The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those intereste",
                      "options": [
                        "option 1.",
                        "option 2.",
                        "option 3.",
                        "option 4."
                      ]
                    },
                    {
                      "question":
                          "Donate: If you use this site regularly and would like to help keep the site on the Internet, please consider donating a small sum to help pay for the hostin ry.",
                      "options": [
                        "option 1.",
                        "option 2.",
                        "option 3.",
                        "option 4."
                      ]
                    },
                    {
                      "question":
                          "Loercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugi and typesetting industry.",
                      "options": [
                        "option 1.",
                        "option 2.",
                        "option 3.",
                        "option 4."
                      ]
                    },
                  ]
                      .map(
                        (e) => QuestionModel.fromMap(e),
                      )
                      .toList(),
                ),
              );
            },
            child: Container(
              height: 60,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                color: Color.fromARGB(255, 30, 59, 102),
              ),
              alignment: Alignment.center,
              child: const Text(
                'START EXAM',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
