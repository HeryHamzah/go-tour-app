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
      body: BlocBuilder<FavoriteDestinationBloc, FavoriteDestinationState>(
        builder: (context, state) {
          List<Destination> destinations = state.destinations;

          if (destinations.length > 0) {
            return Column(
                children: destinations
                    .map((e) => GestureDetector(
                          onTap: () {
                            context
                                .bloc<FavoriteDestinationBloc>()
                                .add(RemoveFromFavorites(e));
                          },
                          child: Text(
                            e.name,
                            style: themeFont.copyWith(color: Colors.black),
                          ),
                        ))
                    .toList());
          } else {
            return Text("Belum ada data");
          }
        },
      ),
    );
  }
}
