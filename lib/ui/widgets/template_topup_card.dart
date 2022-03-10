part of 'widgets.dart';

class TemplateTopUpCard extends StatelessWidget {
  final double width;
  final bool isSelected;
  final int amount;
  final Function onTap;

  TemplateTopUpCard(
      {this.width, this.isSelected = false, this.amount, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap();
        }
      },
      child: Container(
        width: width,
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: (isSelected) ? mainColor : mainColor.withOpacity(.2),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Text(
              "IDR",
              style: themeFont.copyWith(
                  fontSize: 16,
                  color: (isSelected) ? backColor : Colors.blueGrey),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              NumberFormat.currency(
                      locale: "id_ID", decimalDigits: 0, symbol: "")
                  .format(amount),
              style: themeFont.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: (isSelected) ? backColor : Colors.blueGrey),
            )
          ],
        ),
      ),
    );
  }
}
