import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../api/apis.dart';
import '../../home/home_screen.dart';
import 'model/files_view_model.dart';

class FilesViewPage extends StatefulWidget {
  final String title;
  final String id;
  final String type;
  const FilesViewPage({
    super.key,
    required this.title,
    required this.id,
    required this.type,
  });

  @override
  State<FilesViewPage> createState() => _FilesViewPageState();
}

class _FilesViewPageState extends State<FilesViewPage> {
  bool dataLoaded = false;
  List<FilesViewModel> data = [];
  String errorMsg = "Something Went Wrong";
  @override
  void initState() {
    getData();
    super.initState();
  }

  Future<void> getData() async {
    // try {
    log("$apiBase/e-library/upload?type=${widget.type}&brand_id=${widget.id}&is_api=true");
    final response = await get(Uri.parse(
        "$apiBase/e-library/upload?type=${widget.type}&brand_id=${widget.id}&is_api=true"));
    if (response.statusCode == 200) {
      List categoryList = List.from((jsonDecode(response.body))['results']);
      log(categoryList.toString());
      for (var i = 0; i < categoryList.length; i++) {
        data.add(
          FilesViewModel.fromMap(
            Map<String, dynamic>.from(categoryList[i]),
          ),
        );
      }
    } else {
      errorMsg = "URL is not exits";
    }
    setState(() {
      dataLoaded = true;
    });
    // } catch (e) {
    //   log(e.toString());
    //   setState(() {
    //     dataLoaded = true;
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context, widget.title),
      body: (!dataLoaded)
          ? Center(child: CircularProgressIndicator())
          : data.isEmpty
              ? Center(
                  child: Text("Empty"),
                )
              : ListView.builder(
                  itemCount: data.length,
                  padding: const EdgeInsets.only(
                    top: 20,
                    left: 20,
                    right: 20,
                    bottom: 20,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        log(
                          "http://119.148.39.150:3012/uploads/${data[index].file}",
                        );
                        launchUrl(
                          Uri.parse(
                            "http://119.148.39.150:3012/uploads/${data[index].file}",
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          Gap(10),
                          Row(
                            children: [
                              Text(
                                data[index].type == "video" ? "Video" : "File",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color.fromARGB(255, 245, 254, 255),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade400,
                                  blurRadius: 20,
                                ),
                              ],
                            ),
                            margin: EdgeInsets.only(top: 10, bottom: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Gap(10),
                                SizedBox(
                                    height: 50,
                                    child: Image.asset("assets/pdf-icon.png")),
                                const Gap(10),
                                Text(
                                  data[index].file ?? "",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Gap(10),
                                Text(
                                  "Click to view",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                ),
                                Gap(10),
                              ],
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
