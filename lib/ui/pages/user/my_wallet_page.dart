part of '../pages.dart';

class MyWalletPage extends StatefulWidget {
  final User user;

  MyWalletPage(this.user);
  @override
  _MyWalletPageState createState() => _MyWalletPageState();
}

class _MyWalletPageState extends State<MyWalletPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        leading: GestureDetector(
            onTap: () => ZoomDrawer.of(context).open(),
            child: Icon(MaterialCommunityIcons.menu)),
        title: Text("Dompetku"),
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(defaultMargin, 0, defaultMargin, 0),
        child: ListView(
          children: [
            Column(
              children: [
                //CARD
                Container(
                  width: double.infinity,
                  height: 185,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: mainColor,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            spreadRadius: 0,
                            offset: Offset(0, 5))
                      ]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(widget.user.id.substring(0, 12).toUpperCase(),
                              style: themeFont.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500)),
                          Container(
                            width: 50,
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                        color: Colors.amber,
                                        shape: BoxShape.circle),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                        color: Colors.red.withOpacity(.8),
                                        shape: BoxShape.circle),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Column(
                            children: [
                              Text(
                                "Saldo",
                                style: themeFont.copyWith(
                                    color: Colors.grey[200],
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text("")
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {},
          label:
              Text("Top Up", style: themeFont.copyWith(color: Colors.white))),
    );
  }
}
