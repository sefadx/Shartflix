import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shartflix/network/api_endpoint.dart';
import '../../model/base_response/base_response_model.dart';
import '../../network/api_error.dart';
import '../../network/api_service.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final String _accessToken;
  HomeBloc({required String accessToken}) : _accessToken = accessToken, super(HomeInitial()) {
    on<HomeStarted>(_onHomeStarted);
    on<HomeFetched>(_onHomeFetched);
  }

  Future<void> _onHomeStarted(HomeEvent event, Emitter<HomeState> emit) async {}

  Future<void> _onHomeFetched(HomeFetched event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
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
        emit(res.data!);
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
