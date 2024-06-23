import 'package:graduation/core/cache/cache_helper.dart';

class AppConstants {
  static const String GEMINI_API_KEY =
      "AIzaSyDhbVXUpte3JrGU2Nd_Lwjx_trEWFwcO8E";

  static bool isPatient = CacheHelper().getData(key: isPatientKey) ?? false;

  static String isPatientKey = 'isPatient';
}
