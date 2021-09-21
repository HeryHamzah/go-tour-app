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
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Container(
                    width: size.width,
                    height: 450,
                    color: Colors.blue,
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
                                                  BaseUrl.getAssets + e),
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
                                      color: backColor, shape: BoxShape.circle),
                                  child: Icon(
                                    Icons.arrow_back,
                                    color: mainColor,
                                  )),
                            )),
                        Positioned(
                            right: 20,
                            top: 20,
                            child: GestureDetector(
                              onTap: () {},
                              child: Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: backColor, shape: BoxShape.circle),
                                  child: Icon(
                                    Icons.favorite,
                                    color: Colors.pink,
                                  )),
                            )),
                      ],
                    ),
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
                      "${destination.name}, ${destination.location}",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: themeFont.copyWith(
                          fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
