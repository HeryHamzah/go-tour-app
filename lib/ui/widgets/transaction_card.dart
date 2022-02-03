part of "widgets.dart";

class TransactionCard extends StatelessWidget {
  final GoTourTransaction transaction;

  TransactionCard(this.transaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
            width: 75,
            height: 90,
            margin: EdgeInsets.only(right: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                    image: (transaction.picturePath != "")
                        ? NetworkImage(
                            BaseUrl.getAssets + transaction.picturePath)
                        : AssetImage("assets/topup_cover.png"),
                    fit: BoxFit.cover)),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                transaction.title,
                style: themeFont.copyWith(fontSize: 16),
              ),
              Text(
                transaction.amount.toString(),
                style: themeFont.copyWith(
                    color: (transaction.amount > 0) ? mainColor : Colors.red,
                    fontWeight: FontWeight.bold),
              ),
              Text(transaction.time.dayAndDate)
            ],
          ),
        ],
      ),
    );
  }
}
