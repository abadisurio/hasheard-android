import 'package:flutter/material.dart';

class RootPIC extends StatefulWidget {
  const RootPIC({Key? key}) : super(key: key);

  @override
  State<RootPIC> createState() => _RootPICState();
}

class _RootPICState extends State<RootPIC> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("PIC")),
    );
  }
}
