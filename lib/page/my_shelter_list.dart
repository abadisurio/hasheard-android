import 'package:flutter/material.dart';
import 'package:hasheard/widget/shelter_item_detailed.dart';

class MyShelterList extends StatefulWidget {
  const MyShelterList({Key? key}) : super(key: key);

  @override
  State<MyShelterList> createState() => _MyShelterListState();
}

class _MyShelterListState extends State<MyShelterList> {
  Widget floatingActionButton() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 80.0),
      child: FloatingActionButton.extended(
        onPressed: () {
          // Add your onPressed code here!
        },
        label: Row(children: [Icon(Icons.add), Text("Add New Shelter")]),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: floatingActionButton(),
      body: ListView.builder(
        padding: const EdgeInsets.only(
            left: 16.0, right: 16.0, bottom: 88.0, top: 18.0),
        itemCount: 10,
        itemBuilder: (context, index) => const Padding(
          padding: EdgeInsets.only(bottom: 8.0),
          child: ShelterItemDetailed(),
        ),
      ),
    );
  }
}
