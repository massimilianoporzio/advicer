import 'package:advicer/2_application/core/services/theme_service.dart';
import 'package:advicer/2_application/pages/advice/widgets/advice_field.dart';
import 'package:advicer/2_application/pages/advice/widgets/custom_button.dart';
import 'package:advicer/2_application/pages/advice/widgets/error_message.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdvicePage extends StatelessWidget {
  const AdvicePage({super.key});

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
              child: ErrorMessage(
                message: 'Uuups something gone wrong!',
              ),
              // AdviceField(
              //   advice: 'example advice - your day will be good',
              // ),
              // CircularProgressIndicator(
              //   color: themeData.colorScheme.secondary,
              // ),
              //  Text(
              //   'Your advice is loading for you blah blah',
              //   style: themeData.textTheme.headline1,
              // ),
            )),
            SizedBox(
                height: 200,
                child: Center(
                  child: CustomButton(
                      onTap: () => print('pressed'), text: 'Get Advice'),
                ))
          ],
        ),
      ),
    );
  }
}
