import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hasheard/widget/maps.dart';
import 'package:image_picker/image_picker.dart';
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
  String? name;
  String? address;
  String? description;
  String? note;
  String? phone;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _additionalNoteController =
      TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

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
            controller: _additionalNoteController,
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Shelter"),
      ),
      body: getBody(),
      persistentFooterButtons: [
        ElevatedButton.icon(
            label: const Text("Save Shelter"),
            onPressed: () {},
            icon: const Icon(Icons.save))
      ],
    );
  }
}
