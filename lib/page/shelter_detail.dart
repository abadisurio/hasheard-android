import 'package:flutter/material.dart';

class ShelterDetail extends StatefulWidget {
  const ShelterDetail({Key? key}) : super(key: key);

  @override
  State<ShelterDetail> createState() => _ShelterDetailState();
}

class _ShelterDetailState extends State<ShelterDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shelter Detail"),
      ),
    );
  }
}
