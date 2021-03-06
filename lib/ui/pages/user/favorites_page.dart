part of '../pages.dart';

class FavoritePage extends StatefulWidget {
  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: GestureDetector(
              onTap: () => ZoomDrawer.of(context).open(),
              child: Icon(
                MaterialCommunityIcons.menu,
                color: backColor,
              )),
          title: Text(
            "Favoritku",
            style: themeFont.copyWith(color: backColor),
          ),
        ),
        body: BlocBuilder<UserBloc, UserState>(
          builder: (context, userState) {
            User user = (userState as UserLoaded).user;

            return FutureBuilder(
                future: UserServices.getFavorites(user.id),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Destination> favorites = snapshot.data;

                    return (favorites.length > 0)
                        ? ListView(
                            children: [
                              Column(
                                children: favorites
                                    .map(
                                      (e) => GestureDetector(
                                        onTap: () {
                                          Get.toNamed('/destinationDetail',
                                              arguments: e);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            top: 20,
                                          ),
                                          child: Slidable(
                                              actionPane:
                                                  SlidableDrawerActionPane(),
                                              secondaryActions: <Widget>[
                                                IconSlideAction(
                                                  caption: ' \nHapus',
                                                  color: Colors.red,
                                                  icon: Icons.delete,
                                                  onTap: () {
                                                    context
                                                        .bloc<UserBloc>()
                                                        .add(
                                                            RemoveFromFavorites(
                                                                e.id));

                                                    setState(() {});
                                                  },
                                                ),
                                              ],
                                              child: FavoriteCard(e)),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                              SizedBox(
                                height: 20,
                              )
                            ],
                          )
                        : Center(
                            child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset("assets/no_data.png"),
                              Text("Belum Ada Data"),
                            ],
                          ));
                  } else {
                    return SpinKitFadingCircle(
                      color: mainColor,
                    );
                  }
                });
          },
        ));
  }
}
