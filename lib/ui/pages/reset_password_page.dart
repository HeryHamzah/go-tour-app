part of 'pages.dart';

class ResetPasswordPage extends StatefulWidget {
  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  TextEditingController emailController = TextEditingController();

  bool isValid = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: InkWell(
            onTap: () => Get.back(), child: Icon(Icons.arrow_back_ios_new)),
        title: Text("Reset Password", style: themeFont.copyWith(fontSize: 20)),
      ),
      body: ListView(
        children: [
          Container(
            padding:
                EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 40),
            child: Column(
              children: [
                Text(
                    "Silahkan masukkan email yang pernah Anda daftarkan sebelumnya. Tautan reset password akan dikirim ke email tersebut.",
                    textAlign: TextAlign.center,
                    style: themeFont),
                SizedBox(height: 20),
                Align(
                    alignment: Alignment.topLeft,
                    child:
                        Text("EMAIL", style: themeFont.copyWith(fontSize: 18))),
                SizedBox(height: 5),
                TextField(
                  onChanged: (email) {
                    isValid = EmailValidator.validate(email);
                    setState(() {});
                  },
                  autofocus: true,
                  controller: emailController,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(width: 1, color: Colors.grey)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(width: 1, color: Colors.grey))),
                ),
                SizedBox(height: 20),
                Container(
                    width: double.infinity,
                    height: 46,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: mainColor),
                        onPressed: (isValid)
                            ? () async {
                                await AuthServices.resetPassword(
                                    emailController.text);
                                showSnackBar(context,
                                    "Tautan reset password telah dikirim!");
                              }
                            : null,
                        child: Text("KIRIM",
                            style: themeFont.copyWith(
                                color: backColor, fontSize: 16))))
              ],
            ),
          )
        ],
      ),
    );
  }
}
