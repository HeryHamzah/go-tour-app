part of 'pages.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController retypePasswordController = TextEditingController();

  bool obscurePassword = true;
  bool obscureRetypePassword = true;
  File profilePicture;
  bool signUpProcess = false;

  void showModalPhoto() {
    showModalBottomSheet(
        context: context,
        backgroundColor: mainColor,
        builder: (context) {
          return Container(
            padding: EdgeInsets.all(20),
            height: MediaQuery.of(context).size.height / 6,
            child: Column(
              children: [
                Text("Profile Picture",
                    style: TextStyle(fontSize: 18, color: Colors.white)),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () async {
                        profilePicture = await galleryPhoto();
                        Navigator.pop(context);
                        setState(() {});
                      },
                      child: Column(
                        children: [
                          Icon(Icons.camera_alt, color: Colors.white),
                          SizedBox(
                            height: 5,
                          ),
                          Text("Gallery",
                              style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    InkWell(
                      onTap: () async {
                        profilePicture = await cameraPhoto();
                        Navigator.pop(context);
                        setState(() {});
                      },
                      child: Column(
                        children: [
                          Icon(
                            Icons.camera,
                            color: Colors.white,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text("Camera", style: TextStyle(color: Colors.white))
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          );
        });
  }

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
                  "Sign Up",
                  style: themeFont.copyWith(fontSize: 24),
                ),
                Center(
                  child: Container(
                    width: 115,
                    height: 115,
                    margin: EdgeInsets.symmetric(vertical: 30),
                    child: Stack(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: (profilePicture != null)
                                      ? FileImage(profilePicture)
                                      : AssetImage("assets/avatar.png"),
                                  fit: BoxFit.cover)),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: InkWell(
                            onTap: () {
                              if (profilePicture == null) {
                                showModalPhoto();
                              } else {
                                profilePicture = null;
                              }
                              setState(() {});
                            },
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                  color: mainColor, shape: BoxShape.circle),
                              child: Icon(
                                (profilePicture == null)
                                    ? Icons.photo
                                    : Icons.delete,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
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
                  controller: nameController,
                  decoration: InputDecoration(
                      hintText: "Name",
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
                TextField(
                  controller: retypePasswordController,
                  obscureText: obscureRetypePassword,
                  decoration: InputDecoration(
                      hintText: "Retype Password",
                      filled: true,
                      fillColor: Colors.white,
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              obscureRetypePassword = !obscureRetypePassword;
                            });
                          },
                          icon: (obscureRetypePassword)
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility)),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(8))),
                ),
                SizedBox(
                  height: 30,
                ),
                (signUpProcess == false)
                    ? Container(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: mainColor, onPrimary: Colors.white),
                            onPressed: () async {
                              if (nameController.text.trim() == "" ||
                                  emailController.text.trim() == "" ||
                                  passwordController.text.trim() == "" ||
                                  retypePasswordController.text.trim() == "") {
                                showSnackBar(
                                    context, "Complete the form first!");
                              } else if (!(EmailValidator.validate(
                                  emailController.text))) {
                                showSnackBar(context, "Wrong email form");
                              } else if (passwordController.text.length < 6) {
                                showSnackBar(context,
                                    "Password is a minimum of six character length");
                              } else if (passwordController.text !=
                                  retypePasswordController.text) {
                                showSnackBar(
                                    context, "Confirm password is incorrect");
                              } else {
                                setState(() {
                                  signUpProcess = true;
                                });
                                if (profilePicture != null) {
                                  imageToUpload = profilePicture;
                                }
                                SignInSignUpResult result =
                                    await AuthServices.signUp(
                                        emailController.text,
                                        passwordController.text,
                                        nameController.text);

                                if (result.user == null) {
                                  showSnackBar(context, result.message);
                                  setState(() {
                                    signUpProcess = false;
                                  });
                                }
                              }
                            },
                            child: Text(
                              "Sign Up",
                              style: themeFont.copyWith(
                                  fontSize: 18, color: Colors.white),
                            )),
                      )
                    : SpinKitFadingCircle(color: mainColor, size: 50),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text("Already member? "),
                    InkWell(
                      onTap: () {
                        Get.toNamed('/signIn');
                      },
                      child: Text(
                        "Sign In",
                        style: themeFont.copyWith(color: mainColor),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
