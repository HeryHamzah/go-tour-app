part of '../pages.dart';

class MainPage extends StatefulWidget {
  final int bottomNavBarIndex;

  MainPage({this.bottomNavBarIndex = 0});
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int bottomNavBarIndex;
  PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
    bottomNavBarIndex = widget.bottomNavBarIndex;
    pageController = PageController(initialPage: bottomNavBarIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: pageController,
            onPageChanged: (index) {
              setState(() {
                bottomNavBarIndex = index;
              });
              pageController.jumpToPage(bottomNavBarIndex);
            },
            children: [HomePage(), ActivityPage()],
          ),
          //bottom navbar
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(
                  left: defaultMargin, right: defaultMargin, bottom: 30),
              child: Container(
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16), color: mainColor),
                child: BottomNavigationBar(
                  currentIndex: bottomNavBarIndex,
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  selectedItemColor: Colors.white,
                  unselectedItemColor: Colors.grey[400],
                  onTap: (index) {
                    setState(() {
                      bottomNavBarIndex = index;
                    });
                    pageController.jumpToPage(index);
                  },
                  items: [
                    BottomNavigationBarItem(
                        icon: Icon(FontAwesomeIcons.home), label: "Home"),
                    BottomNavigationBarItem(
                        icon: Icon(FontAwesomeIcons.list), label: "Aktivitas")
                  ],
                ),
              ),
            ),
          ),

          //map button
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: Container(
                width: 40,
                height: 40,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                child: GestureDetector(
                  onTap: () => Get.toNamed('/mapScreenPage'),
                  child: Icon(
                    FontAwesomeIcons.mapMarkerAlt,
                    color: mainColor,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
