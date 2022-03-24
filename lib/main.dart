import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hasheard/connectivity/connection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hasheard/page/register.dart';
import 'package:hasheard/page/root.dart';
import 'package:hasheard/page/shelter_detail.dart';
import 'package:hasheard/page/signin.dart';
import 'package:hasheard/page/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flint',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      // darkTheme: ThemeData(
      //     brightness: Brightness.dark,
      //     bottomSheetTheme:
      //         const BottomSheetThemeData(backgroundColor: Colors.transparent),
      //     fontFamily: 'IBMPlexSans',
      //     elevatedButtonTheme: ElevatedButtonThemeData(
      //       style: ButtonStyle(
      //         backgroundColor:
      //             MaterialStateProperty.all(const Color(0xffE2412D)),
      //       ),
      //     ),
      //     textTheme: const TextTheme(
      //         headline1: TextStyle(
      //           fontWeight: FontWeight.w700,
      //           fontSize: 40,
      //         ),
      //         headline2: TextStyle(
      //           fontWeight: FontWeight.w700,
      //           fontSize: 35,
      //         ),
      //         headline3: TextStyle(
      //           fontWeight: FontWeight.w700,
      //           fontSize: 30,
      //         ),
      //         headline4: TextStyle(
      //           fontWeight: FontWeight.w700,
      //           fontSize: 20,
      //         ),
      //         headline5: TextStyle(
      //           fontWeight: FontWeight.w600,
      //           fontSize: 20,
      //         ),
      //         headline6: TextStyle(
      //           fontWeight: FontWeight.w700,
      //           fontSize: 15,
      //         ),
      //         bodyText1: TextStyle(
      //             fontWeight: FontWeight.w600, color: Color(0xff272727)),
      //         button: TextStyle(fontWeight: FontWeight.w700))),
      theme: ThemeData(
        fontFamily: 'IBMPlexSans',
        primarySwatch: Colors.red,
        primaryColor: const Color(0xffE2412D),
        appBarTheme: AppBarTheme(
            backgroundColor: const Color(0xffffffff),
            foregroundColor: Colors.grey.shade900),
        bottomSheetTheme:
            const BottomSheetThemeData(backgroundColor: Colors.transparent),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(const Color(0xffE2412D)),
          ),
        ),
        textTheme: const TextTheme(
            headline1: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 40,
                color: Color(0xff272727)),
            headline2: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 35,
                color: Color(0xff868686)),
            headline3: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 30,
            ),
            headline4: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20,
                color: Color(0xFF000000)),
            headline5: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
            headline6: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 15,
            ),
            bodyText1: TextStyle(
                fontWeight: FontWeight.w600, color: Color(0xff272727)),
            button: TextStyle(fontWeight: FontWeight.w700)),
      ),
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/':
            return CupertinoPageRoute(
                builder: (_) => const RootPage(), settings: settings);
          case '/signin':
            return CupertinoPageRoute(
                builder: (_) => const SignInPage(), settings: settings);
          case '/register':
            return CupertinoPageRoute(
                builder: (_) => const RegisterPage(), settings: settings);
          case '/root':
            return CupertinoPageRoute(
                builder: (_) => const RootPage(), settings: settings);
          case '/shelter_detail':
            return CupertinoPageRoute(
                builder: (_) => const ShelterDetail(), settings: settings);
        }
        return null;
      },
      home: const Index(),
    );
  }
}

class Index extends StatefulWidget {
  const Index({Key? key}) : super(key: key);

  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {
  final Connection _connectivity = Connection.instance;

  Widget? main2;
  String? _token;
  String? _userUID;
  bool _internetAlertShown = false;

  @override
  void initState() {
    super.initState();

    getToken();
    _connectivity.initialise();
    _connectivity.myStream.listen((source) {
      ConnectivityResult result = source.keys.toList()[0];
      if (result == ConnectivityResult.none) {
        Future.delayed(Duration.zero, () async {
          internetAlert(context);
          setState(() {
            _internetAlertShown = true;
          });
        });
      } else {
        if (_internetAlertShown) {
          Navigator.pop(context, result);
          setState(() {
            _internetAlertShown = false;
          });
        }
      }
    });

    Future.delayed(const Duration(seconds: 1), () {
      if (!_internetAlertShown) {
        if (_token == null && _userUID == null) {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: const Text("Cannot open Flint"),
                    content: const Text("Try again later"),
                    actions: [
                      TextButton(
                        onPressed: () => SystemChannels.platform
                            .invokeMethod('SystemNavigator.pop'),
                        child: const Text('Tutup'),
                      ),
                    ],
                  ));
        } else {
          setState(() {
            // log(_userUID.toString());
            main2 = (_token == 'nothing' && _userUID == 'nothing')
                ? const SignInPage()
                : const RootPage();
          });
        }
      }
    });
  }

  void getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('authToken') ?? 'nothing';
    String? userUID = prefs.getString('userUID') ?? 'nothing';
    setState(() {
      _token = token;
      _userUID = userUID;
    });
  }

  void internetAlert(BuildContext context) {
    var alert = AlertDialog(
      title: const Text('Aplikasi tidak terhubung dengan internet'),
      content: const Text('Tutup aplikasi atau coba lagi'),
      actions: <Widget>[
        TextButton(
          onPressed: () =>
              SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
          child: const Text('Tutup'),
        ),
      ],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }

  @override
  Widget build(BuildContext context) {
    return main2 ?? const SplashPage();
  }

  @override
  void dispose() {
    _connectivity.disposeStream();
    super.dispose();
  }
}
