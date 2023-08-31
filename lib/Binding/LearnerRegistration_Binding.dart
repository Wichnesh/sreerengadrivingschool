import 'package:get/get.dart';
import '../controller/Learner_Registration_Report_Controller.dart';

class LearnerRegistrationReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LearnerRegistratioReportController());
  }
}
