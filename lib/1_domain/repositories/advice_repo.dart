//* INTERFACCIA CON IL DATA LAYER

import 'package:advicer/1_domain/entities/advice_entity.dart';
import 'package:dartz/dartz.dart';

import '../failures/failures.dart';

abstract class AdviceRepo {
  //*funzioni che saranno chiamate dallo useCase
  //!QUI IL REPO MI DEVE DARE O FAILURE O ENTITY
  //*le implementazioni del repo mapperanno le eccezioni
  //* restituendo le Failure del caso (Server/Cache etc)
  Future<Either<Failure, AdviceEntity>> getAdviceFromDataSource();
}
