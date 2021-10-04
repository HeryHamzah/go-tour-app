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
      child: Container(
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
                      context.bloc<FavoriteDestinationBloc>().add(
                          AddToFavorites(
                              idUser: "8nIGOI2xezOHO4nPHEcUAos1ngg1",
                              destination: destination));
                    },
                    child: Icon(
                      Icons.favorite,
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
              style:
                  themeFont.copyWith(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Rating(8.9),
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
      ),
    );
  }
}
