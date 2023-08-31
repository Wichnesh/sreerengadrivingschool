import 'package:get/get.dart';
import '../controller/Attendance_Report_Controller.dart';

class AttendanceReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AttendanceReportController());
  }
}
