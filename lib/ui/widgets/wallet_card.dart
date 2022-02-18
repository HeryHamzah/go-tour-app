part of "widgets.dart";

class WalletCard extends StatelessWidget {
  final User user;

  WalletCard(this.user);

  @override
  Widget build(BuildContext context) {
    return Container(
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
              Text(user.id.substring(0, 12).toUpperCase(),
                  style: themeFont.copyWith(
                      color: Colors.white, fontWeight: FontWeight.w500)),
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
                            color: Colors.amber, shape: BoxShape.circle),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Saldo",
                    style: themeFont.copyWith(
                        color: Colors.grey[200],
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Text(
                      NumberFormat.currency(
                              locale: "id_ID", decimalDigits: 0, symbol: "Rp")
                          .format(user.balance),
                      maxLines: 2,
                      style: themeFont.copyWith(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
