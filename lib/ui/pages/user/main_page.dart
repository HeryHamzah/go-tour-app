part of '../pages.dart';

class MainPage extends StatefulWidget {
  final int bottomNavBarIndex;

  MainPage({this.bottomNavBarIndex = 0});
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int bottomNavBarIndex;
  PageController controller = PageController();

  @override
  void initState() {
    super.initState();
    bottomNavBarIndex = widget.bottomNavBarIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller,
            onPageChanged: (index) {
              setState(() {
                bottomNavBarIndex = index;
              });
            },
            children: [HomePage(), ActivityPage()],
          ),
          //bottom navbar
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(
                  left: defaultMargin, right: defaultMargin, bottom: 30),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
                curve: Curves.easeOutSine,
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: (bottomNavBarIndex == 0) ? Colors.white : mainColor),
                child: BottomNavigationBar(
                  currentIndex: bottomNavBarIndex,
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  selectedItemColor:
                      (bottomNavBarIndex == 0) ? mainColor : Colors.white,
                  unselectedItemColor:
                      (bottomNavBarIndex == 0) ? Colors.grey : Colors.grey[400],
                  onTap: (index) {
                    setState(() {
                      bottomNavBarIndex = index;
                    });
                    controller.jumpToPage(index);
                  },
                  items: [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.dashboard_rounded), label: "Home"),
                    BottomNavigationBarItem(
                        icon: Icon(MaterialCommunityIcons.view_list),
                        label: "Activity")
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
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (bottomNavBarIndex == 0) ? mainColor : Colors.white),
                child: Icon(
                  MaterialCommunityIcons.map_marker,
                  color: (bottomNavBarIndex == 0) ? Colors.white : mainColor,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
