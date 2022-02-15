part of 'widgets.dart';

class BestDestinationCard extends StatelessWidget {
  final Destination destination;

  BestDestinationCard(this.destination);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Hero(
          tag: destination.id,
          child: Container(
            width: double.infinity,
            height: 150,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                    image:
                        NetworkImage(BaseUrl.getAssets + destination.images[0]),
                    fit: BoxFit.cover)),
            child: Container(
                height: 150,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: LinearGradient(
                        begin: Alignment(0, 1),
                        end: Alignment(0, 0.1),
                        colors: [
                          Colors.black.withOpacity(.7),
                          Colors.black.withOpacity(0)
                        ]))),
          ),
        ),
        Positioned(
          bottom: 10,
          left: 10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 25,
                height: 4,
                color: backColor,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                destination.name,
                style: themeFont.copyWith(
                    color: backColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "${destination.numberOfReviews} ulasan",
                style: themeFont.copyWith(color: backColor, fontSize: 16),
              )
            ],
          ),
        ),
      ],
    );
  }
}
