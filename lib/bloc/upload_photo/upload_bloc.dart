import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shartflix/network/api_endpoint.dart';

import '../../model/base_response/base_response_model.dart';
import '../../network/api_error.dart';
import '../../network/api_service.dart';

part 'upload_state.dart';
part 'upload_event.dart';

class UploadBloc extends Bloc<UploadEvent, UploadState> {
  final String _accessToken;
  UploadBloc({required String accessToken}) : _accessToken = accessToken, super(UploadState()) {
    on<UploadPhoto>(_onUploadPhoto);
  }
  Future<void> _onUploadPhoto(UploadPhoto event, Emitter emit) async {
    emit(Uploading());
    try {
      final BaseResponseModel res = await APIService(token: _accessToken).upload(
        PhotoUploadEndpoint(),
        filePath: event.filePath,
        body: Empty(),
        fromJson: (json) => BaseResponseModel.fromJson(json, (_) => Empty()),
      );

      if (res.responseInfo.code == 200 && res.data != null) {
        emit(Uploaded());
      } else {
        emit(UploadFailed(res.responseInfo.message));
      }
    } on ApiException catch (e) {
      debugPrint("ApiException Request issue: ${e.message}");
      emit(UploadFailed(e.toString()));
    } catch (e) {
      emit(UploadFailed(e.toString()));
    }
  }
}
