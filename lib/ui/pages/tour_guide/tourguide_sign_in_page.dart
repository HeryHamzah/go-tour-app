part of '../pages.dart';

class TourGuideSignInPage extends StatefulWidget {
  @override
  _TourGuideSignInPageState createState() => _TourGuideSignInPageState();
}

class _TourGuideSignInPageState extends State<TourGuideSignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool obscurePassword = true;
  bool signInProcess = false;
  bool isValidate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                top: 20,
                left: defaultMargin,
                right: defaultMargin,
                bottom: defaultMargin),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(Icons.arrow_back_ios_new)),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Sign In sebagai Tour Guide",
                  style: themeFont.copyWith(fontSize: 24),
                ),
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: Container(
                      width: 100,
                      height: 100,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: mainColor,
                      ),
                      child: Image.asset("assets/logo_app.png",
                          fit: BoxFit.contain)),
                ),
                SizedBox(
                  height: 30,
                ),
                TextField(
                  controller: emailController,
                  onChanged: (email) {
                    setState(() {
                      isValidate = EmailValidator.validate(email) &&
                          passwordController.text.length >= 6;
                    });
                  },
                  decoration: InputDecoration(
                      hintText: "Email",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(8))),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: passwordController,
                  obscureText: obscurePassword,
                  onChanged: (password) {
                    setState(() {
                      isValidate =
                          EmailValidator.validate(emailController.text) &&
                              password.length >= 6;
                    });
                  },
                  decoration: InputDecoration(
                      hintText: "Password",
                      filled: true,
                      fillColor: Colors.white,
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              obscurePassword = !obscurePassword;
                            });
                          },
                          icon: (obscurePassword)
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility)),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(8))),
                ),
                SizedBox(
                  height: 50,
                ),
                (signInProcess == false)
                    ? Container(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary:
                                    (isValidate) ? mainColor : Colors.grey),
                            onPressed: (isValidate)
                                ? () async {
                                    setState(() {
                                      signInProcess = true;
                                    });
                                    await TourGuideServices.signIn(
                                        emailController.text,
                                        passwordController.text);

                                    // if (result.user == null) {
                                    //   showSnackBar(context, result.message);
                                    //   setState(() {
                                    //     signInProcess = false;
                                    //   });
                                    // }
                                    // TODO: hilangkan nanti
                                    // else {
                                    //   Get.back();
                                    // }
                                  }
                                : null,
                            child: Text(
                              "Sign In",
                              style: themeFont.copyWith(
                                  color: Colors.white, fontSize: 18),
                            )),
                      )
                    : SpinKitFadingCircle(
                        size: 50,
                        color: mainColor,
                      ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Text("Ingin daftar sebagai Tour Guide?  "),
                    InkWell(
                      onTap: () {
                        //TODO: buat pagenya
                      },
                      child: Text(
                        "ketentuan",
                        style: themeFont.copyWith(color: mainColor),
                      ),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
