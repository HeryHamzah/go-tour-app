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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Note: CARD
                WalletCard(widget.user),
                SizedBox(
                  height: 20,
                ),
                //Note: Transaksi Terkini
                Text("Transaksi Terkini",
                    style: themeFont.copyWith(
                        fontSize: 16, fontWeight: FontWeight.w500)),
                SizedBox(
                  height: 10,
                ),
                FutureBuilder(
                    future: UserServices.getTransactions(widget.user.id),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<GoTourTransaction> transactions = snapshot.data;
                        return Column(
                          children: transactions
                              .map((e) => Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: TransactionCard(e),
                                  ))
                              .toList(),
                        );
                      } else {
                        return SpinKitFadingCircle(
                          color: mainColor,
                        );
                      }
                    })
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed('/topUpPage', arguments: widget.user);
          },
          child: Icon(
            MaterialCommunityIcons.plus,
            color: Colors.white,
          )),
    );
  }
}
