import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'advicer_state.dart';

class AdvicerCubit extends Cubit<AdvicerCubitState> {
  AdvicerCubit() : super(AdvicerCubitInitial());

  //*CUBIT USANO FUNCTION PER GLI EVENTI
  //*che non possono + venire tracciati
  //*ma sono più snelli
  void adviceRequested() async {
    //*RICHESTA: MI METTO IN LOADING
    emit(AdvicerCubitStateLoading());
    //*execute Business logic
    debugPrint("fake get advice triggered");
    await Future.delayed(const Duration(seconds: 3));
    //*ERRORE? o ho qualcosa
    debugPrint("got advice");
    emit(const AdvicerCubitStateLoaded(advice: 'fake advice to test!!!'));
    //emit(AdvicerStateError(message: 'error message'));
  }
}
