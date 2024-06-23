import 'package:bloc/bloc.dart';
import 'package:graduation/features/profile/data/models/change_language_model/change_language_model.dart';
import 'package:meta/meta.dart';

part 'change_language_state.dart';

class ChangeLanguageCubit extends Cubit<ChangeLanguageState> {
  ChangeLanguageCubit() : super(ChangeLanguageInitial());


  final List<ChangeLanguageModel>languagesList=
  [
   ChangeLanguageModel(languageName: 'Arabic', languageSympol: 'ar'),
    ChangeLanguageModel(languageName: 'English', languageSympol: 'en'),

  ];



  onContainerTapped({required List<ChangeLanguageModel> changeLanguageList,required int currentIndex})
  {

    for(var item in changeLanguageList)
      {
        item.isSelected=false;
      }

    changeLanguageList[currentIndex].isSelected=!changeLanguageList[currentIndex].isSelected;
    emit(ChangeContainerState());



  }

  String desiredLanguage='en';

  changeLanguage(String languageSympol)
  {
    desiredLanguage=languageSympol;
    emit(ChangeToAnotherLanguageState());

  }



}
