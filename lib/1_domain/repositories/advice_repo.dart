//* INTERFACCIA CON IL DATA LAYER

import 'package:advicer/1_domain/entities/advice_entity.dart';

abstract class AdviceRepo {
  //*funzioni che saranno chiamate dallo useCase
  Future<AdviceEntity> getAdviceFromDataSource();
}
