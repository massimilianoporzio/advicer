import 'package:advicer/1_domain/usecases/advice_usecase.dart';
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
    final AdviceUseCase adviceUseCase = AdviceUseCase();
    //* potrebbe anche usare ALTRI useCases (collection of methods)
    //!(come lo faccia non mi interessa non lo scrivo nel cubit/bloc)
    //!{
    //! questa parte dovrebbe stare nello use-case getAdvice
    debugPrint("Advice CUBIT: fake get advice triggered in Cubit");
    // await Future.delayed(const Duration(seconds: 3));
    //*chiamo funzione dello useCase:
    debugPrint("Advice CUBIT: Called the useCase");
    final advice = await adviceUseCase.getAdvice();
    //!}
    //*ERRORE? o ho qualcosa allora il bloc/cubit emette lo stato corrisp
    debugPrint(
        "Advice CUBIT: got advice in Cubit: returning it to UI in the State");
    emit(AdvicerCubitStateLoaded(advice: advice.advice));
    // emit(const AdvicerCubitStateError(message: 'error message'));
  }
}
