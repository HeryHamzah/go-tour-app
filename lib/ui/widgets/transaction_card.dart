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
                        : AssetImage("assets/home.jpg"),
                    fit: BoxFit.cover)),
          ),
          Column(
            children: [
              Text(transaction.title),
              Text(transaction.amount.toString()),
              Text(transaction.desc)
            ],
          ),
        ],
      ),
    );
  }
}
