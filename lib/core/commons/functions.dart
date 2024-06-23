import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:graduation/core/utils/app_colors.dart';
import 'package:graduation/core/utils/app_styles.dart';
import 'package:image_picker/image_picker.dart';

void navigate(
    {required context, required String route, arg, bool replace = false}) {
  if (replace = true) {
    Navigator.pushReplacementNamed(context, route, arguments: arg);
  }
  Navigator.pushNamed(context, route, arguments: arg);
}

Future uploadImageToAPI(XFile image) async {
  return MultipartFile.fromFile(image.path,
      filename: image.path.split('/').last);
}

void showToast({required String msg, required ToastStates toastStates}) async {
  await Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: getColor(toastStates),
      textColor: Colors.white,
      fontSize: 16.0);
}

Future<XFile?> imagePick({required ImageSource imageSource}) async {
  XFile? image = await ImagePicker().pickImage(source: imageSource);
  return image;
}

enum ToastStates { success, error, warning }

Color getColor(ToastStates toastStates) {
  switch (toastStates) {
    case ToastStates.success:
      return AppColors.kkPrimaryColor;
    case ToastStates.error:
      return AppColors.kkPrimaryColor;
    case ToastStates.warning:
      return AppColors.kkPrimaryColor;
  }
}

showSnackBar(BuildContext context,
    {String? content, Color? color, Widget? specificWidget}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content:
        specificWidget ?? Text(content ?? '', style: AppStyles.textStyle()),
    backgroundColor: color ?? AppColors.white,
    behavior: SnackBarBehavior.floating,
  ));
}

getTimeDifference({required DateTime postDate}) {
  DateTime currentTime = DateTime.now();

  Duration difference = currentTime.difference(postDate);

  int differenceInDays = difference.inDays;
  int differenceInHours = difference.inHours;
  int differenceInMinutes = difference.inMinutes;
  int differenceInSeconds = difference.inSeconds;

  if (differenceInDays > 0) {
    return '$differenceInDays days';
  } else if (differenceInHours > 0) {
    return '$differenceInHours h';
  } else if (differenceInMinutes > 0) {
    return '$differenceInMinutes m';
  } else {
    return '$differenceInSeconds s';
  }
}

String getEmail({required String currentEmail}) {
  int emailLength = 14;
  String displayedName = currentEmail.length > emailLength
      ? '${currentEmail.substring(0, emailLength)}.'
      : currentEmail;
  return displayedName;
}

String getUserName({required String currentUserName}) {
  int userNameLength = 16;
  String displayedName = currentUserName.length > userNameLength
      ? '${currentUserName.substring(0, userNameLength)}.'
      : currentUserName;
  return displayedName;
}

String formatTime(String? createdAt) {
  if (createdAt == null) return '';

  final timePart = createdAt.split('T')[1];
  final hour = int.parse(timePart.split(':')[0]);
  final minute = timePart.split(':')[1];

  final period = hour >= 12 ? 'PM' : 'AM';
  final formattedHour =
      hour % 12 == 0 ? 12 : hour % 12; // Convert to 12-hour format

  return '$formattedHour:$minute $period';
}

String formatDate(String? createdAt) {
  if (createdAt == null) return '';

  final datePart = createdAt.split('T')[0];
  final dateParts = datePart.split('-');
  final formattedDate = '${dateParts[2]}/${dateParts[1]}/${dateParts[0]}';

  return formattedDate;
}
