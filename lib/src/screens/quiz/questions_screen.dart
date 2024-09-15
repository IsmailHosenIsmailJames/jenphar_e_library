import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:jenphar_e_library/src/screens/quiz/question_model.dart';

class QuestionsScreen extends StatefulWidget {
  final List<QuestionModel> quiestuons;
  const QuestionsScreen({super.key, required this.quiestuons});

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  final DateTime startTime = DateTime.now();
  int secondsReaming = 10 * 60;
  bool isDisposed = false;

  int indexOfQuestion = 0;

  int selectedOption = -1;

  @override
  void initState() {
    Stream.periodic(const Duration(seconds: 1), (i) {
      final dis = DateTime.now().difference(startTime);
      return (10 * 60) - dis.inSeconds;
    }).listen(
      (event) {
        if (event <= 0) {
          indexOfQuestion = widget.quiestuons.length;
        }
        if (!isDisposed) {
          setState(() {
            secondsReaming = event;
          });
        }
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    isDisposed = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Jenphar E-Library",
              style: TextStyle(fontSize: 13),
            ),
            Text(
              "Questions",
              style: TextStyle(
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Gap(10),
          if (indexOfQuestion != widget.quiestuons.length)
            Center(
              child: Text(
                "${secondsReaming ~/ 60}:${(secondsReaming % 60)}",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ),
          const Gap(10),
          if (indexOfQuestion != widget.quiestuons.length)
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 10,
                    color: Colors.grey,
                  ),
                ],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Question ${indexOfQuestion + 1}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  Text(
                    widget.quiestuons[indexOfQuestion].question ?? "",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.blue.shade800,
                    ),
                  ),
                ],
              ),
            ),
          indexOfQuestion != widget.quiestuons.length
              ? Column(
                  children: List.generate(
                    widget.quiestuons[indexOfQuestion].options!.length,
                    (index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            setState(() {
                              selectedOption = index;
                            });
                          },
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.blue.shade900,
                                foregroundColor: Colors.white,
                                child: Text((index + 1).toString()),
                              ),
                              const Gap(10),
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: const [
                                    BoxShadow(
                                      blurRadius: 10,
                                      color: Colors.grey,
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.72,
                                      child: Text(
                                        widget.quiestuons[indexOfQuestion]
                                            .options![index],
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    selectedOption != index
                                        ? const Icon(
                                            Icons.radio_button_off,
                                          )
                                        : Icon(
                                            Icons.radio_button_checked,
                                            color: Colors.blue.shade900,
                                          ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
              : Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 10,
                          color: Colors.grey,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 65,
                          width: 65,
                          child: SvgPicture.string(
                            '''<svg class="icon" stroke="currentColor" fill="currentColor" stroke-width="0" viewBox="0 0 512 512" height="1em" width="1em" xmlns="http://www.w3.org/2000/svg">
                                  <path d="M336 16V80c0 8.8-7.2 16-16 16s-16-7.2-16-16V16c0-8.8 7.2-16 16-16s16 7.2 16 16zm-98.7 7.1l32 48c4.9 7.4 2.9 17.3-4.4 22.2s-17.3 2.9-22.2-4.4l-32-48c-4.9-7.4-2.9-17.3 4.4-22.2s17.3-2.9 22.2 4.4zM135 119c9.4-9.4 24.6-9.4 33.9 0L292.7 242.7c10.1 10.1 27.3 2.9 27.3-11.3V192c0-17.7 14.3-32 32-32s32 14.3 32 32V345.6c0 57.1-30 110-78.9 139.4c-64 38.4-145.8 28.3-198.5-24.4L7 361c-9.4-9.4-9.4-24.6 0-33.9s24.6-9.4 33.9 0l53 53c6.1 6.1 16 6.1 22.1 0s6.1-16 0-22.1L23 265c-9.4-9.4-9.4-24.6 0-33.9s24.6-9.4 33.9 0l93 93c6.1 6.1 16 6.1 22.1 0s6.1-16 0-22.1L55 185c-9.4-9.4-9.4-24.6 0-33.9s24.6-9.4 33.9 0l117 117c6.1 6.1 16 6.1 22.1 0s6.1-16 0-22.1l-93-93c-9.4-9.4-9.4-24.6 0-33.9zM433.1 484.9c-24.2 14.5-50.9 22.1-77.7 23.1c48.1-39.6 76.6-99 76.6-162.4l0-98.1c8.2-.1 16-6.4 16-16V192c0-17.7 14.3-32 32-32s32 14.3 32 32V345.6c0 57.1-30 110-78.9 139.4zM424.9 18.7c7.4 4.9 9.3 14.8 4.4 22.2l-32 48c-4.9 7.4-14.8 9.3-22.2 4.4s-9.3-14.8-4.4-22.2l32-48c4.9-7.4 14.8-9.3 22.2-4.4z"></path>
                                </svg>''',
                            color: Colors.blue,
                          ),
                        ),
                        const Text(
                          "Thanks for completing the Quiz",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
          Gap(20),
          if (indexOfQuestion != widget.quiestuons.length)
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.90,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade900,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  indexOfQuestion++;
                  setState(() {});
                },
                child: Text(
                  "Next",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
