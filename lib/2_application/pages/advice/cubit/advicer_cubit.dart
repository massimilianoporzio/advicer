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
    //*execute Business logicù
    //*MEGLIO! CHIAMO UN USE CASE CHE mi dia un advice
    //!(come lo faccia non mi interessa non lo scrivo nel cubit/bloc)
    //!{
    //! questa parte dovrebbe stare nello use-case getAdvice
    debugPrint("fake get advice triggered");
    await Future.delayed(const Duration(seconds: 3));
    //!}
    //*ERRORE? o ho qualcosa allora il bloc/cubit emette lo stato corrisp
    debugPrint("got advice");
    // emit(const AdvicerCubitStateLoaded(advice: 'fake advice to test!!!'));
    emit(const AdvicerCubitStateError(message: 'error message'));
  }
}
