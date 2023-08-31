import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../Binding/Attendance_Binding.dart';
import '../Binding/Attendance_Report_Binding.dart';
import '../Binding/LearnerRegistration_Binding.dart';
import '../Binding/WorkEntryReport_Binding.dart';
import '../View/Form/Attendance.dart';
import '../View/Form/Attendance_Report.dart';
import '../View/Form/Attendance_Report_Search.dart';
import '../View/Form/Form_Detail/AttendanceDetail.dart';
import '../View/Form/Learner_Registration_Report.dart';
import '../View/Form/Learner_Registration_Search.dart';
import '../View/Form/Learner_Regsitration_Form.dart';
import '../View/Form/Work_Entry_Form.dart';
import '../View/Form/Work_Entry_Report.dart';
import '../View/Form/Work_Entry_Search.dart';
import '../View/Home_Screen.dart';
import '../View/Login_Screen.dart';
import '../utils/constant.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(name: ROUTE_LOGIN, page: () => const LoginScreen()),
    GetPage(name: ROUTE_HOME, page: () => const HomeScreen()),
    GetPage(name: ROUTE_WORKENTRYFORM, page: () => const WorkEntryForm()),
    GetPage(
        name: ROUTE_LEARNERREGISTRATIONFORM,
        page: () => const Learner_Registration_Form()),
    GetPage(
        name: ROUTE_WORKENTRYREPORT,
        page: () => const WorkEntryReport(),
        binding: WorkEntryReportBinding()),
    GetPage(
        name: ROUTE_LEARNERREGISTRATIONREPORT,
        page: () => const LearnerRegistrationReport(),
        binding: LearnerRegistrationReportBinding()),
    GetPage(
        name: ROUTE_ATTENDANCE,
        page: () => const Attendance(),
        binding: AttendanceBinding()),
    GetPage(name: ROUTE_WORKENTRYSEARCH, page: () => const WorkEntrySearch()),
    GetPage(
        name: ROUTE_LEARNERREGISTRATIONSEARCH,
        page: () => const LearnerRegistrationSearch()),
    GetPage(
        name: ROUTE_ATTENDANCEREPORT,
        page: () => const AttendanceReport(),
        binding: AttendanceReportBinding()),
    GetPage(
        name: ROUTE_ATTENDANCEREPORTSEARCH,
        page: () => const AttendanceReportSearch()),
  ];
}
