import 'package:get/get.dart';
import '../controller/Work_Entry_Report_Controller.dart';

class WorkEntryReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WorkEntryReportController());
  }
}
