import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../navigator/pages.dart';

part 'navigation_state.dart';
part 'navigation_event.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationState([ConfigLogin])) {
    on<PushPage>((event, emit) {
      final updated = List<PageConfiguration>.from(state.pages)..add(event.page);
      emit(NavigationState(updated));
    });
    on<PopPage>((event, emit) {
      if (state.pages.length > 1) {
        final updated = List<PageConfiguration>.from(state.pages)..removeLast();
        emit(NavigationState(updated));
      }
    });
    on<ReplacePage>((event, emit) {
      final updated = List<PageConfiguration>.from(state.pages);
      if (updated.isNotEmpty) updated.removeLast();
      updated.add(event.page);
      emit(NavigationState(updated));
    });
    on<ReplaceAllPages>((event, emit) {
      emit(NavigationState([event.page]));
    });
  }
}