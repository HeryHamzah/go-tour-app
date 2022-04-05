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
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, userState) {
          if (userState is UserLoaded) {
            User user = userState.user;
            return BlocBuilder<NavdrawerBloc, NavdrawerState>(
              builder: (context, drawerState) {
                return ZoomDrawer(
                  style: DrawerStyle.Style1,
                  controller: drawerController,
                  menuScreen: DrawerPage(),
                  mainScreen:
                      buildMainScreen(pageID: drawerState.idPage, user: user),
                  borderRadius: 24.0,
                  angle: 0.0,
                  showShadow: true,
                  backgroundColor: Colors.grey[300],
                  slideWidth: MediaQuery.of(context).size.width *
                      (ZoomDrawer.isRTL() ? .45 : 0.65),
                );
              },
            );
          } else {
            return SpinKitFadingCircle(color: mainColor, size: 50);
          }
        },
      ),
    );
  }
}

//FIXME: error drawer setelah topup / beli tiket
buildMainScreen({int pageID, User user}) {
  switch (pageID) {
    case 1:
      return MainPage();
    case 2:
      return ProfilePage(user);
    case 3:
      return FavoritePage();
    case 4:
      return TourGuidePage();
    case 5:
      return MyWalletPage();
    case 6:
      return AppGuidePage();
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
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<UserBloc, UserState>(
                  builder: (context, userState) {
                    if (userState is UserLoaded) {
                      User user = userState.user;
                      if (imageToUpload != null) {
                        context.bloc<UserBloc>().add(UploadProfileUser(
                            imageFile: imageToUpload, idUser: user.id));

                        imageToUpload = null;
                      }
                      return Row(
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
                          GestureDetector(
                            onTap: () {
                              context.bloc<NavdrawerBloc>().add(ChangePage(2));
                              ZoomDrawer.of(context).close();
                            },
                            child: CircleAvatar(
                              backgroundImage: (user.profilePicture != "")
                                  ? NetworkImage(BaseUrl.getUserImages +
                                      user.profilePicture)
                                  : AssetImage("assets/avatar.png"),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Text(user.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: themeFont.copyWith(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500)),
                          )
                        ],
                      );
                    } else {
                      return SpinKitFadingCircle(
                        size: 46,
                        color: backColor,
                      );
                    }
                  },
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
                      FontAwesomeIcons.wallet,
                      color: Colors.white,
                    ),
                    title: Text(
                      'Dompetku',
                      style: themeFont.copyWith(color: Colors.white),
                    ),
                    onTap: () {
                      context.bloc<NavdrawerBloc>().add(ChangePage(5));
                      ZoomDrawer.of(context).close();
                    }),
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
                    'Favoritku',
                    style: themeFont.copyWith(color: Colors.white),
                  ),
                  onTap: () {
                    context.bloc<NavdrawerBloc>().add(ChangePage(3));
                    ZoomDrawer.of(context).close();
                  },
                ),
                Divider(
                  thickness: 1,
                  color: Colors.white,
                ),
                ListTile(
                  contentPadding: EdgeInsets.all(0),
                  leading: Icon(
                    FontAwesomeIcons.plane,
                    color: Colors.white,
                  ),
                  title: Text(
                    'Trip dengan Tour Guide',
                    style: themeFont.copyWith(color: Colors.white),
                  ),
                  onTap: () {
                    context.bloc<NavdrawerBloc>().add(ChangePage(4));
                    ZoomDrawer.of(context).close();
                  },
                ),
                Divider(
                  thickness: 1,
                  color: Colors.white,
                ),
                ListTile(
                    contentPadding: EdgeInsets.all(0),
                    leading: Icon(
                      Icons.book_sharp,
                      color: Colors.white,
                      size: 30,
                    ),
                    title: Text(
                      'Panduan Aplikasi',
                      style: themeFont.copyWith(color: Colors.white),
                    ),
                    onTap: () {
                      context.bloc<NavdrawerBloc>().add(ChangePage(6));
                      ZoomDrawer.of(context).close();
                    }),
                Divider(
                  thickness: 1,
                  color: Colors.white,
                ),
                ListTile(
                    contentPadding: EdgeInsets.all(0),
                    leading: Icon(
                      Icons.ac_unit,
                      color: Colors.white,
                      size: 30,
                    ),
                    title: Text(
                      'Tentang Saya',
                      style: themeFont.copyWith(color: Colors.white),
                    ),
                    onTap: () {}),
                Divider(
                  thickness: 1,
                  color: Colors.white,
                ),
                // Spacer(),
                SizedBox(
                  height: 40,
                ),
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
                      //ID page dikembalikan ke home sebelum logout
                      context.bloc<NavdrawerBloc>().add(ChangePage(1));
                    },
                    child: Text(
                      "Keluar",
                      style:
                          themeFont.copyWith(fontSize: 18, color: Colors.white),
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
