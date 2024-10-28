import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:jenphar_e_library/src/api/apis.dart';
import 'package:jenphar_e_library/src/screens/e_library/category/category_page.dart';
import 'package:jenphar_e_library/src/screens/e_library/files_view/files_view_page.dart';
import 'package:jenphar_e_library/src/screens/home/home_screen.dart';

import '../quiz/quiz_list_screen/quiz_screens.dart';

class ELibraryPage extends StatefulWidget {
  const ELibraryPage({super.key});

  @override
  State<ELibraryPage> createState() => _ELibraryPageState();
}

class _ELibraryPageState extends State<ELibraryPage> {
  bool dataLoaded = false;
  Map? data;
  String errorMsg = "Something Went Wrong";
  @override
  void initState() {
    getData();
    super.initState();
  }

  Future<void> getData() async {
    try {
      final response = await get(Uri.parse("$apiBase/e-library?is_api=true"));
      if (response.statusCode == 200) {
        data = Map.from(jsonDecode(response.body)['result']);
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
      appBar: getAppBar(context, "E-Library"),
      body: (!dataLoaded)
          ? Center(child: CircularProgressIndicator())
          : data == null
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
                  ),
                  children: [
                    cardOfTopics(
                      svg:
                          '''<svg stroke="currentColor" fill="currentColor" stroke-width="0" viewBox="0 0 24 24" class="icon" height="1em" width="1em" xmlns="http://www.w3.org/2000/svg">
              <path fill="none" d="M0 0h24v24H0z"></path>
              <path d="M12 2c-5.33 4.55-8 8.48-8 11.8 0 4.98 3.8 8.2 8 8.2s8-3.22 8-8.2c0-3.32-2.67-7.25-8-11.8zM7.83 14c.37 0 .67.26.74.62.41 2.22 2.28 2.98 3.64 2.87.43-.02.79.32.79.75 0 .4-.32.73-.72.75-2.13.13-4.62-1.09-5.19-4.12a.75.75 0 01.74-.87z"></path>
            </svg>''',
                      name: "Hematology",
                      color: Colors.red,
                      onPressed: () {
                        Get.to(
                          () => CategoryPage(
                            categoryName: "Hematology",
                          ),
                        );
                      },
                    ),
                    cardOfTopics(
                      svg:
                          '''<svg stroke="currentColor" fill="currentColor" stroke-width="0" viewBox="0 0 448 512" class="icon" height="1em" width="1em" xmlns="http://www.w3.org/2000/svg">
              <path d="M6.1 444.3c-9.6 10.8-7.5 27.6 4.5 35.7l68.8 27.9c9.9 6.7 23.3 5 31.3-3.8l91.8-101.9-79.2-87.9-117.2 130zm435.8 0s-292-324.6-295.4-330.1c15.4-8.4 40.2-17.9 77.5-17.9s62.1 9.5 77.5 17.9c-3.3 5.6-56 64.6-56 64.6l79.1 87.7 34.2-38c28.7-31.9 33.3-78.6 11.4-115.5l-43.7-73.5c-4.3-7.2-9.9-13.3-16.8-18-40.7-27.6-127.4-29.7-171.4 0-6.9 4.7-12.5 10.8-16.8 18l-43.6 73.2c-1.5 2.5-37.1 62.2 11.5 116L337.5 504c8 8.9 21.4 10.5 31.3 3.8l68.8-27.9c11.9-8 14-24.8 4.3-35.6z"></path>
            </svg>''',
                      name: "Oncology",
                      color: Colors.pink.shade300,
                      onPressed: () {
                        Get.to(
                          () => CategoryPage(
                            categoryName: "Oncology",
                          ),
                        );
                      },
                    ),
                    cardOfTopics(
                      svg:
                          '''<svg stroke="currentColor" fill="currentColor" stroke-width="0" viewBox="0 0 512 512" class="icon" height="1em" width="1em" xmlns="http://www.w3.org/2000/svg">
              <path d="M483.55,227.55H462c-50.68,0-76.07-61.27-40.23-97.11L437,115.19A28.44,28.44,0,0,0,396.8,75L381.56,90.22c-35.84,35.83-97.11,10.45-97.11-40.23V28.44a28.45,28.45,0,0,0-56.9,0V50c0,50.68-61.27,76.06-97.11,40.23L115.2,75A28.44,28.44,0,0,0,75,115.19l15.25,15.25c35.84,35.84,10.45,97.11-40.23,97.11H28.45a28.45,28.45,0,1,0,0,56.89H50c50.68,0,76.07,61.28,40.23,97.12L75,396.8A28.45,28.45,0,0,0,115.2,437l15.24-15.25c35.84-35.84,97.11-10.45,97.11,40.23v21.54a28.45,28.45,0,0,0,56.9,0V462c0-50.68,61.27-76.07,97.11-40.23L396.8,437A28.45,28.45,0,0,0,437,396.8l-15.25-15.24c-35.84-35.84-10.45-97.12,40.23-97.12h21.54a28.45,28.45,0,1,0,0-56.89ZM224,272a48,48,0,1,1,48-48A48,48,0,0,1,224,272Zm80,56a24,24,0,1,1,24-24A24,24,0,0,1,304,328Z"></path>
            </svg>''',
                      name: "Virology",
                      color: Colors.lightGreen,
                      onPressed: () {
                        Get.to(
                          () => CategoryPage(
                            categoryName: "Virology",
                          ),
                        );
                      },
                    ),
                    cardOfTopics(
                      svg:
                          '''<svg class="icon" stroke="currentColor" fill="currentColor" stroke-width="0" viewBox="0 0 24 24" height="1em" width="1em" xmlns="http://www.w3.org/2000/svg"><path d="M20 1.999H4c-1.103 0-2 .897-2 2v18l4-4h14c1.103 0 2-.897 2-2v-12c0-1.103-.897-2-2-2zm-6 11H7v-2h7v2zm3-4H7v-2h10v2z"></path></svg>''',
                      name: "E-Detailing",
                      onPressed: () {
                        Get.to(
                          () => const QuizScreens(title: "E-Detailing"),
                        );
                      },
                    ),
                    cardOfTopics(
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
                    cardOfTopics(
                      svg:
                          '''<svg class="icon" stroke="currentColor" fill="currentColor" stroke-width="0" viewBox="0 0 1024 1024" height="1em" width="1em" xmlns="http://www.w3.org/2000/svg"><path d="M160 894c0 17.7 14.3 32 32 32h286V550H160v344zm386 32h286c17.7 0 32-14.3 32-32V550H546v376zm334-616H732.4c13.6-21.4 21.6-46.8 21.6-74 0-76.1-61.9-138-138-138-41.4 0-78.7 18.4-104 47.4-25.3-29-62.6-47.4-104-47.4-76.1 0-138 61.9-138 138 0 27.2 7.9 52.6 21.6 74H144c-17.7 0-32 14.3-32 32v140h366V310h68v172h366V342c0-17.7-14.3-32-32-32zm-402-4h-70c-38.6 0-70-31.4-70-70s31.4-70 70-70 70 31.4 70 70v70zm138 0h-70v-70c0-38.6 31.4-70 70-70s70 31.4 70 70-31.4 70-70 70z"></path></svg>''',
                      name: "Upcoming Brands",
                      onPressed: () {
                        Get.to(
                          () => const QuizScreens(title: "Upcoming Brands"),
                        );
                      },
                    ),
                    cardOfTopics(
                      svg:
                          '''<svg class="icon" stroke="currentColor" fill="none" stroke-width="2" viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round" height="1em" width="1em" xmlns="http://www.w3.org/2000/svg"><path stroke="none" d="M0 0h24v24H0z" fill="none"></path><path d="M8 5h-2a2 2 0 0 0 -2 2v12a2 2 0 0 0 2 2h5.697"></path><path d="M18 14v4h4"></path><path d="M18 11v-4a2 2 0 0 0 -2 -2h-2"></path><path d="M8 3m0 2a2 2 0 0 1 2 -2h2a2 2 0 0 1 2 2v0a2 2 0 0 1 -2 2h-2a2 2 0 0 1 -2 -2z"></path><path d="M18 18m-4 0a4 4 0 1 0 8 0a4 4 0 1 0 -8 0"></path><path d="M8 11h4"></path><path d="M8 15h3"></path></svg>''',
                      name: "Monthly Exam Result",
                      onPressed: () {
                        Get.to(
                          () => FilesViewPage(
                            type: "result",
                            title: "Result",
                            id: data!['monthly_exam_result'],
                          ),
                        );
                      },
                    ),
                  ],
                ),
    );
  }
}
