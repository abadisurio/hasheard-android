import 'dart:developer';

import 'package:flutter/material.dart';

class ShelterListItem extends StatelessWidget {
  const ShelterListItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
        onPressed: () {
          log("Pressed");
        },
        icon: const Icon(Icons.night_shelter_rounded),
        label: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text("Denver Shelter"),
            Text("3KM"),
          ],
        ));
  }
}
