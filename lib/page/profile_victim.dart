import 'package:flutter/material.dart';

class ProfileVictim extends StatefulWidget {
  const ProfileVictim({Key? key}) : super(key: key);

  @override
  State<ProfileVictim> createState() => _ProfileVictimState();
}

class _ProfileVictimState extends State<ProfileVictim> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();

  @override
  void initState() {
    _nameController.text = "Maria Levi";
    _ageController.text = "40";
    _genderController.text = "Male";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String imageURL =
        'https://images.pexels.com/photos/6322920/pexels-photo-6322920.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=180';
    return ListView(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(imageURL),
          radius: 100,
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Name',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
            controller: _ageController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Age',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
            controller: _genderController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Gender',
            ),
          ),
        ),
      ],
    );
  }
}
