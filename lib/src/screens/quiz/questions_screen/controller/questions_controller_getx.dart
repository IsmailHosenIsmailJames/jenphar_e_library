import 'package:get/get.dart';
import 'package:jenphar_e_library/src/screens/quiz/questions_screen/model/question_model.dart';

class QuestionsControllerGetx extends GetxController {
  RxList<QuestionModel> questionModelList = (<QuestionModel>[]).obs;
}
