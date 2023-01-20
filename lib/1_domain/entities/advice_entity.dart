import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class AdviceEntity extends Equatable {
  final String advice;
  final int id;

  AdviceEntity({
    required this.advice,
    required this.id,
  }) {
    debugPrint("creating an AdviceEntity");
  }

  @override
  List<Object?> get props => [
        advice,
        id,
      ];
}
