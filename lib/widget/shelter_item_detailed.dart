import 'package:flutter/material.dart';

class ShelterItemDetailed extends StatefulWidget {
  const ShelterItemDetailed({Key? key}) : super(key: key);

  @override
  State<ShelterItemDetailed> createState() => _ShelterItemState();
}

class _ShelterItemState extends State<ShelterItemDetailed> {
  @override
  Widget build(BuildContext context) {
    String distance = '2.8KM';
    String sick = '10';
    bool food = true;
    bool bathroom = true;
    String name = 'Denver Shelter';

    return OutlinedButton.icon(
        onPressed: () {
          Navigator.pushNamed(context, '/shelter_detail');
        },
        icon: const Icon(
          Icons.night_shelter_rounded,
          size: 50,
        ),
        label: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    Text(distance),
                  ],
                ),
                Wrap(
                  direction: Axis.horizontal,
                  spacing: 6.0,
                  runSpacing: -9,
                  children: [
                    Chip(
                        avatar: const Icon(Icons.location_pin),
                        label: Text(distance)),
                    Chip(avatar: const Icon(Icons.sick), label: Text(sick)),
                    food
                        ? const Chip(
                            avatar: Icon(Icons.fastfood), label: Text("Food"))
                        : SizedBox(),
                    bathroom
                        ? const Chip(
                            avatar: Icon(Icons.wc), label: Text("Bathroom"))
                        : SizedBox(),
                  ],
                ),
              ],
            )));
  }
}


// ListTile(
//         leading: const Icon(
//           Icons.night_shelter_rounded,
//           size: 50,
//         ),
//         title: Text(name),
//         subtitle: Wrap(
//           direction: Axis.horizontal,
//           spacing: 6.0,
//           runSpacing: -9,
//           children: [
//             Chip(label: Text("test")),
//             Chip(label: Text("test")),
//             Chip(label: Text("test")),
//             Chip(label: Text("test")),
//           ],
//         ),
//       ),
