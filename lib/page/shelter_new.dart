import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hasheard/widget/maps.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:place_picker/place_picker.dart';

class ShelterNew extends StatefulWidget {
  const ShelterNew({Key? key}) : super(key: key);

  @override
  State<ShelterNew> createState() => _ShelterNewState();
}

class _ShelterNewState extends State<ShelterNew> {
  File? image;
  bool bathroom = false;
  List<bool> facility = [false, false];
  double? lat;
  double? lng;
  String? picId;
  String? phone;
  bool isLoading = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  CollectionReference shelterRef =
      FirebaseFirestore.instance.collection('shelter');

  void showMessage(String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Alert"),
            content: Text(message),
            actions: [
              TextButton(
                child: const Text("Ok"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  Future<void> _addShelter() {
    setState(() {
      isLoading = !isLoading;
    });
    context.loaderOverlay.show();
    // Call the user's CollectionReference to add a new user
    return shelterRef.add({
      'picId': picId,
      'name': _nameController.text,
      'phone': _phoneController.text,
      'note': _noteController.text,
      'count_injury': 0,
      'count_sick': 0,
      'count_refugee': 0,
      'lat': lat,
      'lng': lng,
      'created': DateTime.now().millisecondsSinceEpoch,
      'bathroom': facility[0],
      'bed': facility[1],
      'food': false
    }).then((value) {
      log("Shelter Added");
      Navigator.pop(context);
      showMessage("Shelter Added!");
      context.loaderOverlay.hide();
    }).catchError((error) {
      log("Failed to add shelter: $error");
      showMessage("Failed to add shelter: $error");
    });
  }

  void _pickImage() async {
    // final ImagePicker _picker = ImagePicker();
    // Pick an image
    // final XFile? imagePicked =
    //     await _picker.pickImage(source: ImageSource.gallery);
  }

  void _pickMap() async {
    // LocationResult? result = await Navigator.of(context).push(MaterialPageRoute(
    //     builder: (context) =>
    //         PlacePicker("AIzaSyCL1ZRaeWhbn0TARrrpsqziBlKiqdik_o4")));

    // Handle the result in your way

    LocationResult result = LocationResult();
    result.latLng = const LatLng(-6.2317537, 106.9454109);
    log("result" + result.toString());

    if (result.latLng != null) {
      setState(() {
        lat = result.latLng!.latitude;
        lng = result.latLng!.longitude;
      });
    }
  }

  void _captureImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? photoPicked =
        await _picker.pickImage(source: ImageSource.camera);
    if (photoPicked != null) {
      setState(() {
        image = File(photoPicked.path);
      });
    }
  }

  Widget getBody() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      children: [
        Container(
          color: const Color(0x11111111),
          height: 200,
          width: double.infinity,
          child: image == null
              ? const Center(child: Text("Pick image below"))
              : Image.file(
                  image!,
                  fit: BoxFit.cover,
                ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              OutlinedButton.icon(
                  onPressed: _pickImage,
                  icon: const Icon(Icons.add),
                  label: const Text("Add photo")),
              const Text("or"),
              OutlinedButton.icon(
                  onPressed: _captureImage,
                  icon: const Icon(Icons.camera_alt_rounded),
                  label: const Text("Open camera")),
            ],
          ),
        ),
        Text(
          "Location",
          style: Theme.of(context).textTheme.headline4,
        ),
        Container(
          color: const Color(0x11111111),
          height: 200,
          width: double.infinity,
          child: lat == null
              ? const Center(child: Text("Pick location below"))
              : const MapsWidget(),
        ),
        Text(lat.toString() + ", " + lng.toString()),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              OutlinedButton.icon(
                  onPressed: _pickMap,
                  icon: const Icon(Icons.pin_drop),
                  label: const Text("Select from maps")),
            ],
          ),
        ),
        Text(
          "Information",
          style: Theme.of(context).textTheme.headline4,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Shelter Name',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: TextField(
            controller: _addressController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Address',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: TextField(
            controller: _noteController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Additional Note',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: TextField(
            controller: _phoneController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Phone',
            ),
          ),
        ),
        Text(
          "Facility",
          style: Theme.of(context).textTheme.headline4,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: ToggleButtons(
            direction: Axis.vertical,
            children: <Widget>[
              ListTile(
                  leading: const Icon(Icons.wc),
                  title: const Text("Bathroom"),
                  subtitle: facility[0] ? const Text("Available") : null,
                  trailing: Icon(facility[0]
                      ? Icons.check_box
                      : Icons.check_box_outline_blank)),
              ListTile(
                  leading: const Icon(Icons.bed_rounded),
                  title: const Text("Bed"),
                  subtitle: facility[1] ? const Text("Available") : null,
                  trailing: Icon(facility[1]
                      ? Icons.check_box
                      : Icons.check_box_outline_blank)),
            ],
            onPressed: (int index) {
              setState(() {
                facility[index] = !facility[index];
              });
            },
            isSelected: facility,
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Add New Shelter"),
        ),
        body: getBody(),
        persistentFooterButtons: [
          ElevatedButton.icon(
              label: const Text("Save Shelter"),
              onPressed: _addShelter,
              icon: const Icon(Icons.save))
        ],
      ),
    );
  }
}
