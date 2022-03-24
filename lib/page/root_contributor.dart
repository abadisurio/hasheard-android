import 'package:flutter/material.dart';
import 'package:hasheard/widget/maps.dart';

class RootContributor extends StatefulWidget {
  const RootContributor({Key? key}) : super(key: key);

  @override
  State<RootContributor> createState() => _RootContributorState();
}

class _RootContributorState extends State<RootContributor> {
  int pageIndex = 0;
  List<IconData> bottomIcons = [Icons.map_sharp, Icons.person];

  @override
  Widget build(BuildContext context) {
    List bottomItems = [
      pageIndex == 0
          ? "assets/images/explore_active_icon.svg"
          : "assets/images/explore_icon.svg",
      pageIndex == 1
          ? "assets/images/likes_active_icon.svg"
          : "assets/images/likes_icon.svg"
    ];
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
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 5,
              shadowColor: Colors.black.withOpacity(0.5),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(bottomItems.length, (index) {
                    return IconButton(
                        onPressed: () {
                          setState(() {
                            pageIndex = index;
                          });
                        },
                        icon: Icon(bottomIcons[index]));
                  }),
                ),
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

  Widget pageOne() {
    return const MapsWidget();
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
          child: Center(child: Text("Contributor")),
        )
      ],
      title: Text("HasHeard", style: Theme.of(context).textTheme.headline4),
      centerTitle: true,
    );
  }
}
