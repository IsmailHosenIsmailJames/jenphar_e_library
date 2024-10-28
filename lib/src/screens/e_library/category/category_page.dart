import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:jenphar_e_library/src/screens/e_library/category/model/category_model.dart';
import 'package:jenphar_e_library/src/screens/e_library/option/option_page.dart';

import '../../../api/apis.dart';
import '../../home/home_screen.dart';
import '../option/options_list.dart';

class CategoryPage extends StatefulWidget {
  final String categoryName;

  const CategoryPage({super.key, required this.categoryName});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  bool dataLoaded = false;
  List<CategoryModel> data = [];
  String errorMsg = "Something Went Wrong";
  @override
  void initState() {
    getData();
    super.initState();
  }

  Future<void> getData() async {
    try {
      final response = await get(Uri.parse(
          "$apiBase/e-library/category?category_name=${widget.categoryName}&is_api=true"));
      if (response.statusCode == 200) {
        List categoryList = List.from((jsonDecode(response.body))['results']);
        for (var i = 0; i < categoryList.length; i++) {
          data.add(
            CategoryModel.fromMap(
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
      appBar: getAppBar(context, widget.categoryName),
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
                        child: CachedNetworkImage(
                          height: MediaQuery.of(context).size.width * 0.25,
                          imageUrl:
                              "http://119.148.39.150:3012/images/medicines/${data[index].brandLogo ?? ""}",
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          placeholder: (context, url) =>
                              Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                        name: data[index].medicineName ?? "",
                        color: Colors.red,
                        fontSize: 14,
                        onPressed: () {
                          Get.to(
                            () => OptionPage(
                              listOfOptions: [
                                trainingManual,
                                journal,
                                eSalesAidOption,
                                campaignsOption,
                                videoOption,
                              ],
                              category: data[index].medicineName ?? "",
                              id: data[index].id.toString(),
                              title: data[index].medicineName ?? "",
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
