import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../model/base_response/base_response_model.dart';
import '../../network/api_endpoint.dart';
import '../../network/api_error.dart';
import '../../network/api_service.dart';
import '../../repositories/token_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final TokenRepository _tokenRepository;
  Authenticated? _auth;
  Authenticated? get auth => _auth;
  AuthBloc({required TokenRepository tokenRepository})
    : _tokenRepository = tokenRepository,
      super(AuthInitial()) {
    on<AppStarted>(_onAppStarted);
    on<LoginRequested>(_onLoginRequested);
    on<RegisterRequested>(_onRegisterRequested);
    on<LogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onAppStarted(AppStarted event, Emitter<AuthState> emit) async {
    debugPrint("_onAppStarted");
    final hasToken = await _tokenRepository.hasValidAuthInfo();
    if (hasToken) {
      final auth = await _tokenRepository.getAuthFromToken();
      debugPrint(auth.toString());
      final authenticated = Authenticated.fromJson(auth!);
      _auth = authenticated;
      emit(authenticated);
    } else {
      emit(Unauthenticated());
    }
  }

  Future<void> _onLoginRequested(LoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final BaseResponseModel<Authenticated> res = await APIService()
          .post<BaseResponseModel<Authenticated>, LoginRequested>(
            LoginEndpoint(),
            body: event,
            fromJson:
                (json) => BaseResponseModel.fromJson(
                  json,
                  (dataJson) => Authenticated.fromJson(dataJson as Map<String, dynamic>),
                ),
          );

      if (res.responseInfo.code == 200 && res.data != null) {
        _tokenRepository.saveTokens(auth: res.data!.token);
        _auth = res.data!;
        emit(res.data!);
      } else {
        emit(AuthFailure(res.responseInfo.message));
      }
    } on ApiException catch (e) {
      debugPrint("ApiException Request issue: ${e.message}");
      emit(AuthFailure(e.toString()));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onRegisterRequested(RegisterRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final BaseResponseModel<Authenticated?> res = await APIService()
          .post<BaseResponseModel<Authenticated?>, RegisterRequested>(
            RegisterEndpoint(),
            body: event,
            fromJson:
                (json) => BaseResponseModel<Authenticated?>.fromJson(
                  json,
                  (dataJson) => Authenticated.fromJson(dataJson as Map<String, dynamic>),
                ),
          );
      if (res.data.runtimeType == Authenticated) {
        emit(res.data!);
      }
    } on ApiException catch (e) {
      debugPrint("ApiException Request issue: ${e.message}");
      emit(AuthFailure(e.toString()));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onLogoutRequested(LogoutRequested event, Emitter<AuthState> emit) async {
    try {
      await _tokenRepository.clearTokens();
      emit(Unauthenticated());
    } catch (e) {
      debugPrint("Logout Error: ${e.toString()}");
      emit(Unauthenticated());
    }
  }
}
