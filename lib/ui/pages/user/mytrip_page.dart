part of '../pages.dart';

class MyTripPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              ZoomDrawer.of(context).open();
            },
            icon: Icon(MaterialCommunityIcons.menu)),
        title: Text("My Trip"),
      ),
      body: BlocBuilder<UserBloc, UserState>(builder: (context, userState) {
        User user = (userState as UserLoaded).user;
        return FutureBuilder(
            future: UserServices.getMyTrips(user.id),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Destination> destinations = snapshot.data;
                return (destinations.length > 0)
                    ? ListView(children: [
                        Column(
                          children: destinations
                              .map((e) => Padding(
                                    padding: const EdgeInsets.only(top: 20.0),
                                    child: FavoriteCard(e),
                                  ))
                              .toList(),
                        ),
                      ])
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
      }),
    );
  }
}
