import 'dart:convert';
import 'dart:developer' as dev;
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _validateUsername = false;
  bool _validatePassword = false;

  void registerUser() async {
    // void getFilteredMovie() async {

    bool isDataFilled = await validateInput();
    if (isDataFilled) {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => const AlertDialog(
              title: Center(child: CircularProgressIndicator.adaptive())));

      String url = 'https://flint-be.herokuapp.com/api/register';
      Map<String, String> body = {
        'username': usernameController.text,
        'password': passwordController.text,
      };
      var client = http.Client();
      dev.log("test");
      try {
        final response = await client.post(Uri.parse(url), body: body);
        final bodyResponse = jsonDecode(response.body);
        dev.log(bodyResponse["status"].toString());
        if (bodyResponse["data"]) {
          dev.log(bodyResponse["status"].toString());
          Navigator.popAndPushNamed(context, '/signin');
        } else {
          Navigator.of(context).pop();
          final snackBar = SnackBar(
            content: Text(bodyResponse["message"]),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }

        // return MovieWithDetail.fromJson(jsonDecode(response.body));
      } finally {
        client.close();
      }
    }
  }

  Future<bool> validateInput() async {
    setState(() {
      usernameController.text.isEmpty
          ? _validateUsername = true
          : _validateUsername = false;
      passwordController.text.isEmpty
          ? _validatePassword = true
          : _validatePassword = false;
    });
    if (usernameController.text.isNotEmpty &&
        passwordController.text.isNotEmpty) return true;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 70),
              child:
                  Text('Flint', style: Theme.of(context).textTheme.headline1)),
          Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: Text(
                'Register',
                style: Theme.of(context).textTheme.headline3,
              )),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: usernameController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Username',
                errorText:
                    _validateUsername ? 'Username Can\'t Be Empty' : null,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextField(
              obscureText: true,
              controller: passwordController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Password',
                errorText:
                    _validatePassword ? 'Password Can\'t Be Empty' : null,
              ),
            ),
          ),
          Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ElevatedButton(
                child: const Text('Register'),
                onPressed: () {
                  // log(usernameController.text);
                  // log(passwordController.text);
                  registerUser();
                },
              )),
          Row(
            children: <Widget>[
              const Text('Already have an account?'),
              TextButton(
                child: const Text(
                  'Sign in',
                ),
                onPressed: () {
                  //signup screen
                  Navigator.popAndPushNamed(context, '/signin');
                },
              )
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ],
      ),
    );
  }
}
