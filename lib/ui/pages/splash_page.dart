part of 'pages.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/splash.jpg"), fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
                width: MediaQuery.of(context).size.width - 2 * defaultMargin,
                height: 55,
                child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        primary: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        side: BorderSide(
                          color: Colors.white,
                        )),
                    onPressed: () {
                      Get.toNamed('/signIn');
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(fontSize: 18),
                    ))),
            Container(
                width: MediaQuery.of(context).size.width - 2 * defaultMargin,
                height: 55,
                margin: EdgeInsets.only(bottom: 30, top: 15),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        primary: Colors.white,
                        onPrimary: Color(0XFF00D4D5)),
                    onPressed: () {
                      Get.toNamed('/signUp');
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(fontSize: 18),
                    )))
          ],
        ),
      ),
    );
  }
}
