import 'package:flutter/material.dart';
import 'package:hasheard/widget/maps.dart';
import 'package:hasheard/widget/shelter_list.dart';

class RootVictim extends StatefulWidget {
  const RootVictim({Key? key}) : super(key: key);

  @override
  State<RootVictim> createState() => _RootVictimState();
}

class _RootVictimState extends State<RootVictim> {
  int pageIndex = 0;
  List<IconData> bottomIcons = [Icons.map_sharp, Icons.sensors, Icons.person];
  final List<bool> isSelected = [true, false, false];

  Widget pageOne() {
    return SizedBox(
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          const MapsWidget(),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 88.0),
            child: SizedBox(
              width: double.infinity,
              height: 250,
              child: Card(
                child: ClipRRect(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24.0, vertical: 16.0),
                        child: Text(
                          "Shelter Near You",
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ),
                      Flexible(child: ShelterList()),
                    ],
                  ),
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(6.0)),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      body: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          getBody(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: ToggleButtons(
                textStyle: Theme.of(context).textTheme.headline6,
                borderRadius: BorderRadius.circular(16),
                fillColor: Colors.red,
                selectedColor: Colors.white,
                children: List.generate(
                    bottomIcons.length,
                    (index) => (Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 24),
                        child: Icon(
                          bottomIcons[index],
                          size: 35,
                        )))),
                onPressed: (int index) {
                  pageIndex = index;
                  setState(() {
                    for (int buttonIndex = 0;
                        buttonIndex < isSelected.length;
                        buttonIndex++) {
                      if (buttonIndex == index) {
                        isSelected[buttonIndex] = true;
                      } else {
                        isSelected[buttonIndex] = false;
                      }
                    }
                  });
                },
                isSelected: isSelected,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getBody() {
    return IndexedStack(
      index: pageIndex,
      children: [pageOne(), const Text("2")],
    );
  }

  PreferredSizeWidget? getAppBar() {
    return AppBar(
      elevation: 0,
      actions: const [
        Padding(
          padding: EdgeInsets.all(14.0),
          child: Center(child: Text("Victim")),
        )
      ],
      title: Text("HasHeard", style: Theme.of(context).textTheme.headline4),
      centerTitle: true,
    );
  }
}
