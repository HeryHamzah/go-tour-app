part of 'pages.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool obscurePassword = true;
  bool signInProcess = false;

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
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back_ios_new)),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Sign In",
                  style: themeFont.copyWith(fontSize: 24),
                ),
                SizedBox(
                  height: 30,
                ),
                //TODO: ganti icon app
                Center(
                  child: Container(
                    width: 100,
                    height: 100,
                    color: mainColor,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                TextField(
                  controller: emailController,
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
                  height: 10,
                ),
                Row(
                  children: [
                    Text("Forgot password?  "),
                    Text(
                      "Reset password",
                      style: themeFont.copyWith(color: mainColor),
                    )
                  ],
                ),
                SizedBox(
                  height: 50,
                ),

                (signInProcess == false)
                    ? Container(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(primary: mainColor),
                            onPressed: () async {
                              setState(() {
                                signInProcess = true;
                              });
                              SignInSignUpResult result =
                                  await AuthServices.signIn(
                                      'hery@gmail.com', '123456');

                              if (result.user == null) {
                                print(result.message);
                                setState(() {
                                  signInProcess = false;
                                });
                              } else {
                                Get.back();
                              }
                            },
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
                    Text("Start fresh now?  "),
                    InkWell(
                      onTap: () {
                        Get.toNamed('/signUp');
                      },
                      child: Text(
                        "Sign Up",
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
