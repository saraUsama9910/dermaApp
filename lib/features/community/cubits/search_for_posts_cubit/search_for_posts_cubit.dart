import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../data/models/search_model/search_model.dart';
import '../../data/repos/community_repo_implementation.dart';

part 'search_for_posts_state.dart';

class SearchForPostsCubit extends Cubit<SearchForPostsState> {
  SearchForPostsCubit({required this.communityRepoImplementation}) : super(SearchForPostsInitial());



  final CommunityRepoImplementation communityRepoImplementation;

  getPostsNumber({required int postsNumber}) {
    return postsNumber;
  }

  TextEditingController searchController = TextEditingController();
  searchForPosts({required String query}) async {
    emit(SerachForPostsLoadingState());
    final response =
    await communityRepoImplementation.searchForPosts(query: query);

    var postsNum = getPostsNumber(postsNumber: response.data!.posts!.length);

    if (postsNum == 0) {
      emit(SerachForPostsFailureState());
    } else {
      emit(SerachForPostsSuccessState(searchModel: response));
    }
  }









}
