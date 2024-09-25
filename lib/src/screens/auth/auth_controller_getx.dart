import 'package:get/get.dart';

import 'login/model/login_response_model.dart';

class AuthControllerGetx extends GetxController {
  RxList<LoginResponseModel> loginResponseModel = <LoginResponseModel>[].obs;
}
