part of 'widgets.dart';

class BestDestinationsCard extends StatelessWidget {
  // final Destination destination;

  // BestDestinationsCard(this.destination);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 100,
          padding: EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
              color: Colors.grey[100], borderRadius: BorderRadius.circular(15)),
          child: Row(
            children: [
              Container(
                width: 85,
                height: 100,
                margin: EdgeInsets.only(right: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                      image: NetworkImage(BaseUrl.getAssets + "Pinisi_1.jpg"),
                      fit: BoxFit.cover),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width -
                        2 * defaultMargin -
                        85 -
                        20 -
                        10,
                    child: Text(
                      "Phinisi",
                      style: themeFont.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1.0),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: MediaQuery.of(context).size.width -
                        2 * defaultMargin -
                        85 -
                        20 -
                        10,
                    child: Text(
                      "Laboris et cillum aliquip commodo minim officia non. Sit irure labore eu aliquip aute veniam ad tempor non ipsum nostrud dolore magna culpa. Laborum excepteur consequat Lorem nulla excepteur minim minim culpa. Reprehenderit minim elit enim et duis.",
                      style: themeFont.copyWith(
                          fontSize: 14, color: Colors.grey[700]),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Container(
            width: 35,
            height: 20,
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: mainColor),
            child: Center(
              child: Text(
                "7.8",
                style: themeFont.copyWith(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
