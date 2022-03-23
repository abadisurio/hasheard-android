import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _validateUsername = false;
  bool _validatePassword = false;

  void registerUser() async {
    bool isDataFilled = await validateInput();
    if (isDataFilled) {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => const AlertDialog(
              title: Center(child: CircularProgressIndicator.adaptive())));
      String url = 'https://flint-be.herokuapp.com/api/signin';
      Map<String, String> body = {
        'username': usernameController.text,
        'password': passwordController.text,
      };
      var client = http.Client();
      try {
        final response = await client.post(Uri.parse(url), body: body);
        final bodyResponse = jsonDecode(response.body);
        if (bodyResponse["status"] == "success") {
          final prefs = await SharedPreferences.getInstance();
          final token = bodyResponse["data"]["token"];
          prefs.setString('authToken', token);
          Navigator.of(context).popUntil((route) => route.isFirst);
          Navigator.popAndPushNamed(context, '/root');
        } else {
          Navigator.of(context).pop();
          final snackBar = SnackBar(
            content: Text(bodyResponse["message"]),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      } catch (err) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Cannot connect to server\n" + err.toString()),
        ));
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
                'Sign In',
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
                child: const Text('Sign In'),
                onPressed: () {
                  registerUser();
                },
              )),
          Row(
            children: <Widget>[
              const Text('Don\'t have an account?'),
              TextButton(
                child: const Text(
                  'Register',
                ),
                onPressed: () {
                  //signup screen
                  Navigator.popAndPushNamed(context, '/register');
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
