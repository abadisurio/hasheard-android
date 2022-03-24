import 'package:flutter/material.dart';
import 'package:hasheard/widget/maps.dart';

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
    return const MapsWidget();
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
                // Padding(
                //   padding: const EdgeInsets.all(16.0),
                //   child: Column(
                //     children: [Icon(bottomIcons[0]), const Text("Maps")],
                //   ),

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
      // bottomNavigationBar: Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child:
      // ),
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
