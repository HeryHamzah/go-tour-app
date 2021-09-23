part of '../pages.dart';

class FavoritePage extends StatelessWidget {
  final String idUser;

  FavoritePage(this.idUser);
  @override
  Widget build(BuildContext context) {
    context.bloc<FavoriteDestinationBloc>().add(GetFavorites(idUser));
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () => ZoomDrawer.of(context).open(),
            child: Icon(MaterialCommunityIcons.menu)),
        title: Text("Favorites"),
      ),
      body: BlocBuilder<FavoriteDestinationBloc, FavoriteDestinationState>(
        builder: (context, state) {
          List<Destination> destinations = state.destinations;

          if (destinations.length > 0) {
            return Column(children: [Text(destinations[1].name)]
                // destinations
                //         .map((e) => Text(
                //               e.name,
                //               style: themeFont.copyWith(color: Colors.black),
                //             ))
                //         .toList() +
                //     [Text("OK")]
                );
          } else {
            return Text("Belum ada data");
          }
        },
      ),
    );
  }
}
