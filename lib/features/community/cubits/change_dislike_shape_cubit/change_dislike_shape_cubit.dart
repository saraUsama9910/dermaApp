import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'change_dislike_shape_state.dart';

class ChangeDislikeShapeCubit extends Cubit<ChangeDislikeShapeState> {
  ChangeDislikeShapeCubit() : super(ChangeDislikeShapeInitial());




  bool dislikeIsActive=false;
  changeDislikeShape()
  {
    dislikeIsActive=!dislikeIsActive;
    emit(ChangeDislikeShapeSuccessState());
  }
}
