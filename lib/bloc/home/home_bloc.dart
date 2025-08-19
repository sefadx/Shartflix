import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../model/base_response/base_response_model.dart';
import '../../model/movie/movie_model.dart';
import '../../network/api_endpoint.dart';
import '../../network/api_error.dart';
import '../../network/api_service.dart';
import 'home_event.dart';
import 'home_state.dart';

class NavCubit extends Cubit<int> {
  NavCubit(super.initialState);
  void changeIndex(int index) => emit(index);
}

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final String _accessToken;
  HomeBloc({required String accessToken}) : _accessToken = accessToken, super(HomeInitial()) {
    on<HomeStarted>(_onHomeStarted);
    on<HomeMovieFetched>(_onHomeFetched);
    on<HomeMovieFavoriteRequest>(_onHomeMovieFavorite);
  }

  Future<void> _onHomeStarted(HomeEvent event, Emitter<HomeState> emit) async {}

  Future<void> _onHomeFetched(HomeMovieFetched event, Emitter<HomeState> emit) async {
    emit(HomeLoading(listMovie: state.listMovie, pagination: state.pagination));
    try {
      final BaseResponseModel<HomeNext> res = await APIService(
        token: _accessToken,
      ).get<BaseResponseModel<HomeNext>>(
        MovieEndpoint(page: event.page),
        fromJson:
            (json) => BaseResponseModel.fromJson(
              json,
              (dataJson) => HomeNext.fromJson(dataJson as Map<String, dynamic>),
            ),
      );

      if (res.responseInfo.code >= 200 && res.responseInfo.code < 300 && res.data != null) {
        List<MovieModel> list = [];
        if (event.page > 1) list = state.listMovie;
        final updatedList = List<MovieModel>.from(list)..addAll(res.data!.listMovie);
        emit(HomeNext(listMovie: updatedList, pagination: res.data!.pagination));
      } else {
        emit(HomeFailure(res.responseInfo.message));
      }
    } on ApiException catch (e) {
      debugPrint("ApiException Request issue: ${e.message}");
      emit(HomeFailure(e.toString()));
    } catch (e) {
      emit(HomeFailure(e.toString()));
    }
  }

  Future<void> _onHomeMovieFavorite(HomeMovieFavoriteRequest event, Emitter<HomeState> emit) async {
    emit(HomeLoading(listMovie: state.listMovie, pagination: state.pagination));
    try {
      final BaseResponseModel<MovieModel> res = await APIService(
        token: _accessToken,
      ).post<BaseResponseModel<MovieModel>, Empty>(
        MovieFavoritesEndpoint(id: event.favoriteId),
        body: Empty(),
        fromJson:
            (json) => BaseResponseModel.fromJson(
              json,
              (dataJson) => MovieModel.fromJson((dataJson as Map<String, dynamic>)['movie']),
            ),
      );

      if (res.responseInfo.code >= 200 && res.responseInfo.code < 300 && res.data != null) {
        List<MovieModel> updatedList = state.listMovie;
        final index = updatedList.indexWhere((movie) => movie.id == event.favoriteId);
        updatedList.replaceRange(index, index + 1, [res.data!]);
        emit(HomeMovieFavorite(listMovie: updatedList));
      } else {
        emit(HomeFailure(res.responseInfo.message));
      }
    } on ApiException catch (e) {
      debugPrint("ApiException Request issue: ${e.message}");
      emit(HomeFailure(e.toString()));
    } catch (e) {
      emit(HomeFailure(e.toString()));
    }
  }
}
