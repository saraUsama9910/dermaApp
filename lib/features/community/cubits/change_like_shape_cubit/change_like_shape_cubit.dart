import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'change_like_shape_state.dart';

class ChangeLikeShapeCubit extends Cubit<ChangeLikeShapeState> {
  ChangeLikeShapeCubit() : super(ChangeLikeShapeInitial());


  bool likeIsActive=false;
  changeLikeShape()
  {

    likeIsActive=!likeIsActive;
    emit(ChangeLikeShapeSuccessState());
  }
}
