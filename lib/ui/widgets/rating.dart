part of 'widgets.dart';

class Rating extends StatelessWidget {
  final double rating;

  Rating(this.rating);
  @override
  Widget build(BuildContext context) {
    List<Widget> stars = [];

    double value = rating / 2;

    for (int i = 1; i <= 5; i++) {
      stars.add((i <= value)
          ? Icon(
              Icons.star,
              color: Colors.amber,
              size: 18,
            )
          : (i - value < 1 && i - value > 0)
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
    stars.add(Text(rating.toString(), style: themeFont.copyWith(fontSize: 14)));

    return Row(
      children: stars,
    );
  }
}
