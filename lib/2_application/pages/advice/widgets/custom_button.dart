import 'package:advicer/2_application/pages/advice/bloc/advicer_bloc.dart';
import 'package:advicer/2_application/pages/advice/cubit/advicer_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomButton extends StatelessWidget {
  final String text;
  const CustomButton({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return InkResponse(
      onTap: () {
        // BlocProvider.of<AdvicerBloc>(context).add(AdviceRequestedEvent());
        //*al posto di emettere evento chiamo il metodo della busines logic del
        //* cubit
        BlocProvider.of<AdvicerCubit>(context).adviceRequested();
      },
      child: Material(
        elevation: 20,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          decoration: BoxDecoration(
            color: themeData.colorScheme.secondary,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 15,
            ),
            child: Text(
              'Get Advice',
              style: themeData.textTheme.headline1,
            ),
          ),
        ),
      ),
    );
  }
}
