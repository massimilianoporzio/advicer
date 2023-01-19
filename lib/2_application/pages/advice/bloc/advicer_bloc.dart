import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

part 'advicer_event.dart';
part 'advicer_state.dart';

class AdvicerBloc extends Bloc<AdvicerEvent, AdvicerState> {
  AdvicerBloc() : super(AdvicerInitial()) {
    on<AdviceRequestedEvent>((event, emit) async {
      //*RICHESTA: MI METTO IN LOADING
      emit(AdvicerStateLoading());
      //*execute Business logic
      debugPrint("fake get advice triggered");
      await Future.delayed(const Duration(seconds: 3));
      //*ERRORE? o ho qualcosa
      debugPrint("got advice");
      emit(AdvicerStateLoaded(advice: 'fake advice to test!!!'));
      //emit(AdvicerStateError(message: 'error message'));
    });
  }
}
