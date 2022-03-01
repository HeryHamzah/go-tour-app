part of '../pages.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PanelController panelController = PanelController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      body: SlidingUpPanel(
        color: backColor,
        controller: panelController,
        minHeight: MediaQuery.of(context).size.height / 2,
        maxHeight: MediaQuery.of(context).size.height * 0.8,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        panelBuilder: (scrollController) {
          return ListView(
            padding: EdgeInsets.zero,
            controller: scrollController,
            children: [
              SizedBox(
                height: 10,
              ),
              Center(
                child: GestureDetector(
                  onTap: () => panelController.isPanelOpen
                      ? panelController.close()
                      : panelController.open(),
                  child: Container(
                    width: 30,
                    height: 5,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey[400]),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: defaultMargin),
                child: Text(
                  "EXPLORE",
                  style: themeFont.copyWith(fontSize: 18),
                ),
              ),
              FutureBuilder(
                  future: GeneralServices.getLocations(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Location> locations = snapshot.data;
                      return Container(
                        height: 150,
                        margin: EdgeInsets.only(
                            left: defaultMargin,
                            right: defaultMargin,
                            bottom: 20,
                            top: 10),
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: locations.length,
                            itemBuilder: (context, index) => Padding(
                                  padding: EdgeInsets.only(
                                      right: (index == locations.length - 1)
                                          ? 0
                                          : 16),
                                  child: GestureDetector(
                                      onTap: () => Get.toNamed('/destinations',
                                          arguments: locations[index]),
                                      child: LocationCard(locations[index])),
                                )),
                      );
                    } else {
                      return SpinKitFadingCircle(color: mainColor, size: 50);
                    }
                  }),
              Padding(
                padding: const EdgeInsets.only(bottom: 10, left: defaultMargin),
                child: Text(
                  "Destinasi Favorit",
                  style: themeFont.copyWith(fontSize: 18),
                ),
              ),
              FutureBuilder(
                  future: GeneralServices.getDestinations(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Destination> destinations = snapshot.data;
                      return Container(
                          // height: 500,
                          // color: Colors.amber,
                          child: Column(
                        children: destinations
                            .map((e) => Padding(
                                  padding: EdgeInsets.only(
                                      top: e == destinations.first ? 0 : 20,
                                      left: defaultMargin,
                                      right: defaultMargin),
                                  child: GestureDetector(
                                      onTap: () => Get.toNamed(
                                          '/destinationDetail',
                                          arguments: e),
                                      child: BestDestinationCard(e)),
                                ))
                            .take(3)
                            .toList(),
                      ));
                    } else {
                      return SpinKitFadingCircle(color: mainColor, size: 50);
                    }
                  }),
              SizedBox(
                height: 100,
              )
            ],
          );
        },
        body: Stack(
          children: [
            //background home page
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/home.jpg"), fit: BoxFit.cover)),
            ),

            //content
            ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                      defaultMargin, 20, defaultMargin, 0),
                  child: Row(
                    children: [
                      GestureDetector(
                          onTap: () => ZoomDrawer.of(context).open(),
                          child: Icon(MaterialCommunityIcons.menu,
                              color: Colors.white, size: 30)),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: GestureDetector(
                            onTap: () {
                              showSearch(
                                  context: context,
                                  delegate: SearchDestination());
                            },
                            child: Container(
                              height: 45,
                              child: AbsorbPointer(
                                child: TextField(
                                  decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none),
                                      prefixIcon: Icon(Icons.search),
                                      hintText: "Destinasi",
                                      hintStyle: themeFont.copyWith(
                                          color: Colors.grey,
                                          letterSpacing: 1.5),
                                      filled: true,
                                      fillColor: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // FutureBuilder(builder: builder)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
