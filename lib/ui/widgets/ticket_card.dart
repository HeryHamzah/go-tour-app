part of 'widgets.dart';

class TicketCard extends StatelessWidget {
  final Ticket ticket;
  final Function onTap;

  TicketCard({this.ticket, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onTap != null) {
          onTap();
        }
      },
      child: Container(
        height: 90,
        child: Row(
          children: [
            Container(
              width: 75,
              height: 90,
              margin: EdgeInsets.only(right: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                      image: NetworkImage(
                          BaseUrl.getAssets + ticket.destination.images[0]),
                      fit: BoxFit.cover)),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width -
                  2 * defaultMargin -
                  75 -
                  20,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ticket.destination.name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: themeFont.copyWith(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 2),
                  Text(
                    ticket.time.dayAndDate,
                    style: themeFont.copyWith(fontSize: 14),
                  ),
                  SizedBox(height: 2),
                  Text(
                    ticket.destination.location,
                    style: themeFont.copyWith(fontSize: 14),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
