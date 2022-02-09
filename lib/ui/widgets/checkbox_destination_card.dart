part of 'widgets.dart';

class CheckBoxDestinationCard extends StatefulWidget {
  final Destination destination;
  final bool isSelected;

  CheckBoxDestinationCard({this.destination, this.isSelected = false});

  @override
  State<CheckBoxDestinationCard> createState() =>
      _CheckBoxDestinationCardState();
}

class _CheckBoxDestinationCardState extends State<CheckBoxDestinationCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      child: Stack(
        children: [
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      BaseUrl.getAssets + widget.destination.images[0]),
                  fit: BoxFit.cover),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 150,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment(0, 1),
                    end: Alignment(0, 0.1),
                    colors: [backColor, backColor.withOpacity(0)]),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(widget.destination.name),
                  Text(widget.destination.price)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
