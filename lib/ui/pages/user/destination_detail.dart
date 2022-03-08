part of '../pages.dart';

class DestinationDetailPage extends StatefulWidget {
  @override
  _DestinationDetailPageState createState() => _DestinationDetailPageState();
}

class _DestinationDetailPageState extends State<DestinationDetailPage> {
  Destination destination = Get.arguments;
  int _currentImage = 0;

  List<Widget> buildImageIndicator() {
    List<Widget> list = [];

    for (var i = 0; i < destination.images.length; i++) {
      list.add(
          i == _currentImage ? buildIndicator(true) : buildIndicator(false));
    }
    return list;
  }

  Widget buildIndicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      width: isActive ? 20 : 8,
      height: 8,
      decoration: BoxDecoration(
          color: isActive ? mainColor : Colors.grey[400],
          borderRadius: BorderRadius.circular(4)),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: backColor,
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                bottom: 40, top: 30, left: defaultMargin, right: defaultMargin),
            child: BlocBuilder<UserBloc, UserState>(
              builder: (context, userState) {
                // User user = (userState as UserLoaded).user;
                List<String> favorites =
                    (userState as UserLoaded).user.favorites;
                return Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: Stack(
                        children: [
                          Container(
                              width: size.width,
                              height: 450,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image:
                                        AssetImage('assets/cache_portrait.png'),
                                    fit: BoxFit.cover),
                              )),
                          Container(
                            width: size.width,
                            height: 450,
                            // color: Colors.blue,
                            child: Stack(
                              children: [
                                PageView(
                                  onPageChanged: (page) {
                                    setState(() {
                                      _currentImage = page;
                                    });
                                  },
                                  children: destination.images
                                      .map((e) => Hero(
                                            tag: destination.id,
                                            child: Container(
                                              width: size.width,
                                              height: 450,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          BaseUrl.getAssets +
                                                              e),
                                                      fit: BoxFit.cover)),
                                            ),
                                          ))
                                      .toList(),
                                ),
                                Positioned(
                                    left: 20,
                                    top: 20,
                                    child: GestureDetector(
                                      onTap: () => Get.back(),
                                      child: Container(
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                              color: backColor,
                                              shape: BoxShape.circle),
                                          child: Icon(
                                            Icons.arrow_back,
                                            color: mainColor,
                                          )),
                                    )),
                                Positioned(
                                    right: 20,
                                    top: 20,
                                    child: GestureDetector(
                                      onTap: () {
                                        if (favorites
                                            .contains(destination.id)) {
                                          context.bloc<UserBloc>().add(
                                              RemoveFromFavorites(
                                                  destination.id));
                                        } else {
                                          context.bloc<UserBloc>().add(
                                              AddToFavorites(destination.id));
                                        }
                                        setState(() {});
                                        Fluttertoast.showToast(
                                            msg: (favorites
                                                    .contains(destination.id))
                                                ? "Hapus dari Favoritku"
                                                : "Tambah ke Favoritku",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.black,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                      },
                                      child: Container(
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                              color: backColor,
                                              shape: BoxShape.circle),
                                          child: Icon(
                                            (favorites.contains(destination.id))
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            color: Colors.pink,
                                          )),
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: size.width * 0.15,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: buildImageIndicator(),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: SizedBox(
                        width: size.width - 2 * defaultMargin,
                        child: Text(
                          "${destination.name}, ${destination.locationName}",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: themeFont.copyWith(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    InkWell(
                      onTap: () => Get.toNamed('/reviewPage',
                          arguments: [destination, null]),
                      child: Row(
                        children: [
                          Rating(rating: destination.rating),
                          SizedBox(
                            width: 10,
                          ),
                          Text("(${destination.numberOfReviews})")
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text("Tentang",
                          style: themeFont.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          )),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(destination.about,
                          maxLines: 4,
                          style: themeFont.copyWith(
                            fontSize: 16,
                          )),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Text(
                          NumberFormat.currency(
                                  locale: 'id_ID',
                                  decimalDigits: 0,
                                  symbol: "Rp")
                              .format(int.parse(destination.price)),
                          style: themeFont.copyWith(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: mainColor),
                        ),
                        Text(
                          "/orang",
                          style: themeFont.copyWith(
                              fontSize: 16, color: Colors.grey),
                        ),
                        Spacer(),
                        Container(
                          height: 40,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: mainColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8))),
                              onPressed: () => Get.toNamed('/bookingPage',
                                  arguments: destination),
                              child: Text("Reservasi",
                                  style: themeFont.copyWith(
                                      color: Colors.white, fontSize: 16))),
                        )
                      ],
                    )
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
