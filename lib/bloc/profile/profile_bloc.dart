import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shartflix/model/user/user_model.dart';
import '../../model/movie/movie_model.dart';
import '/network/api_endpoint.dart';
import '../../model/base_response/base_response_model.dart';
import '../../network/api_error.dart';
import '../../network/api_service.dart';
import 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final String _accessToken;
  ProfileBloc({required String accessToken}) : _accessToken = accessToken, super(ProfileInitial()) {
    on<ProfilePageFetched>(_onProfilePageFetched);
    on<ProfileFetched>(_onProfileFetched);
    on<ProfileFavoriteMovieFetched>(_onProfileFavoriteMovieFetched);
  }

  Future<void> _onProfilePageFetched(ProfilePageFetched event, Emitter<ProfileState> emit) async {
    try {
      emit(ProfileLoading(user: state.user, listFavoriteMovie: state.listFavoriteMovie));
      final req1 = APIService(token: _accessToken).get<BaseResponseModel<UserModel>>(
        ProfileEndpoint(),
        fromJson:
            (json) => BaseResponseModel.fromJson(
              json,
              (dataJson) => UserModel.fromJson(dataJson as Map<String, dynamic>),
            ),
      );
      final req2 = APIService(token: _accessToken).get<BaseResponseModel<List<MovieModel>>>(
        MovieFavoritesEndpoint(),
        fromJson:
            (json) => BaseResponseModel.fromJson(
              json,
              (dataJson) =>
                  List<MovieModel>.from((dataJson as List).map((e) => MovieModel.fromJson(e))),
            ),
      );

      final List res = await Future.wait([req1, req2]);

      if (res.first.responseInfo.code >= 200 &&
          res.first.responseInfo.code < 300 &&
          res.first.data != null) {
        emit(ProfileInformation(user: res.first.data!, listFavoriteMovie: state.listFavoriteMovie));
      } else {
        emit(
          ProfileFailure(
            res.first.responseInfo.message,
            user: state.user,
            listFavoriteMovie: state.listFavoriteMovie,
          ),
        );
      }

      if (res.last.responseInfo.code >= 200 &&
          res.last.responseInfo.code < 300 &&
          res.last.data != null) {
        emit(ProfileFavoriteMovieNext(listFavoriteMovie: res.last.data!, user: state.user));
      } else {
        emit(ProfileFailure(res.last.responseInfo.message));
      }
    } on ApiException catch (e) {
      debugPrint("ApiException Request issue: ${e.message}");
      emit(
        ProfileFailure(e.toString(), user: state.user, listFavoriteMovie: state.listFavoriteMovie),
      );
    } catch (e) {
      emit(
        ProfileFailure(e.toString(), user: state.user, listFavoriteMovie: state.listFavoriteMovie),
      );
    }
  }

  Future<void> _onProfileFetched(ProfileFetched event, Emitter<ProfileState> emit) async {
    try {
      emit(ProfileLoading(user: state.user, listFavoriteMovie: state.listFavoriteMovie));
      final res = await APIService(token: _accessToken).get<BaseResponseModel<UserModel>>(
        ProfileEndpoint(),
        fromJson:
            (json) => BaseResponseModel.fromJson(
              json,
              (dataJson) => UserModel.fromJson(dataJson as Map<String, dynamic>),
            ),
      );

      if (res.responseInfo.code >= 200 && res.responseInfo.code < 300 && res.data != null) {
        emit(ProfileInformation(user: res.data!, listFavoriteMovie: state.listFavoriteMovie));
      } else {
        emit(
          ProfileFailure(
            res.responseInfo.message,
            user: state.user,
            listFavoriteMovie: state.listFavoriteMovie,
          ),
        );
      }
    } on ApiException catch (e) {
      debugPrint("ApiException Request issue: ${e.message}");
      emit(
        ProfileFailure(e.toString(), user: state.user, listFavoriteMovie: state.listFavoriteMovie),
      );
    } catch (e) {
      emit(
        ProfileFailure(e.toString(), user: state.user, listFavoriteMovie: state.listFavoriteMovie),
      );
    }
  }

  Future<void> _onProfileFavoriteMovieFetched(
    ProfileFavoriteMovieFetched event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      emit(ProfileLoading(user: state.user, listFavoriteMovie: state.listFavoriteMovie));
      final res = await APIService(token: _accessToken).get<BaseResponseModel<List<MovieModel>>>(
        MovieFavoritesEndpoint(),
        fromJson:
            (json) => BaseResponseModel.fromJson(
              json,
              (dataJson) =>
                  List<MovieModel>.from((dataJson as List).map((e) => MovieModel.fromJson(e))),
            ),
      );

      if (res.responseInfo.code >= 200 && res.responseInfo.code < 300 && res.data != null) {
        emit(ProfileFavoriteMovieNext(listFavoriteMovie: res.data!, user: state.user));
      } else {
        emit(
          ProfileFavoriteMovieFailure(
            res.responseInfo.message,
            user: state.user,
            listFavoriteMovie: state.listFavoriteMovie,
          ),
        );
      }
    } on ApiException catch (e) {
      debugPrint("ApiException Request issue: ${e.message}");
      emit(
        ProfileFailure(e.toString(), user: state.user, listFavoriteMovie: state.listFavoriteMovie),
      );
    } catch (e) {
      emit(
        ProfileFailure(e.toString(), user: state.user, listFavoriteMovie: state.listFavoriteMovie),
      );
    }
  }
}
