import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/network/api_endpoint.dart';
import '../../model/base_response/base_response_model.dart';
import '../../network/api_error.dart';
import '../../network/api_service.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final String _accessToken;
  ProfileBloc({required String accessToken}) : _accessToken = accessToken, super(ProfileInitial()) {
    on<ProfileFetched>(_onProfileFetched);
  }

  Future<void> _onProfileFetched(ProfileEvent event, Emitter<ProfileState> emit) async {
    try {
      final BaseResponseModel<ProfileInformation> res = await APIService(
        token: _accessToken,
      ).get<BaseResponseModel<ProfileInformation>>(
        ProfileEndpoint(),
        fromJson:
            (json) => BaseResponseModel.fromJson(
              json,
              (dataJson) => ProfileInformation.fromJson(dataJson as Map<String, dynamic>),
            ),
      );

      if (res.responseInfo.code >= 200 && res.responseInfo.code < 300 && res.data != null) {
        emit(res.data!);
      } else {
        emit(ProfileFailure(res.responseInfo.message));
      }
    } on ApiException catch (e) {
      debugPrint("ApiException Request issue: ${e.message}");
      emit(ProfileFailure(e.toString()));
    } catch (e) {
      emit(ProfileFailure(e.toString()));
    }
  }
}
