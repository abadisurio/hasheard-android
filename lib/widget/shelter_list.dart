import 'package:flutter/material.dart';
import 'package:hasheard/widget/shelter_list_item.dart';

class ShelterList extends StatefulWidget {
  const ShelterList({Key? key}) : super(key: key);

  @override
  State<ShelterList> createState() => ShelterListState();
}

class ShelterListState extends State<ShelterList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        itemCount: 20,
        itemBuilder: (context, index) {
          // return Text(index.toString());
          return const ShelterListItem();
        });
  }
}
