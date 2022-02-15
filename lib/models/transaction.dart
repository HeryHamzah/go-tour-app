part of "models.dart";

class GoTourTransaction extends Equatable {
  //NOTE: A for Topup, B for ticket transaction, C for Tour Guide Reservation
  final String transactionID;
  final String userID;
  final String picturePath;
  final String title;
  final int amount;
  final String desc;
  final DateTime time;

  GoTourTransaction(
      {this.transactionID,
      this.userID,
      this.picturePath,
      this.title,
      this.amount,
      this.desc,
      this.time});

  factory GoTourTransaction.fromJson(Map<String, dynamic> json) =>
      GoTourTransaction(
          transactionID: json["id_transaction"],
          userID: json["id_user"],
          picturePath: json["picture_path"],
          title: json["title"],
          amount: int.tryParse(json["amount"]),
          desc: json["description"],
          time:
              DateTime.fromMillisecondsSinceEpoch(int.tryParse(json["time"])));
  @override
  List<Object> get props =>
      [transactionID, userID, picturePath, title, amount, desc, time];
}
