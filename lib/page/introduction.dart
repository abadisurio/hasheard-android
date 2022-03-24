import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Introduction extends StatefulWidget {
  const Introduction({Key? key}) : super(key: key);

  @override
  _IntroductionState createState() => _IntroductionState();
}

class _IntroductionState extends State<Introduction> {
  final PageController _pageController = PageController(initialPage: 0);
  int currentPage = 0;
  final List<bool> isSelected = [true, false, false];
  late String user = "Loading";
  int role = 0;

  final userNameController = TextEditingController();
  final salaryController = TextEditingController();
  final payDayController = TextEditingController();

  void finishIntro() async {
    bool isComplete = await saveData();
    if (isComplete) Navigator.pushReplacementNamed(context, '/root-victim');
  }

  Future<bool> saveData() async {
    // getData();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // var cron = new Cron();
    // cron.schedule(new Schedule.parse('0 0 $payDay * *'), () async {
    //   int newBalance = 0 + salary;
    //   prefs.setInt('mainBalance', newBalance);
    // });
    prefs.setBool('firstTimeOpen', false);
    log(role.toString());
    prefs.setInt('role', role);
    // prefs.setString('userName', user);
    // prefs.setInt('mainSalary', salary);
    // prefs.setInt('payDay', payDay);
    return true;
  }

  void getData() {
    log('userName: ${userNameController.text}');
    log('salary: ${salaryController.text}');
    user = userNameController.text;
    // salary = int.parse(salaryController.text.replaceAll('.', ''));
    // payDay = int.parse(payDayController.text);
  }

  void getChangedPageAndMoveBar(int page) {
    setState(() {
      currentPage = page;
    });
  }

  void nextPage() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    _pageController.animateToPage(currentPage + 1,
        duration: const Duration(milliseconds: 250), curve: Curves.easeInOut);
  }

  Widget pageOne() {
    return Container(
      color: Colors.white,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        // Image.asset('assets/image/page_one.png', height: 250),
        Text(
          "Stay safe",
          style: Theme.of(context).textTheme.headline1,
          textAlign: TextAlign.center,
        ),
        Text(
          "Tell us how you are right now",
          style: Theme.of(context).textTheme.headline6,
          textAlign: TextAlign.center,
        ),
      ]),
    );
  }

  Widget pageTwo() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      color: Colors.white,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          "Welcome to HasHeard\nplease choose your role",
          style: Theme.of(context).textTheme.headline5,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        ToggleButtons(
          textStyle: Theme.of(context).textTheme.headline6,
          borderRadius: BorderRadius.circular(16),
          fillColor: Colors.red,
          selectedColor: Colors.white,
          direction: Axis.vertical,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: const [
                  Image(
                    image: AssetImage('assets/image/role_1.png'),
                    width: 150,
                  ),
                  Flexible(
                    child: Text(
                      "Are you a victim of natural disaster/ a refugee of war/ an evacuee?",
                      overflow: TextOverflow.fade,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: const [
                  Flexible(
                    child: Text(
                      "Are you a PIC of a shelter/ an authorities?",
                      overflow: TextOverflow.fade,
                      textAlign: TextAlign.end,
                    ),
                  ),
                  Image(
                    image: AssetImage('assets/image/role_2.png'),
                    width: 150,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: const [
                  Image(
                    image: AssetImage('assets/image/role_3.png'),
                    width: 150,
                  ),
                  Flexible(
                    child: Text(
                      "Are you a contributor/an aider/someone who just want to help?",
                      overflow: TextOverflow.fade,
                    ),
                  )
                ],
              ),
            ),
          ],
          onPressed: (int index) {
            role = index;
            setState(() {
              for (int buttonIndex = 0;
                  buttonIndex < isSelected.length;
                  buttonIndex++) {
                if (buttonIndex == index) {
                  isSelected[buttonIndex] = true;
                } else {
                  isSelected[buttonIndex] = false;
                }
              }
            });
          },
          isSelected: isSelected,
        ),
        const SizedBox(height: 100),
      ]),
    );
  }

  Widget pageThree() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          "You are all set",
          style: Theme.of(context).textTheme.headline3,
        ),
        const SizedBox(height: 20),
        Text(
          "Make sure that you have internet connection and location feature is turned on",
          style: Theme.of(context).textTheme.headline4,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 30),
        ElevatedButton(
          onPressed: finishIntro,
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Finish",
              style: TextStyle(fontSize: 25),
            ),
          ),
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.0))),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
          ),
        )
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> introWidgetsList = <Widget>[
      pageOne(),
      pageTwo(),
      pageThree()
    ];
    return SafeArea(
      child: Scaffold(
          floatingActionButton: (introWidgetsList.length - 1 != currentPage)
              ? ElevatedButton(
                  onPressed: () => nextPage(),
                  child: const Icon(
                    Icons.keyboard_arrow_right_rounded,
                    color: Colors.white,
                    size: 70,
                  ),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<CircleBorder>(
                        const CircleBorder()),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red),
                  ),
                )
              : null,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          body: PageView.builder(
            physics: const ClampingScrollPhysics(),
            itemCount: introWidgetsList.length,
            onPageChanged: (int page) {
              getChangedPageAndMoveBar(page);
            },
            controller: _pageController,
            itemBuilder: (context, index) {
              return introWidgetsList[index];
            },
          )),
    );
  }
}
