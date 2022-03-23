import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Introduction extends StatefulWidget {
  const Introduction({Key? key}) : super(key: key);

  @override
  _IntroductionState createState() => _IntroductionState();
}

class _IntroductionState extends State<Introduction> {
  final PageController _pageController = PageController(initialPage: 0);
  int currentPage = 0;

  late String user = "Loading";
  late int salary = 0;
  late int payDay = 0;

  final userNameController = TextEditingController();
  final salaryController = TextEditingController();
  final payDayController = TextEditingController();

  void finishIntro() async {
    bool isComplete = await saveData();
    if (isComplete) Navigator.pushReplacementNamed(context, '/root-victim');
  }

  Future<bool> saveData() async {
    // getData();
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // var cron = new Cron();
    // cron.schedule(new Schedule.parse('0 0 $payDay * *'), () async {
    //   int newBalance = 0 + salary;
    //   prefs.setInt('mainBalance', newBalance);
    // });
    // prefs.setBool('firstTimeOpen', false);
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

  @override
  Widget build(BuildContext context) {
    final List<Widget> introWidgetsList = <Widget>[
      const PageOne(),
      InputUsername(controller: userNameController),
      InputSalary(controller: salaryController),
      InputPayDay(controller: payDayController),
      PageFive(onFinish: finishIntro)
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
                        MaterialStateProperty.all<Color>(Colors.green),
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

class PageOne extends StatelessWidget {
  const PageOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        // Image.asset('assets/image/page_one.png', height: 250),
        Text(
          "Start now!",
          style: Theme.of(context).textTheme.headline1,
          textAlign: TextAlign.center,
        ),
        Text(
          "Take the tour",
          style: Theme.of(context).textTheme.headline6,
          textAlign: TextAlign.center,
        ),
      ]),
    );
  }
}

class InputUsername extends StatefulWidget {
  const InputUsername({Key? key, this.controller}) : super(key: key);

  final TextEditingController? controller;

  @override
  _InputUsernameState createState() => _InputUsernameState();
}

class _InputUsernameState extends State<InputUsername> {
  TextEditingController? controller;

  @override
  void initState() {
    controller = widget.controller;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Spacer(
              flex: 1,
            ),
            Expanded(
              flex: 1,
              child: Column(children: [
                Text(
                  "How do you like to be called?",
                  style: Theme.of(context).textTheme.headline3,
                  textAlign: TextAlign.center,
                ),
                // Add TextFormFields and ElevatedButton here.
                TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Username',
                    // errorText:
                    //     _validateUsername ? 'Username Can\'t Be Empty' : null,
                  ),
                ),
                // DuidTextField(
                //     controller: controller,
                //     hintText: "Ross Geller",
                //     icon: Icons.person,
                //     textInputType: TextInputType.text),
              ]),
            ),
            Expanded(
                flex: 1,
                child: Align(
                    child: Text("Next\n\n\n\n\n\n ",
                        style: Theme.of(context).textTheme.headline6,
                        textAlign: TextAlign.center),
                    alignment: Alignment.bottomCenter)),
          ],
        ),
      ),
    );
  }
}

class InputSalary extends StatefulWidget {
  const InputSalary({Key? key, this.controller}) : super(key: key);

  final TextEditingController? controller;
  @override
  State<InputSalary> createState() => _PageThreeState();
}

class _PageThreeState extends State<InputSalary> {
  TextEditingController? controller;

  @override
  void initState() {
    controller = widget.controller;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Spacer(
              flex: 1,
            ),
            Expanded(
              flex: 1,
              child: Column(children: [
                Text(
                  "How much is\nyour salary?",
                  style: Theme.of(context).textTheme.headline3,
                  textAlign: TextAlign.center,
                ),
                TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Username',
                    // errorText:
                    //     _validateUsername ? 'Username Can\'t Be Empty' : null,
                  ),
                ),
                // DuidTextField(
                //     controller: controller,
                //     prefix: "Rp",
                //     hintText: "5000",
                //     icon: Icons.money,
                //     textInputType: TextInputType.number),
              ]),
            ),
            Expanded(
                flex: 1,
                child: Align(
                    child: Text("Next\n\n\n\n\n\n ",
                        style: Theme.of(context).textTheme.headline6,
                        textAlign: TextAlign.center),
                    alignment: Alignment.bottomCenter)),
          ],
        ),
      ),
    );
  }
}

class InputPayDay extends StatefulWidget {
  const InputPayDay({Key? key, this.controller}) : super(key: key);
  final TextEditingController? controller;
  @override
  InputPayDayState createState() => InputPayDayState();
}

class InputPayDayState extends State<InputPayDay> {
  TextEditingController? controller;
  @override
  void initState() {
    controller = widget.controller;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "When is your\npay day?",
                    style: Theme.of(context).textTheme.headline3,
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    elevation: 00,
                    shadowColor: const Color(0xFFE9E9E9),
                    color: const Color(0xFFF8F8F8),
                    // child: ListView(
                    //   children: [
                    //     DuidDatePicker(
                    //       controller: controller,
                    //       dateChosen: 1,
                    //     )
                    //   ],
                    // ),
                  ),
                )
              ]),
            ),
            Expanded(
                flex: 1,
                child: Align(
                    child: Text("Next\n\n\n\n\n\n ",
                        style: Theme.of(context).textTheme.headline6,
                        textAlign: TextAlign.center),
                    alignment: Alignment.bottomCenter)),
          ],
        ),
      ),
    );
  }
}

class PageFive extends StatefulWidget {
  const PageFive({Key? key, this.onFinish}) : super(key: key);
  final Function()? onFinish;
  @override
  _PageFiveState createState() => _PageFiveState();
}

class _PageFiveState extends State<PageFive> {
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(
        "You are all set",
        style: Theme.of(context).textTheme.headline1,
      ),
      const SizedBox(height: 50),
      ElevatedButton(
        onPressed: widget.onFinish,
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "see my wallet",
            style: TextStyle(fontSize: 30),
          ),
        ),
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.0))),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
        ),
      )
    ]);
  }
}
