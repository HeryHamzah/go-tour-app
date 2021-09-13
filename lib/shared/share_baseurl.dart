part of 'shared.dart';

String dbUrl = "http://10.0.2.2/gotour/";

class BaseUrl {
  static String regisUser = dbUrl + "signup.php";
  static String getUser = dbUrl + "getuser.php";
  static String getLocation = dbUrl + "getlocation.php";
  static String getAssets = dbUrl + "images/assets/";
  static String getUserImages = dbUrl + "images/user_upload/";
  static String uploadUserImage = dbUrl + "uploaduserimage.php";
}
