import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:jenphar_e_library/src/api/apis.dart';
import 'package:jenphar_e_library/src/screens/home/home_screen.dart';
import 'package:jenphar_e_library/src/screens/leader_board/model/leader_board_model.dart';

class LeaderBoard extends StatefulWidget {
  const LeaderBoard({super.key});

  @override
  State<LeaderBoard> createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
  bool? isSuccessful;
  LeaderBoardModel? leaderBoardModel;

  @override
  void initState() {
    getDataFormServer();
    super.initState();
  }

  getDataFormServer() async {
    try {
      log("Going to call : $apiBase/api/leaderboard");
      final response = await get(Uri.parse("$apiBase/api/leaderboard"));
      if (response.statusCode == 200) {
        final leaderBoardData = jsonDecode(response.body);
        leaderBoardModel = LeaderBoardModel.fromMap(leaderBoardData);
        log("leaderBoardModel : ${leaderBoardModel!.toJson()}");
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
          : isSuccessful == false || leaderBoardModel == null
              ? Center(child: Text("Failed to load data"))
              : ListView.builder(
                  padding: EdgeInsets.all(20),
                  itemCount: leaderBoardModel!.leaderboard!.length,
                  itemBuilder: (context, index) {
                    final current = leaderBoardModel!.leaderboard![index];
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
                                  current.userName ?? "",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "${current.totalMarks}",
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
