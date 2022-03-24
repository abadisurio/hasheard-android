import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ShelterDetail extends StatefulWidget {
  const ShelterDetail({Key? key}) : super(key: key);

  @override
  State<ShelterDetail> createState() => _ShelterDetailState();
}

class _ShelterDetailState extends State<ShelterDetail> {
  @override
  Widget build(BuildContext context) {
    String imageURL =
        'https://images.pexels.com/photos/6918510/pexels-photo-6918510.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=260';
    String distance = '2.8KM Distance';
    String refugee = '71 Refugee(s)';
    String injured = '3 Injured';
    String sick = '10 Sick';
    String food = 'Sufficent';
    String bathroom = 'Avaliable';
    String name = 'Denver Shelter';
    String address =
        'Jl. Pramuka No.55, RT.006/RW.006, Marga Jaya, Kec. Bekasi Sel., Kota Bks, Jawa Barat 17141';
    String description =
        'A shelter is a basic architectural structure or building that provides protection from the local environment. Having a place of shelter, of safety and of retreat, i.e. a home, is commonly considered a fundamental physiological human need, the foundation from which to develop higher human motivations.';

    void _launchMapsUrl() async {
      final url =
          'https://www.google.com/maps/dir/-6.2244765,106.9620123/$address';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    void _launchPhone() async {
      const url = "tel:0483921674";
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Shelter Detail"),
      ),
      body: ListView(
        children: [
          Image(
            image: NetworkImage(imageURL),
            fit: BoxFit.cover,
            height: 250,
            width: double.infinity,
          ),
          Transform.translate(
            offset: const Offset(0.0, 0.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        children: [
                          Chip(
                              avatar: const Icon(Icons.location_pin),
                              label: Text(distance)),
                          Chip(
                              avatar: const Icon(Icons.emoji_people_rounded),
                              label: Text(refugee)),
                          Chip(
                              avatar: const Icon(Icons.personal_injury),
                              label: Text(injured)),
                          Chip(
                              avatar: const Icon(Icons.sick),
                              label: Text(sick)),
                          Chip(
                              avatar: const Icon(Icons.fastfood),
                              label: Text(food + " Food")),
                          Chip(
                              avatar: const Icon(Icons.wc),
                              label: Text("Bathroom " + bathroom)),
                        ],
                        direction: Axis.horizontal,
                        spacing: 6.0,
                        runSpacing: -9,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                Text(
                  address,
                  style: Theme.of(context).textTheme.headline5,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(description),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ],
      ),
      persistentFooterButtons: [
        ElevatedButton.icon(
            label: const Text("Direction"),
            onPressed: _launchMapsUrl,
            icon: const Icon(Icons.directions)),
        ElevatedButton.icon(
            label: const Text("Call for help"),
            onPressed: _launchPhone,
            icon: const Icon(Icons.security_update_warning)),
      ],
    );
  }
}
