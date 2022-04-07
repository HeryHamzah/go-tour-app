part of 'widgets.dart';

class HistoryTicketCard extends StatelessWidget {
  final TourGuideTicket tourGuideTicket;
  final Function onTap;

  HistoryTicketCard({this.tourGuideTicket, this.onTap});

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
            Stack(
              children: [
                Container(
                  width: 75,
                  height: 90,
                  margin: EdgeInsets.only(right: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                          image: AssetImage('assets/cache_portrait.png'),
                          fit: BoxFit.cover)),
                ),
                Hero(
                  tag: tourGuideTicket.bookingCode,
                  child: Container(
                    width: 75,
                    height: 90,
                    margin: EdgeInsets.only(right: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                            image: (tourGuideTicket.user.profilePicture != "")
                                ? NetworkImage(BaseUrl.getUserImages +
                                    tourGuideTicket.user.profilePicture)
                                : AssetImage('assets/cache_portrait.png'),
                            fit: BoxFit.cover)),
                  ),
                ),
              ],
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
                    tourGuideTicket.user.name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: themeFont.copyWith(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 2),
                  Text(
                    tourGuideTicket.dateTime.dayAndDate,
                    style: themeFont.copyWith(fontSize: 14),
                  ),
                  SizedBox(height: 2),
                  Text(
                    tourGuideTicket.destinations,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
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
