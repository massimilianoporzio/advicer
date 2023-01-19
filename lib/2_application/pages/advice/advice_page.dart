import 'package:advicer/2_application/core/services/theme_service.dart';
import 'package:advicer/2_application/pages/advice/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdvicePage extends StatelessWidget {
  const AdvicePage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Advicer',
          style: themeData.textTheme.headline1,
        ),
        centerTitle: true,
        actions: [
          Switch(
            //*value lo ascolto! listen: true è default
            value: Provider.of<ThemeService>(context).isDarkModeOn,
            onChanged: (value) =>
                Provider.of<ThemeService>(context, listen: false).toggleTheme(),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: Center(
              child: CircularProgressIndicator(
                color: themeData.colorScheme.secondary,
              ),
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
