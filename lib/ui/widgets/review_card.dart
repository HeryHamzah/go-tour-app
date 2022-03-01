part of 'widgets.dart';

class ReviewCard extends StatelessWidget {
  final Ticket ticket;
  final TourGuideTicket tourGuideTicket;

  ReviewCard(this.ticket, this.tourGuideTicket);

  @override
  Widget build(BuildContext context) {
    return ticket != null
        ? generateDestinationReview()
        : generateTourGuideReview();
  }

  Container generateDestinationReview() {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                  radius: 15,
                  backgroundImage: (ticket.userImage == "")
                      ? AssetImage("assets/avatar.png")
                      : NetworkImage(BaseUrl.getUserImages + ticket.userImage)),
              SizedBox(
                width: 16,
              ),
              Text(
                ticket.userName,
                style: themeFont.copyWith(fontWeight: FontWeight.w500),
              )
            ],
          ),
          SizedBox(
            height: 6,
          ),
          Rating(rating: ticket.rating),
          SizedBox(
            height: 6,
          ),
          Text(ticket.comment)
        ],
      ),
    );
  }

  Container generateTourGuideReview() {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                  radius: 15,
                  backgroundImage: (tourGuideTicket.userPicture == "")
                      ? AssetImage("assets/avatar.png")
                      : NetworkImage(
                          BaseUrl.getUserImages + tourGuideTicket.userPicture)),
              SizedBox(
                width: 16,
              ),
              Text(
                tourGuideTicket.userName,
                style: themeFont.copyWith(fontWeight: FontWeight.w500),
              )
            ],
          ),
          SizedBox(
            height: 6,
          ),
          Rating(rating: tourGuideTicket.rating),
          SizedBox(
            height: 6,
          ),
          Text(tourGuideTicket.comment)
        ],
      ),
    );
  }
}
