part of 'widgets.dart';

class Rating extends StatelessWidget {
  final double rating;

  Rating(this.rating);
  @override
  Widget build(BuildContext context) {
    List<Widget> stars = [];

    // double value = rating / 2;

    for (int i = 1; i <= 5; i++) {
      stars.add((i <= rating)
          ? Icon(
              Icons.star,
              color: Colors.amber,
              size: 18,
            )
          : (i - rating < 1 && i - rating > 0)
              ? Icon(
                  Icons.star_half,
                  color: Colors.amber,
                  size: 18,
                )
              : Icon(
                  Icons.star_border,
                  color: Colors.amber,
                  size: 18,
                ));
    }

    stars.add(SizedBox(
      width: 5,
    ));
    stars.add(Text(
        rating.toString().substring(
            0, rating.toString().length < 4 ? rating.toString().length : 4),
        style: themeFont.copyWith(fontSize: 14)));

    return Row(
      children: stars,
    );
  }
}
