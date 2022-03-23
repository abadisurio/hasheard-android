import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light, // For Android (dark icons)
    ));

    return Scaffold(
      backgroundColor: Colors.red.shade700,
      body: Center(
        child: Text(
          "Flint",
          style:
              Theme.of(context).textTheme.headline1?.apply(color: Colors.white),
        ),
      ),
    );
  }
}
