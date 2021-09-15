part of 'shared.dart';

String dbUrl = "http://10.0.2.2/gotour/";

class BaseUrl {
  static String regisUser = dbUrl + "user_signup.php";
  static String getUser = dbUrl + "get_user.php";
  static String getLocations = dbUrl + "get_locations.php";
  static String getAssets = dbUrl + "images/assets/";
  static String getUserImages = dbUrl + "images/user_upload/";
  static String uploadUserImage = dbUrl + "upload_user_image.php";
  static String userUpdate = dbUrl + "user_update.php";
}
