part of '../pages.dart';

class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  ZoomDrawerController drawerController = ZoomDrawerController();
  int idSelectedPage = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ZoomDrawer(
        controller: drawerController,
        menuScreen: DrawerPage(),
        mainScreen: (idSelectedPage == 1) ? MainPage() : FavoritePage(),
        borderRadius: 24.0,
        angle: 0.0,
        backgroundColor: Colors.grey[300],
        slideWidth: MediaQuery.of(context).size.width *
            (ZoomDrawer.isRTL() ? .45 : 0.65),
      ),
    );
  }
}

class DrawerPage extends StatefulWidget {
  @override
  _DrawerPageState createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
        color: mainColor,
        child: ListView(
          children: [
            Column(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => ZoomDrawer.of(context).close(),
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    CircleAvatar(
                      backgroundImage:
                          NetworkImage(BaseUrl.getImage + "pinisi.jpg"),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Hery Hamzah",
                        style: themeFont.copyWith(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500))
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                ListTile(
                    contentPadding: EdgeInsets.all(0),
                    leading: Icon(
                      FontAwesomeIcons.home,
                      color: Colors.white,
                    ),
                    title: Text(
                      'Home',
                      style: themeFont.copyWith(color: Colors.white),
                    ),
                    onTap: () {}),
                Divider(
                  thickness: 1,
                  color: Colors.white,
                ),
                ListTile(
                  contentPadding: EdgeInsets.all(0),
                  leading: Icon(
                    Icons.person,
                    size: 30,
                    color: Colors.white,
                  ),
                  title: Text(
                    'Profile',
                    style: themeFont.copyWith(color: Colors.white),
                  ),
                ),
                Divider(
                  thickness: 1,
                  color: Colors.white,
                ),
                ListTile(
                  contentPadding: EdgeInsets.all(0),
                  leading: Icon(
                    FontAwesomeIcons.umbrellaBeach,
                    color: Colors.white,
                  ),
                  title: Text(
                    'Favorite',
                    style: themeFont.copyWith(color: Colors.white),
                  ),
                  onTap: () {},
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
