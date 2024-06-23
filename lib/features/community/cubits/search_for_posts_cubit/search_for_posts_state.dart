part of 'search_for_posts_cubit.dart';

@immutable
abstract class SearchForPostsState {}

class SearchForPostsInitial extends SearchForPostsState {}


class SerachForPostsLoadingState extends SearchForPostsState {}

class SerachForPostsSuccessState extends SearchForPostsState {

  final SearchModel searchModel;

  SerachForPostsSuccessState({required this.searchModel});
}

class SerachForPostsFailureState extends SearchForPostsState {}