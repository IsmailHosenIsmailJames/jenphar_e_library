import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:jenphar_e_library/src/screens/e_library/files_view/pdf/pdf_view.dart';

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
    try {
      final response = await get(Uri.parse(
          "$apiBase/e-library/upload?type=${widget.type}&brand_id=${widget.id}&is_api=true"));
      if (response.statusCode == 200) {
        List categoryList = List.from((jsonDecode(response.body))['results']);
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
    } catch (e) {
      // ignore
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context, widget.title),
      body: (!dataLoaded)
          ? Center(child: CircularProgressIndicator())
          : data.isEmpty
              ? Center(
                  child: Text(errorMsg),
                )
              : GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  padding: const EdgeInsets.only(
                    top: 20,
                    left: 20,
                    right: 20,
                    bottom: 20,
                  ),
                  children: List.generate(
                    data.length,
                    (index) {
                      return cardOfTopics(
                        child: Icon(Icons.picture_as_pdf),
                        name: data[index].file ?? "",
                        color: Colors.red,
                        fontSize: 14,
                        onPressed: () {
                          log("$apiBase/e-library/upload/${data[index].file}");
                          Get.to(
                            () => PdfViewPage(
                              url:
                                  "$apiBase/e-library/upload/${data[index].file}",
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
    );
  }
}
