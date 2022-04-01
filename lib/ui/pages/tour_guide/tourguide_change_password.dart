part of '../pages.dart';

class TourGuideChangepassword extends StatefulWidget {
  @override
  State<TourGuideChangepassword> createState() =>
      _TourGuideChangepasswordState();
}

class _TourGuideChangepasswordState extends State<TourGuideChangepassword> {
  TourGuide tourGuide = Get.arguments;

  TextEditingController _currentPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _confirmNewPasswordController = TextEditingController();

  bool isValid = false;
  bool _secureCurrentPassword = true;
  bool _secureNewPassword = true;
  bool _secureConfirmNewFassword = true;

  void validate(
      {String currentPassword, String newPassword, String confirmNewPassword}) {
    setState(() {
      isValid =
          (currentPassword ?? _currentPasswordController.text).trim().length >=
                  6 &&
              (newPassword ?? _newPasswordController.text).trim().length >= 6 &&
              (confirmNewPassword ?? _confirmNewPasswordController.text)
                      .trim()
                      .length >=
                  6;
    });
  }

  void showAlertDialog(String message) {
    AlertDialog alertDialog = AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            MaterialCommunityIcons.alert,
            color: mainColor,
            size: 100,
          ),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
      actions: [
        MaterialButton(
            onPressed: () {
              Get.back();
            },
            textColor: Colors.white,
            color: mainColor,
            child: Text("OK")),
      ],
    );
    showDialog(builder: (context) => alertDialog, context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Ganti Password",
                  style: themeFont.copyWith(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 40,
                ),
                Text("Password saat ini",
                    style: themeFont.copyWith(fontSize: 16)),
                TextField(
                  controller: _currentPasswordController,
                  obscureText: _secureCurrentPassword,
                  onChanged: (currentPassword) =>
                      validate(currentPassword: currentPassword),
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _secureCurrentPassword = !_secureCurrentPassword;
                          });
                        },
                        icon: (_secureCurrentPassword)
                            ? Icon(Icons.visibility_off)
                            : Icon(Icons.visibility)),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text("Password baru", style: themeFont.copyWith(fontSize: 16)),
                TextField(
                  controller: _newPasswordController,
                  obscureText: _secureNewPassword,
                  onChanged: (newPassword) =>
                      validate(newPassword: newPassword),
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _secureNewPassword = !_secureNewPassword;
                          });
                        },
                        icon: (_secureNewPassword)
                            ? Icon(Icons.visibility_off)
                            : Icon(Icons.visibility)),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text("Konfirmasi password baru",
                    style: themeFont.copyWith(fontSize: 16)),
                TextField(
                  controller: _confirmNewPasswordController,
                  obscureText: _secureConfirmNewFassword,
                  onChanged: (confirmNewPassword) =>
                      validate(confirmNewPassword: confirmNewPassword),
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _secureConfirmNewFassword =
                                !_secureConfirmNewFassword;
                          });
                        },
                        icon: (_secureConfirmNewFassword)
                            ? Icon(Icons.visibility_off)
                            : Icon(Icons.visibility)),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  width: double.infinity,
                  height: 46,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: mainColor),
                      onPressed: (isValid)
                          ? () {
                              if (_currentPasswordController.text !=
                                  tourGuide.password) {
                                showAlertDialog("Password saat ini salah!");
                              } else if (_newPasswordController.text !=
                                  _confirmNewPasswordController.text) {
                                showAlertDialog("Konfirmasi password salah!");
                              } else if (_newPasswordController.text ==
                                  tourGuide.password) {
                                showAlertDialog(
                                    "Password baru Anda sama dengan yang lama!");
                              } else {
                                context.bloc<TourGuideBloc>().add(
                                      UpdateTourGuide(
                                          tourGuide.copyWith(
                                              password:
                                                  _newPasswordController.text),
                                          null),
                                    );
                                Get.back();
                                Get.back();
                              }
                            }
                          : null,
                      child: Text("Ganti Password",
                          style: themeFont.copyWith(
                              letterSpacing: 2,
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500))),
                )
              ],
            ),
          ),
        ));
  }
}
