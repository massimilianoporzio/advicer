//* è un DTO
import 'package:advicer/1_domain/entities/advice_entity.dart';
import 'package:equatable/equatable.dart';

//!eredita dalla mia entity
class AdviceModel extends AdviceEntity with EquatableMixin {
  AdviceModel({required super.advice, required super.id});

  //*altro costruttore factory
  factory AdviceModel.fromJson(Map<String, dynamic> json) {
    return AdviceModel(
      advice: json['advice'],
      id: json['advice_id'], //*dip da API!
    );
  }
}
