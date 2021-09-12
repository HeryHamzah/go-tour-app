part of 'widgets.dart';

class LocationCard extends StatelessWidget {
  final Location location;

  LocationCard(this.location);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 150,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
              image: NetworkImage(BaseUrl.getImage + location.image),
              fit: BoxFit.cover)),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Container(
          width: 100,
          height: 150 / 6,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topRight: Radius.circular(25))),
          child: Center(
            child: Text(
              location.name,
              style: themeFont.copyWith(
                  color: mainColor, fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
    );
  }
}
