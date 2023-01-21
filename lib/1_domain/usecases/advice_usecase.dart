//* casi d'uso sono classi con logica di buisiness che possono
//* essere chiamati dai bloc/cubit e in base ai loro risultati
//* i bloc / cubit emettono uno stato specifico
//*MA E' PURA LOGICA DI DOMINIO DI COME SI FANNO LE COSE IN QUEL DOMINIO
//*ES: recupera gli advice: è un caso d'uso e di come vada fatto, che logiche
//*ci sono dietro ecc ecc è responsabile il caso d'uso NON il bloc/cubit
//* REAL BUSINESS LOGIC! (es: chiamo 2 API e metto insieme i risultati)

import 'package:advicer/0_data/repositories/advice_repo_impl.dart';
import 'package:advicer/1_domain/entities/advice_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../failures/failures.dart';

class AdviceUseCase {
  //*COSA RESTITUISCE? UNA DOMAIN ENTITY!!!con le sue proprietà!
  //!MEGLIO
  //*IN base a cosa ottengo dal repo restituisce O una Failure O (Either!) la
  //* nostra entity!
  //!Either
  //* ha una parte di sinistra (Failure in questo caso)
  //* e una parte di destra (la Enetity che mi aspetto di passare poi alla UI)
  Future<Either<Failure, AdviceEntity>> getAdvice() async {
    debugPrint("ADVICE USE CASE: getAdvice() called ");
    //*will call a repository or more to have Failures or data
    final adviceRepo = AdviceRepoImpl();
    //!sono i repositories che hanno come compito quello di
    //! PRENDERE DATI DA UNA DATASOURCE (i repo! NON lo usecase)
    //! gli use case poi usano e manipolano tali dati e prendono
    //!decisioni / fanno buisiness logic

    //! gli useCase chiedono dati a un repo e poi li usano
    //! NON NON NON DEVONO SAPERE NEMMENO DELL'ESISTENZA DEI DATASOURCES

    //*then proceed with buisiness logic (manipulating data)
    //*return the data asked by cubit/bloc

    // //*FAKE THE USE CASE
    // return await Future.delayed(const Duration(seconds: 2), () {
    //   debugPrint(
    //       "ADVICE USE CASE: got a response from repository: returning to the cubit");
    //   //*dico che deve resituire la parte destra
    //   // return right(AdviceEntity(
    //   //     advice: 'fake advice to test the usecase using entities', id: 1));
    //   //!OPP LA SINISTRA SE qualcosa era andato storto
    //   // debugPrint("ADVICE USE CASE: repo error or logic error");
    //   return left(GeneralFailure()); //* per esempio
    // });
    //*chiamata vera al repo (non fake) e poi vedo cosa torna (Either)
    return adviceRepo.getAdviceFromDataSource();
    //*altra business logica eventuale
  }
}
