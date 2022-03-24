import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hasheard/page/introduction.dart';
import 'package:hasheard/page/root_contributor.dart';
import 'package:hasheard/page/root_pic.dart';
import 'package:hasheard/page/root_victim.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  bool? isFirstTime;
  int? roleIndex;

  Future<bool> checkFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isFirstTime = prefs.getBool('firstTimeOpen') ?? true;
    roleIndex = prefs.getInt('role') ?? 0;
    return true;
  }

  Widget rootPage() {
    return roleIndex == 0
        ? const RootVictim()
        : roleIndex == 1
            ? const RootPIC()
            : const RootContributor();
  }

  @override
  Widget build(BuildContext context) {
    // return const Introduction();
    return FutureBuilder(
        future: checkFirstTime(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          log(snapshot.data.toString());
          if (snapshot.hasData && isFirstTime != null) {
            // return true ? const Introduction() : rootPage();
            return isFirstTime! ? const Introduction() : rootPage();
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}
