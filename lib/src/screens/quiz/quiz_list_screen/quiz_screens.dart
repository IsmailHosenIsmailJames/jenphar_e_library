import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:jenphar_e_library/src/api/apis.dart';
import 'package:jenphar_e_library/src/screens/quiz/questions_screen/question_model.dart';
import 'package:jenphar_e_library/src/screens/quiz/questions_screen/questions_screen.dart';
import 'package:jenphar_e_library/src/screens/quiz/quiz_list_screen/controller/quiz_list_controller.dart';
import 'package:jenphar_e_library/src/screens/quiz/quiz_list_screen/model/quiz_list_model.dart';

class QuizScreens extends StatefulWidget {
  final String title;
  const QuizScreens({super.key, required this.title});

  @override
  State<QuizScreens> createState() => _QuizScreensState();
}

class _QuizScreensState extends State<QuizScreens> {
  final quizListController = Get.put(QuizListController());
  @override
  void initState() {
    getQuizList();
    super.initState();
  }

  bool loading = false;

  void getQuizList() async {
    setState(() {
      loading = true;
    });
    final response =
        await get(Uri.parse("$apiBase$apiQuizList?category=${widget.title}"));
    log(response.statusCode.toString());
    log(response.body);
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      if (decoded['success'] == true) {
        List<Map> listOfRawQuiz = List<Map>.from(decoded['quizzes']);
        List<QuizListModel> quizListModel = [];
        for (Map e in listOfRawQuiz) {
          quizListModel
              .add(QuizListModel.fromMap(Map<String, dynamic>.from(e)));
        }
        quizListController.quizList.value = quizListModel;
      } else {
        Fluttertoast.showToast(msg: decoded['message'].toString());
      }
    } else {
      Fluttertoast.showToast(msg: 'Something went worng');
    }
    setState(() {
      loading = false;
    });
  }

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
        data: const MediaQueryData()
            .copyWith(textScaler: const TextScaler.linear(0.8)),
        child: GetX<QuizListController>(
          builder: (controller) {
            if (controller.quizList.isEmpty && loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (controller.quizList.isEmpty) {
              return const Center(
                child: Text("There is no Quiz available"),
              );
            } else {
              return ListView.builder(
                itemCount: controller.quizList.length,
                padding: const EdgeInsets.all(20),
                itemBuilder: (context, index) {
                  return quizCard(controller.quizList[index]);
                },
              );
            }
          },
        ),
      ),
    );
  }

  Widget quizCard(QuizListModel quizListModel) {
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
                    quizListModel.name,
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
          const Gap(10),
          Text(
            "Exam Duration",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade700,
            ),
          ),
          Text(
            "${quizListModel.timeDuration} minutes",
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Gap(10),
          Text(
            "Exam Start",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade700,
            ),
          ),
          Text(
            "Date: ${quizListModel.startTime.toIso8601String().split('T')[0]}, Time: ${quizListModel.startTime.toIso8601String().split('T')[1].split('.')[0]}",
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Gap(10),
          Text(
            "Exam End",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade700,
            ),
          ),
          Text(
            "Date: ${quizListModel.endTime.toIso8601String().split('T')[0]}, Time: ${quizListModel.endTime.toIso8601String().split('T')[1].split('.')[0]}",
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
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
