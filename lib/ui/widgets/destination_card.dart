part of 'widgets.dart';

class DestinationCard extends StatefulWidget {
  final Destination destination;
  final Function onTap;

  DestinationCard({this.destination, this.onTap});

  @override
  State<DestinationCard> createState() => _DestinationCardState();
}

class _DestinationCardState extends State<DestinationCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.onTap != null) {
          widget.onTap();
        }
      },
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, userState) {
          if (userState is UserLoaded) {
            List<String> favorites = userState.user.favorites;

            return Container(
              width: double.infinity,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18), color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Hero(
                    tag: widget.destination.id,
                    child: Container(
                      height: 200,
                      width: double.infinity,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          image: DecorationImage(
                              image: NetworkImage(BaseUrl.getAssets +
                                  widget.destination.images[0]),
                              fit: BoxFit.cover)),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: GestureDetector(
                          onTap: () {
                            (favorites.contains(widget.destination.id))
                                ? context.bloc<UserBloc>().add(
                                    RemoveFromFavorites(widget.destination.id))
                                : context
                                    .bloc<UserBloc>()
                                    .add(AddToFavorites(widget.destination.id));

                            setState(() {});

                            Fluttertoast.showToast(
                                msg: (favorites.contains(widget.destination.id))
                                    ? "Hapus dari favoritku"
                                    : "Tambah ke favoritku",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.black,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          },
                          child: Icon(
                            (favorites.contains(widget.destination.id))
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
                    widget.destination.name,
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
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }
}
