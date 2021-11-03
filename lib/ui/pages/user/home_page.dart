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
      body: SlidingUpPanel(
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
                padding: const EdgeInsets.only(bottom: 10, left: defaultMargin),
                child: Text(
                  "EXPLORE",
                  style: themeFont.copyWith(fontSize: 16),
                ),
              ),
              FutureBuilder(
                  future: GeneralServices.getLocations(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Location> location = snapshot.data;
                      return Container(
                        height: 150,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: location.length,
                            itemBuilder: (context, index) => Padding(
                                  padding: EdgeInsets.only(
                                      left: (index == 0) ? defaultMargin : 0,
                                      right: (index == location.length - 1)
                                          ? defaultMargin
                                          : 16),
                                  child: GestureDetector(
                                      onTap: () => Get.toNamed('/destinations',
                                          arguments: location[index]),
                                      child: LocationCard(location[index])),
                                )),
                      );
                    } else {
                      return SpinKitFadingCircle(color: mainColor, size: 50);
                    }
                  }),
              Padding(
                padding: const EdgeInsets.only(
                    top: 20, bottom: 10, left: defaultMargin),
                child: Text(
                  "Best Destinations",
                  style: themeFont.copyWith(fontSize: 16),
                ),
              ),
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
                          child: Container(
                            height: 45,
                            child: TextField(
                              decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide.none),
                                  prefixIcon: Icon(Icons.search),
                                  hintText: "City, places etc.",
                                  hintStyle: themeFont.copyWith(
                                      color: Colors.grey, letterSpacing: 1.5),
                                  filled: true,
                                  fillColor: Colors.white),
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
