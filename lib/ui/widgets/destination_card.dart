part of 'widgets.dart';

class DestinationCard extends StatelessWidget {
  final Destination destination;
  final Function onTap;

  DestinationCard({this.destination, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onTap != null) {
          onTap();
        }
      },
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, userState) {
          List<String> destinations = (userState as UserLoaded).user.favorites;

          return Container(
            width: double.infinity,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18), color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: destination.id,
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        image: DecorationImage(
                            image: NetworkImage(
                                BaseUrl.getAssets + destination.images[0]),
                            fit: BoxFit.cover)),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () {
                          (destinations.contains(destination.id))
                              ? context
                                  .bloc<UserBloc>()
                                  .add(RemoveFromFavorite(destination.id))
                              : context.bloc<UserBloc>().add(AddToFavorite(
                                  (userState as UserLoaded).user.id,
                                  destination.id));

                          Fluttertoast.showToast(
                              msg: (destinations.contains(destination.id))
                                  ? "Remove from Favorites"
                                  : "Add to Favorites",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.black,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        },
                        child: Icon(
                          (destinations.contains(destination.id))
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: Colors.redAccent,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  destination.name,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: themeFont.copyWith(
                      fontSize: 16, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Rating(7.9),
                    Spacer(),
                    SizedBox(
                        width: (MediaQuery.of(context).size.width -
                                2 * defaultMargin -
                                20) /
                            2,
                        child: Text(
                          "(200 Reviews)",
                          style: themeFont.copyWith(color: Colors.grey),
                          textAlign: TextAlign.end,
                        ))
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
