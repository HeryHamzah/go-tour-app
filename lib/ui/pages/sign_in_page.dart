part of 'pages.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool obscurePassword = true;
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

                Container(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: mainColor),
                      onPressed: () {},
                      child: Text(
                        "Sign In",
                        style: themeFont.copyWith(
                            color: Colors.white, fontSize: 18),
                      )),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Text("Start fresh now?  "),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpPage()));
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
