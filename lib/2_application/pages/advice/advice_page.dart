import 'package:advicer/2_application/core/services/theme_service.dart';
import 'package:advicer/2_application/pages/advice/bloc/advicer_bloc.dart';
import 'package:advicer/2_application/pages/advice/cubit/advicer_cubit.dart';
import 'package:advicer/2_application/pages/advice/widgets/advice_field.dart';
import 'package:advicer/2_application/pages/advice/widgets/custom_button.dart';
import 'package:advicer/2_application/pages/advice/widgets/error_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class AdvicerPageWrapperProvider extends StatelessWidget {
  const AdvicerPageWrapperProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AdvicerBloc>(
      create: (context) => AdvicerBloc(),
      child: const AdvicerPage(),
    );
  }
}

class AdvicerPageCubitWrapperProvider extends StatelessWidget {
  const AdvicerPageCubitWrapperProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AdvicerCubit>(
      create: (context) => AdvicerCubit(),
      child: const AdvicerPage(),
    );
  }
}

class AdvicerPage extends StatelessWidget {
  const AdvicerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Text(
          'Advicer',
          style: themeData.textTheme.headline1,
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8, top: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Switch(
                  //*value lo ascolto! listen: true è default
                  value: Provider.of<ThemeService>(context).isDarkModeOn,
                  onChanged: (value) =>
                      Provider.of<ThemeService>(context, listen: false)
                          .toggleTheme(),
                ),
                Text(
                  'Switch theme',
                  style: themeData.textTheme.headline2,
                ),
              ],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                //*LA UI REAGISCE AD OGNI STATE CHE ARRIVA DAL BLOC
                // child: BlocBuilder<AdvicerBloc, AdvicerState>(
                child: BlocBuilder<AdvicerCubit, AdvicerCubitState>(
                  builder: (context, state) {
                    if (state is AdvicerCubitStateError) {
                      debugPrint(
                          "Advice UI: Cubit emitted ERROR state: rebuild!");
                      return ErrorMessage(
                        message: state.message,
                      );
                    } else if (state is AdvicerCubitStateLoading) {
                      debugPrint(
                          "Advice UI: Cubit emitted LOADING state: rebuild!");
                      return CircularProgressIndicator(
                        color: themeData.colorScheme.secondary,
                      );
                    } else if (state is AdvicerCubitInitial) {
                      debugPrint(
                          "Advice UI: Cubit is in the INITIAL STATE: rebuild");
                      return Text(
                        'Your advice is loading for you blah blah',
                        style: themeData.textTheme.headline1,
                      );
                    } else if (state is AdvicerCubitStateLoaded) {
                      debugPrint(
                          "Advice UI: Cubit emitted LOADED state: rebuild!");
                      return AdviceField(
                        advice: state.advice,
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ),
            ),
            const SizedBox(
                height: 200,
                child: Center(
                  child: CustomButton(text: 'Get Advice'),
                ))
          ],
        ),
      ),
    );
  }
}
