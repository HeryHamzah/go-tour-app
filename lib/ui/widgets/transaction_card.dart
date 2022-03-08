part of "widgets.dart";

class TransactionCard extends StatelessWidget {
  final GoTourTransaction transaction;

  TransactionCard(this.transaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Stack(
            children: [
              Container(
                width: 75,
                height: 90,
                margin: EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                        image: AssetImage('assets/cache_portrait.png'),
                        fit: BoxFit.cover)),
              ),
              Container(
                width: 75,
                height: 90,
                margin: EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                        image: (transaction.transactionID.contains("B"))
                            ? NetworkImage(
                                BaseUrl.getAssets + transaction.picturePath)
                            : transaction.transactionID.contains("A")
                                ? AssetImage("assets/topup_cover.png")
                                : NetworkImage(BaseUrl.getTourGuideImages +
                                    transaction.picturePath),
                        fit: BoxFit.cover)),
              ),
            ],
          ),
          SizedBox(
            width:
                MediaQuery.of(context).size.width - 2 * defaultMargin - 75 - 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: themeFont.copyWith(fontSize: 16),
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  NumberFormat.currency(
                          locale: 'id_ID', decimalDigits: 0, symbol: '')
                      .format(transaction.amount),
                  style: themeFont.copyWith(
                      color: (transaction.amount > 0) ? mainColor : Colors.red,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 2,
                ),
                Text(transaction.time.dayAndDate)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
