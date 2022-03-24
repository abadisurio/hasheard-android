import 'package:flutter/material.dart';
import 'package:slide_to_act/slide_to_act.dart';

class SOSCall extends StatefulWidget {
  const SOSCall({Key? key}) : super(key: key);

  @override
  State<SOSCall> createState() => _SOSCallState();
}

class _SOSCallState extends State<SOSCall> {
  bool emitSOS = false;

  void _submitSOS() {
    setState(() {
      emitSOS = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SlideAction(
                elevation: 0,
                sliderRotate: false,
                text: "Emergency SOS",
                sliderButtonIcon: const Icon(Icons.warning_amber_rounded),
                onSubmit: _submitSOS),
          ),
          Text(
            emitSOS ? "SOS Signal Emmited" : "Swipe to Emmit Signal",
            style: Theme.of(context).textTheme.headline4,
          )
        ],
      ),
    );
  }
}
