import 'package:get/get.dart';
import '../controller/Attendance_Controller.dart';

class AttendanceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AttendanceController());
  }
}
