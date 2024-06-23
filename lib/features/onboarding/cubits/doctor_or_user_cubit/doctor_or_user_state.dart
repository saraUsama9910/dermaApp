part of 'doctor_or_user_cubit.dart';

@immutable
abstract class DoctorOrUserCubitState {}

class DoctorOrUserInitial extends DoctorOrUserCubitState {}

class ChangeUserToDoctor extends DoctorOrUserCubitState {}


class ChangeUserToPatient extends DoctorOrUserCubitState {}

