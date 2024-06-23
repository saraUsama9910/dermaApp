import 'package:bloc/bloc.dart';
import 'package:graduation/core/commons/constants.dart';
import 'package:meta/meta.dart';

part 'doctor_or_user_state.dart';

class DoctorOrUserCubit extends Cubit<DoctorOrUserCubitState> {
  DoctorOrUserCubit() : super(DoctorOrUserInitial());

  bool? constantValue = AppConstants.isPatient;
  changeToDoctor() {
    AppConstants.isPatient = false;
    constantValue = false;
    emit(ChangeUserToDoctor());
  }

  changeToPatient() {
    AppConstants.isPatient = true;
    constantValue = true;
    emit(ChangeUserToPatient());
  }
}
