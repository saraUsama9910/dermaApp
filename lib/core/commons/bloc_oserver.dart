import 'package:flutter_bloc/flutter_bloc.dart';

class MyBlocObserver implements BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    print('${bloc.runtimeType} $change');
  }

  @override
  void onClose(BlocBase bloc) {
    print(bloc);
  }

  @override
  void onCreate(BlocBase bloc) {
    print(bloc);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('${bloc.runtimeType} $error $stackTrace');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    // TODO: implement onEvent
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    // TODO: implement onTransition
  }
}
