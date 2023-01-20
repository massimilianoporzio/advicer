import 'package:advicer/1_domain/failures/failures.dart';
import 'package:advicer/1_domain/usecases/advice_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'advicer_state.dart';

const String genericFailureMessage =
    'Ups! Something gone wrong. Please try again!';
const String cacheFailureMessage = 'Ups, cache error. Please try again!';
const String serverFailureMessage = 'Ups, API Error. Please try again!';

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
    final falureOrAdvice = await adviceUseCase.getAdvice();
    //!}
    //*ERRORE? o ho qualcosa allora il bloc/cubit emette lo stato corrisp
    //!L'IDEA è guardo se ho una FAILURE o LA MIA ENTITY
    //*in base a cosa mi ritornerà il mio caso d'uso emetto uno stato apposito
    //*DEVO FARE IL FOLD sulla risposta per capire se ho failure o entity
    //!con il fold posso specificare 2 funzioni da applicare se ho ricevuto
    //!la parte sinistra (return left(...)) o la destra (return right(...))
    falureOrAdvice.fold(
      (failure) {
        debugPrint(
            "Advice CUBIT: got a Falire from the useCase: returning it to UI in the ERROR State");
        emit(AdvicerCubitStateError(message: _mapFailureToMessage(failure)));
      },
      (advice) {
        debugPrint(
            "Advice CUBIT: got advice in Cubit: returning it to UI in the LOADED State");
        emit(AdvicerCubitStateLoaded(advice: advice.advice));
      },
    );
  }

  //* CUBIT HA LOGICA DI APPLICAZIONE / PRESENTAZIONE
  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return serverFailureMessage;
      case CacheFailure:
        return cacheFailureMessage;
      default:
        return genericFailureMessage;
    }
  }
}
