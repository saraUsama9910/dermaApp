part of 'diagnosis_cubit_cubit.dart';

@immutable
sealed class DiagnosisCubitState {}

class DiagnosisCubitInitial extends DiagnosisCubitState {}

class AddDiagnosisPhotoState extends DiagnosisCubitState {}

class DeleteDiagnosPhotoState extends DiagnosisCubitState {}

class GetDiagnosisResultLoadingState extends DiagnosisCubitState {}

class GetDiagnosisResultSuccessState extends DiagnosisCubitState {
  final String disease;
  final String confidence;

  GetDiagnosisResultSuccessState({required this.disease,required this.confidence});
}

class GetDiagnosisResultFailureState extends DiagnosisCubitState {
  final String errMessage;

  GetDiagnosisResultFailureState({required this.errMessage});
}
