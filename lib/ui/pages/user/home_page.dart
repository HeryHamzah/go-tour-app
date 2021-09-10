part of '../pages.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //background home page
          Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/home.jpg"),
                      fit: BoxFit.cover))),

          //content
          Padding(
            padding: EdgeInsets.fromLTRB(defaultMargin, 20, defaultMargin, 40),
            child: ListView(
              children: [
                Row(
                  children: [
                    Icon(Icons.menu, color: Colors.white, size: 30),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          height: 45,
                          child: TextField(
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none),
                                prefixIcon: Icon(Icons.search),
                                hintText: "City, places etc.",
                                hintStyle: themeFont.copyWith(
                                    color: Colors.grey, letterSpacing: 1.5),
                                filled: true,
                                fillColor: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 100,
                ),
                FutureBuilder(
                    future: UserServices.getLocation(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<Location> location = snapshot.data;
                        return Container(
                          height: 100,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, i) => Container(
                                  width: 90,
                                  height: 90,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(BaseUrl.getImage +
                                              location[i].image),
                                          fit: BoxFit.cover)))),
                        );
                      } else {
                        return SpinKitFadingCircle();
                      }
                    })
              ],
            ),
          ),
        ],
      ),
    );
  }
}
