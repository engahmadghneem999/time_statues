import 'package:get/get.dart';

import '../../../core/class/crud.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
   Get.put(Crud());
  }
}
