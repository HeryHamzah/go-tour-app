part of 'shared.dart';

String dbUrl = "http://192.168.43.200/gotour/";
// String dbUrl = "http://10.0.2.2/gotour/";

class BaseUrl {
  static String regisUser = dbUrl + "user_API/user_signup.php";
  static String getUser = dbUrl + "user_API/get_user.php";
  static String getLocations = dbUrl + "user_API/get_locations.php";
  static String getAssets = dbUrl + "images/assets/";
  static String getUserImages = dbUrl + "images/user_upload/";
  static String uploadUserImage = dbUrl + "user_API/upload_user_image.php";
  static String userUpdate = dbUrl + "user_API/user_update.php";
  static String getDetailDestination =
      dbUrl + "user_API/get_detail_destination.php";
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
  static String addDestinationReview =
      dbUrl + "user_API/add_destination_review.php";
  static String addTourGuideReview =
      dbUrl + "user_API/add_tourguide_review.php";

  static String tourGuideSignIn = dbUrl + "tourguide_API/tourguide_login.php";
  static String getTourGuide = dbUrl + "tourguide_API/get_tourguide.php";
  static String changeStatus = dbUrl + "tourguide_API/update_status.php";
  static String updateTourGuide = dbUrl + "tourguide_API/tourguide_update.php";
  static String uploadTourGuideImage =
      dbUrl + "tourguide_API/upload_tourguide_image.php";
}
