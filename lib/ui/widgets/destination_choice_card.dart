part of 'widgets.dart';

class DestinationChoice extends StatefulWidget {
  final Destination destination;
  final bool isSelected;
  final Function onTap;
  final Function onIconTap;

  DestinationChoice(
      {this.destination, this.isSelected = false, this.onTap, this.onIconTap});

  @override
  State<DestinationChoice> createState() => _DestinationChoiceState();
}

class _DestinationChoiceState extends State<DestinationChoice> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.onTap != null) {
          widget.onTap();
        }
      },
      child: Container(
        width: 150,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 150,
              height: 100,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                image: DecorationImage(
                    image: NetworkImage(
                        BaseUrl.getAssets + widget.destination.images[0]),
                    fit: BoxFit.cover),
              ),
              child: Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {
                    if (widget.onIconTap != null) {
                      widget.onIconTap();
                    }
                  },
                  child: Icon(
                    FontAwesomeIcons.plane,
                    size: 20,
                    color: (widget.isSelected) ? mainColor : Colors.white,
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 5, top: 5, right: 5),
              width:
                  MediaQuery.of(context).size.width - 2 * defaultMargin - 5 - 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    NumberFormat.currency(
                            locale: 'id_ID', decimalDigits: 0, symbol: 'Rp')
                        .format(
                      int.tryParse(widget.destination.price),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: themeFont.copyWith(
                        color: mainColor, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.destination.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
