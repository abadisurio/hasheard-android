import 'package:flutter/material.dart';

class RootContributor extends StatefulWidget {
  const RootContributor({Key? key}) : super(key: key);

  @override
  State<RootContributor> createState() => _RootContributorState();
}

class _RootContributorState extends State<RootContributor> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Contributor")),
    );
  }
}
