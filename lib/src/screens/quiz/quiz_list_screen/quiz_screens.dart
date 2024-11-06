import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:jenphar_e_library/src/api/apis.dart';
import 'package:jenphar_e_library/src/screens/quiz/questions_screen/questions_screen.dart';
import 'package:jenphar_e_library/src/screens/quiz/quiz_list_screen/controller/quiz_list_controller.dart';
import 'package:jenphar_e_library/src/screens/quiz/quiz_list_screen/model/quiz_list_model.dart';
import 'package:toastification/toastification.dart';

import '../../../core/functions/show_towast.dart';

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
        showToastNotification(
          msg: decoded['message'].toString(),
          context: context,
          type: ToastificationType.success,
        );
      }
    } else {
      showToastNotification(
        msg: 'Something went wrong',
        context: context,
        type: ToastificationType.error,
      );
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
                      const Gap(20),
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
      body: MediaQuery(
        data: const MediaQueryData()
            .copyWith(textScaler: const TextScaler.linear(0.75)),
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
              return StreamBuilder(
                  stream: Stream.periodic(
                    Duration(seconds: 1),
                  ),
                  builder: (context, event) {
                    return ListView.builder(
                      itemCount: controller.quizList.length,
                      padding: const EdgeInsets.all(25),
                      itemBuilder: (context, index) {
                        return quizCard(controller.quizList[index]);
                      },
                    );
                  });
            }
          },
        ),
      ),
    );
  }

  Widget quizCard(QuizListModel quizListModel) {
    DateTime startDate = quizListModel.startTime;
    DateTime endDate = quizListModel.endTime;
    DateTime now = DateTime.now();

    startDate = DateTime(startDate.year, startDate.month, startDate.day,
        startDate.hour, startDate.minute, startDate.second);
    endDate = DateTime(endDate.year, endDate.month, endDate.day, endDate.hour,
        endDate.minute, endDate.second);
    now = DateTime(
        now.year, now.month, now.day, now.hour, now.minute, now.second);

    int status = checkTimeStatus(startDate, endDate);

    return quizListModel.status == "Unpublished"
        ? SizedBox()
        : Container(
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
                  onTap: () async {
                    final infoBox = Hive.box('info');
                    final userInfo =
                        infoBox.get('userInfo', defaultValue: null);
                    final workAreaT = userInfo['work_area_t'];
                    final quizListID = quizListModel.id;
                    await Get.to(
                      () => QuestionsScreen(
                        endtime: quizListModel.endTime,
                        startDate: quizListModel.startTime,
                        examDuration: quizListModel.timeDuration,
                        id: quizListID,
                        titleOfTopic: widget.title,
                        workAreaT: workAreaT,
                      ),
                    );
                  },
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      color: status == 0
                          ? const Color.fromARGB(255, 30, 59, 102)
                          : Colors.grey,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      status == 0
                          ? 'EXAM IS RUNNING'
                          : status == 1
                              ? "EXAM IS UPCOMING"
                              : "TIME OVER",
                      style: const TextStyle(
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

int checkTimeStatus(DateTime startDate, DateTime endDate) {
  final now = DateTime.now();

  if (now.isAfter(endDate)) {
    return -1; // Time over
  } else if (now.isBefore(startDate)) {
    return 1; // Time upcoming
  } else {
    return 0; // Running
  }
}
