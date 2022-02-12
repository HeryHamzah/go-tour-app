part of 'widgets.dart';

class FavoriteCard extends StatefulWidget {
  final Destination destination;

  FavoriteCard(this.destination);

  @override
  _FavoriteCardState createState() => _FavoriteCardState();
}

class _FavoriteCardState extends State<FavoriteCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: defaultMargin),
      child: Row(
        children: [
          Container(
            width: 75,
            height: 90,
            margin: EdgeInsets.only(right: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                  image: NetworkImage(
                      BaseUrl.getAssets + widget.destination.images[0]),
                  fit: BoxFit.cover),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width -
                    2 * defaultMargin -
                    75 -
                    20,
                child: Text(
                    "${widget.destination.name}, ${widget.destination.location}",
                    maxLines: 2,
                    style: themeFont.copyWith(
                        fontSize: 16, fontWeight: FontWeight.w600),
                    overflow: TextOverflow.ellipsis),
              ),
              Rating(rating: widget.destination.rating),
              Row(
                children: [
                  Text(
                    NumberFormat.currency(
                            locale: 'id_ID', decimalDigits: 0, symbol: "Rp")
                        .format(int.parse(widget.destination.price)),
                    style: themeFont.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: mainColor),
                  ),
                  Text(
                    "/orang",
                    style: themeFont.copyWith(fontSize: 16, color: Colors.grey),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
