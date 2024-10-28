import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jenphar_e_library/src/screens/e_library/files_view/files_view_page.dart';
import 'package:jenphar_e_library/src/screens/home/home_screen.dart';

class OptionPage extends StatefulWidget {
  final String title;
  final String id;
  final String category;
  final List<Map<String, String>> listOfOptions;
  const OptionPage({
    super.key,
    required this.title,
    required this.id,
    required this.category,
    required this.listOfOptions,
  });

  @override
  State<OptionPage> createState() => _OptionPageState();
}

class _OptionPageState extends State<OptionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(
        context,
        widget.category,
      ),
      body: GridView(
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
          widget.listOfOptions.length,
          (index) {
            return cardOfTopics(
              svg: widget.listOfOptions[index]['svg']!,
              name: widget.listOfOptions[index]['title'] ?? "",
              color: Colors.blue,
              fontSize: 14,
              onPressed: () {
                Get.to(
                  () => FilesViewPage(
                    title: widget.listOfOptions[index]['title']!,
                    id: widget.listOfOptions[index]['brand_id']!,
                    type: widget.listOfOptions[index]['type']!,
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
