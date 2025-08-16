
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shartflix/navigator/app_router.dart';
import 'package:shartflix/navigator/pages.dart';
import 'package:shartflix/repositories/token_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState>{
  final TokenRepository _tokenRepository;

  AuthBloc({
    required TokenRepository tokenRepository
  }) : _tokenRepository = tokenRepository,
        super(AuthState()){
    on<AppStarted>(_onAppStarted);
  }

  Future<void> _onAppStarted(AppStarted event, Emitter<AuthState> emit) async {
    final hasToken = await _tokenRepository.hasValidRefreshToken();
    if (hasToken) {
      final userId = await _tokenRepository.getUserIdFromToken();
      final accessToken = await _tokenRepository.getAccessToken();
      AppRouter.instance.replaceAll(ConfigHome);
      emit(Authenticated(userId: userId!, accessToken: accessToken!));
    } else {
      AppRouter.instance.replaceAll(ConfigLogin);
      emit(Unauthenticated());
    }
  }

}