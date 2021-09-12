part of '../pages.dart';

class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  ZoomDrawerController drawerController = ZoomDrawerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NavdrawerBloc, NavdrawerState>(
        builder: (context, drawerState) {
          return ZoomDrawer(
            style: DrawerStyle.Style1,
            controller: drawerController,
            menuScreen: DrawerPage(),
            mainScreen: buildMainScreen(drawerState.idPage),
            borderRadius: 24.0,
            angle: 0.0,
            showShadow: true,
            backgroundColor: Colors.grey[300],
            slideWidth: MediaQuery.of(context).size.width *
                (ZoomDrawer.isRTL() ? .45 : 0.65),
          );
        },
      ),
    );
  }
}

buildMainScreen(int idPage) {
  switch (idPage) {
    case 1:
      return MainPage();
    case 2:
      return FavoritePage();
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
        padding: EdgeInsets.fromLTRB(20, 20, 20, 80),
        color: mainColor,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                  onTap: () {
                    context.bloc<NavdrawerBloc>().add(ChangePage(1));
                    ZoomDrawer.of(context).close();
                  }),
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
                onTap: () {
                  context.bloc<NavdrawerBloc>().add(ChangePage(2));
                  ZoomDrawer.of(context).close();
                },
              ),
              Divider(
                thickness: 1,
                color: Colors.white,
              ),
              Spacer(),
              OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    primary: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    side: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    AuthServices.signOut();
                    context.bloc<UserBloc>().add(SignOutUser());
                    context.bloc<NavdrawerBloc>().add(ChangePage(1));
                  },
                  child: Text(
                    "Logout",
                    style:
                        themeFont.copyWith(fontSize: 18, color: Colors.white),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
