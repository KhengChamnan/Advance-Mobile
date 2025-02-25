import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/theme/theme.dart';
import 'package:week_3_blabla_project/widgets/actions/bla_button.dart';

class ButtonTestScreen extends StatelessWidget {
  const ButtonTestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Button Test Screen'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // testing button widget
              BlaButton(
                text: 'Search',
                onPress: () {},
                buttonType: ButtonType.primary,
              ),
              const SizedBox(height: 16),
              BlaButton(
                text: 'Search Secondary',
                onPress: () {},
                buttonType: ButtonType.secondary,
              ),
              const SizedBox(height: 16),
              BlaButton(
                text: 'Primary with Icon',
                onPress: () {},
                buttonType: ButtonType.primary,
                hasIcon: true,
                icon: Icon(Icons.send),
              ),
              const SizedBox(height: 16),
              BlaButton(
                text: 'Contact Volodia',
                onPress: () {},
                buttonType: ButtonType.secondary,
                hasIcon: true,
                icon: Icon(Icons.chat_bubble_rounded),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
