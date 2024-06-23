import 'package:bloc/bloc.dart';
import 'package:graduation/core/commons/functions.dart';
import 'package:graduation/features/diagnosis/data/repos/diagnosis_repo_impl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:share_plus/share_plus.dart';

part 'diagnosis_cubit_state.dart';

class DiagnosisCubitCubit extends Cubit<DiagnosisCubitState> {
  DiagnosisCubitCubit({required this.diagnosisRepoImplemntation})
      : super(DiagnosisCubitInitial());
  DiagnosisRepoImplemntation diagnosisRepoImplemntation;

  XFile? diagnosisPhoto;

  addDiagnosisPhoto({required XFile image}) {
    diagnosisPhoto = image;
    emit(AddDiagnosisPhotoState());
  }

  deleteTheCurrentPhoto() {
    diagnosisPhoto = null;
    emit(DeleteDiagnosPhotoState());
  }

  addPhotoForDiagnosis({required XFile image}) async {
    emit(GetDiagnosisResultLoadingState());
    final response = await diagnosisRepoImplemntation.getDiagnosis(
      image: await uploadImageToAPI(image),
    );
    response.fold(
      (Error) => emit(GetDiagnosisResultFailureState(errMessage: Error)),
      (success) => emit(
        GetDiagnosisResultSuccessState(disease: success, confidence: success),
      ),
    );
  }
}
