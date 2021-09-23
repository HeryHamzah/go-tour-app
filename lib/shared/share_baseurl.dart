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
  static String getDestinations = dbUrl + "user_API/get_destinations.php";
  static String addToFavorites = dbUrl + "user_API/add_to_favorites.php";
  static String removeFromFavorites =
      dbUrl + "user_API/remove_from_favorites.php";
  static String getFavorites = dbUrl + "user_API/get_favorites.php";
}
