part of "../pages.dart";

class TopUpPage extends StatefulWidget {
  @override
  _TopUpPageState createState() => _TopUpPageState();
}

class _TopUpPageState extends State<TopUpPage> {
  List<int> template = [
    50000,
    100000,
    200000,
    250000,
    500000,
    1000000,
    2000000,
    2500000,
    5000000
  ];
  int amount = 0;
  User user = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        leading: GestureDetector(
            onTap: () => Get.back(), child: Icon(Icons.arrow_back_ios_new)),
        title: Text("Top Up"),
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(defaultMargin, 20, defaultMargin, 0),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Total",
                  style: themeFont.copyWith(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 14,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (amount > 0) {
                          setState(() {
                            amount -= 50000;
                          });
                        }
                      },
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: mainColor.withOpacity(.3),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          MaterialCommunityIcons.minus,
                          color: Color(0XFF567DF4),
                        ),
                      ),
                    ),
                    Text(
                      NumberFormat.currency(
                              locale: "id_ID", decimalDigits: 0, symbol: "Rp")
                          .format(amount),
                      style: themeFont.copyWith(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (amount < template[8]) {
                          setState(() {
                            amount += 50000;
                          });
                        }
                      },
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: mainColor.withOpacity(.3),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          MaterialCommunityIcons.plus,
                          color: Color(0XFF567DF4),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Pilih dari template",
                  style: themeFont.copyWith(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 14),
                Wrap(
                  spacing: 24,
                  runSpacing: 16,
                  children: List.generate(
                      template.length,
                      (index) => TemplateTopUpCard(
                            width: (MediaQuery.of(context).size.width -
                                    2 * defaultMargin -
                                    2 * 24) /
                                3,
                            amount: template[index],
                            isSelected: template[index] == amount,
                            onTap: () {
                              if (template[index] == amount) {
                                amount = 0;
                              } else if (template[index] != amount) {
                                amount = template[index];
                              }
                              setState(() {});
                            },
                          )),
                ),
                SizedBox(height: 100),
                Center(
                  child: Container(
                    height: 45,
                    child: ElevatedButton(
                        style:
                            ElevatedButton.styleFrom(onPrimary: Colors.white),
                        onPressed: () {
                          Fluttertoast.showToast(
                              msg: "Tahan untuk konfirmasi topup",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.black,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        },
                        onLongPress: () {
                          UserServices.saveTransaction(GoTourTransaction(
                              userID: user.id,
                              picturePath: "",
                              title: "Top Up",
                              amount: amount,
                              desc: "",
                              time: DateTime.now()));
                        },
                        child: Text(
                          "Tahan untuk Topup",
                          style: themeFont.copyWith(
                              color: Colors.white, fontSize: 16),
                        )),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
