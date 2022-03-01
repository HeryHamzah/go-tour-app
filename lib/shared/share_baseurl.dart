part of 'shared.dart';

String dbUrl = "http://10.0.2.2/gotour/";

class BaseUrl {
  static String regisUser = dbUrl + "user_API/user_signup.php";
  static String getUser = dbUrl + "user_API/get_user.php";
  static String getLocations = dbUrl + "user_API/get_locations.php";
  static String getAssets = dbUrl + "images/assets/";
  static String getUserImages = dbUrl + "images/user_upload/";
  static String uploadUserImage = dbUrl + "user_API/upload_user_image.php";
  static String userUpdate = dbUrl + "user_API/user_update.php";
  // static String getDestinationsbyLocation =
  //     dbUrl + "user_API/get_destinations.php";
  static String getDetailDestination =
      dbUrl + "user_API/get_detail_destination.php";
  // static String addToFavorites = dbUrl + "user_API/add_to_favorites.php";
  // static String removeFromFavorites =
  //     dbUrl + "user_API/remove_from_favorites.php";
  static String getTransactions = dbUrl + "user_API/get_transactions.php";
  static String saveTransaction = dbUrl + "user_API/save_transaction.php";
  static String saveTicket = dbUrl + "user_API/save_ticket.php";
  static String getTickets = dbUrl + "user_API/get_tickets.php";
  static String getTourGuides = dbUrl + "user_API/get_tourguides.php";
  static String getTourGuideImages = dbUrl + "images/tourguide_upload/";
  static String saveTourGuideTicket =
      dbUrl + "user_API/save_tourguide_ticket.php";
  static String getTourGuideTickets =
      dbUrl + "user_API/get_tourguide_tickets.php";
  static String getDestinations = dbUrl + "user_API/get_destinations.php";
  // static String getTourGuideReviews =
  //     dbUrl + "user_API/get_tourguide_reviews.php";
  // static String getDestinationReviews =
  //     dbUrl + "user_API/get_destination_reviews.php";
  static String addDestinationReview =
      dbUrl + "user_API/add_destination_review.php";
  static String addTourGuideReview =
      dbUrl + "user_API/add_tourguide_review.php";
  // static String getAllTickets = dbUrl + "user_API/get_all_tickets.php";
}
