part of 'widgets.dart';

class ReviewCard extends StatelessWidget {
  final Review review;

  ReviewCard(this.review);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 15,
                backgroundImage: (review.userPicture == "")
                    ? AssetImage("assets/avatar.png")
                    : NetworkImage(BaseUrl.getUserImages + review.userPicture),
              ),
              SizedBox(
                width: 16,
              ),
              Text(
                review.userName,
                style: themeFont.copyWith(fontWeight: FontWeight.w500),
              )
            ],
          ),
          SizedBox(
            height: 6,
          ),
          Rating(rating: review.rating),
          SizedBox(
            height: 6,
          ),
          Text(review.coment)
        ],
      ),
    );
  }
}
