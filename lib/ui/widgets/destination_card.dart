part of 'widgets.dart';

class DestinationCard extends StatelessWidget {
  final Destination destination;

  DestinationCard(this.destination);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: double.infinity,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                    image:
                        NetworkImage(BaseUrl.getAssets + destination.images[0]),
                    fit: BoxFit.cover)),
            child: Align(
              alignment: Alignment.topRight,
              child: Icon(
                Icons.favorite,
                color: Colors.redAccent,
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
          )
        ],
      ),
    );
  }
}
