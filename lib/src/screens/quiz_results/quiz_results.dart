import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart';
import 'package:jenphar_e_library/src/api/apis.dart';
import 'package:jenphar_e_library/src/screens/home/home_screen.dart';
import 'package:jenphar_e_library/src/screens/quiz_results/model/quiz_results_model.dart';

class QuizResults extends StatefulWidget {
  const QuizResults({super.key});

  @override
  State<QuizResults> createState() => _QuizResultsState();
}

class _QuizResultsState extends State<QuizResults> {
  bool? isSuccessful;
  QuizResultsModel? quizResultsModel;

  @override
  void initState() {
    getDataFormServer();
    super.initState();
  }

  getDataFormServer() async {
    try {
      log("Going to call : $apiBase/api/quiz_results?work_area_t=${Hive.box("info").get("userInfo")['work_area_t']}");
      final response = await get(Uri.parse(
          "$apiBase/api/quiz_results?work_area_t=${Hive.box("info").get("userInfo")['work_area_t']}"));
      if (response.statusCode == 200) {
        final quizResultData = jsonDecode(response.body);
        quizResultsModel = QuizResultsModel.fromMap(quizResultData);
        log("quizResultsModel : ${quizResultsModel!.toJson()}");

        setState(() {
          isSuccessful = true;
        });
      } else {
        setState(() {
          isSuccessful = false;
        });
      }
    } catch (e) {
      setState(() {
        isSuccessful = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context, "Quiz Results"),
      body: isSuccessful == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : isSuccessful == false || quizResultsModel == null
              ? Center(child: Text("Failed to load data"))
              : ListView.builder(
                  padding: EdgeInsets.all(20),
                  itemCount: quizResultsModel!.data!.length,
                  itemBuilder: (context, index) {
                    final current = quizResultsModel!.data![index];
                    return Container(
                      margin: EdgeInsets.only(bottom: 10),
                      padding: EdgeInsets.all(10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Quiz",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: Colors.grey.shade500,
                                    ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: Text(
                                  current.quizName ?? "",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "${current.totalMarks}/${current.totalPoints}",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  color: Colors.blue.shade600,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
    );
  }
}
