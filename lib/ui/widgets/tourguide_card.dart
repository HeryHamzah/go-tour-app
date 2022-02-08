part of 'widgets.dart';

class TourGuideCard extends StatelessWidget {
  final TourGuide tourGuide;
  final double width;
  final Function onTap;

  TourGuideCard({this.tourGuide, this.width, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onTap != null) {
          onTap();
        }
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.all(0),
        child: SizedBox(
          width: width,
          child: Column(
            children: [
              Hero(
                tag: tourGuide.tourGuideID,
                child: Container(
                  width: width,
                  height: width,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(BaseUrl.getTourGuideImages +
                              tourGuide.profilePicture),
                          fit: BoxFit.cover)),
                ),
              ),
              Text(
                tourGuide.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: themeFont.copyWith(
                    fontSize: 16, fontWeight: FontWeight.w500),
              ),
              Text(
                tourGuide.location,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
        ),
      ),
    );
  }
}
