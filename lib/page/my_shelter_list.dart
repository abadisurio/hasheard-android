import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hasheard/model/shelter.dart';
import 'package:hasheard/widget/shelter_item_detailed.dart';

class MyShelterList extends StatefulWidget {
  const MyShelterList({Key? key}) : super(key: key);

  @override
  State<MyShelterList> createState() => _MyShelterListState();
}

class _MyShelterListState extends State<MyShelterList> {
  CollectionReference shelterRef =
      FirebaseFirestore.instance.collection('shelter');

  Widget floatingActionButton() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 80.0),
      child: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, '/shelter_new');
        },
        label: Row(children: const [Icon(Icons.add), Text("Add New Shelter")]),
        backgroundColor: Colors.green,
      ),
    );
  }

  Widget getBody() {
    return FutureBuilder<QuerySnapshot>(
        future: shelterRef.get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          log(snapshot.data.toString());

          if (snapshot.hasError) {
            return Text("Something went wrong");
          }

          if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
            log(snapshot.data!.toString());
            return Text("Document does not exist");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            final allData =
                snapshot.data!.docs.map((doc) => doc.data()).toList();
            log(allData.length.toString());
            // Map<String, dynamic> data =
            //     snapshot.data!.data() as Map<String, dynamic>;
            // return Text("Full Name: ${data['full_name']} ${data['last_name']}");
            return ListView.builder(
                padding: const EdgeInsets.only(
                    left: 16.0, right: 16.0, bottom: 120.0, top: 18.0),
                itemCount: allData.length,
                itemBuilder: (context, index) {
                  final item = allData[index];
                  Map<String, dynamic>.from(item as Map);
                  String name = item['name'] ?? "";
                  String note = item['note'] ?? "";
                  double lat = (item['lat'] ?? 0) + .0;
                  bool bathroom = item['bathroom'];

                  // Shelter item = shelter[index] ;
                  // String name = allData[index]['name'];
                  // String lat = allData[index]['lat'];

                  return Text(lat.toString() + name + note);
                  return Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: ShelterItemDetailed(),
                  );
                });
          }
          return const CircularProgressIndicator.adaptive();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: floatingActionButton(),
      // body: ListView.builder(
      //   padding: const EdgeInsets.only(
      //       left: 16.0, right: 16.0, bottom: 88.0, top: 18.0),
      //   itemCount: 10,
      //   itemBuilder: (context, index) => const Padding(
      //     padding: EdgeInsets.only(bottom: 8.0),
      //     child: ShelterItemDetailed(),
      //   ),
      // ),
      body: getBody(),
    );
  }
}
