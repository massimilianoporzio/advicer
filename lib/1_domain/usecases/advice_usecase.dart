//* casi d'uso sono classi con logica di buisiness che possono
//* essere chiamati dai bloc/cubit e in base ai loro risultati
//* i bloc / cubit emettono uno stato specifico
//*MA E' PURA LOGICA DI DOMINIO DI COME SI FANNO LE COSE IN QUEL DOMINIO
//*ES: recupera gli advice: è un caso d'uso e di come vada fatto, che logiche
//*ci sono dietro ecc ecc è responsabile il caso d'uso NON il bloc/cubit
//* REAL BUSINESS LOGIC! (es: chiamo 2 API e metto insieme i risultati)

import 'package:advicer/1_domain/entities/advice_entity.dart';
import 'package:flutter/material.dart';

class AdviceUseCase {
  //*COSA RESTITUISCE? UNA DOMAIN ENTITY!!!con le sue proprietà!
  Future<AdviceEntity> getAdvice() async {
    debugPrint("ADVICE USE CASE: getAdvice() called ");
    //*will call a repository or more to have Failures or data
    //*then proceed with buisiness logic (manipulating data)
    //*return the data asked by cubit/bloc

    //*FAKE THE USE CASE
    return await Future.delayed(const Duration(seconds: 2), () {
      debugPrint(
          "ADVICE USE CASE: got a response from repository: returning to the cubit");

      return AdviceEntity(
          advice: 'fake advice to test the usecase using entities', id: 1);
    });
  }
}
