part of '../pages.dart';

class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
              onTap: () => ZoomDrawer.of(context).open(),
              child: Icon(MaterialCommunityIcons.menu)),
          title: Text("Favorites"),
        ),
        body: BlocBuilder<UserBloc, UserState>(
          builder: (context, userState) {
            User user = (userState as UserLoaded).user;
            return FutureBuilder(
                future: UserServices.getFavorites(user.id),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Destination> destinations = snapshot.data;
                    return Column(
                      children: destinations.map((e) => Text(e.name)).toList(),
                    );
                  } else {
                    return Text("Belum Ada Data");
                  }
                });
          },
        ));
  }
}
