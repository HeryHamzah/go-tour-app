part of 'pages.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            child: Image.asset(
              "assets/home.jpg",
              fit: BoxFit.cover,
            ),
          ),
          BlocBuilder<UserBloc, UserState>(
            builder: (_, userState) {
              if (userState is UserLoaded) {
                User user = userState.user;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Home Page"),
                    Text(user.name),
                    MaterialButton(
                      onPressed: () async {
                        await AuthServices.signOut();
                        context.bloc<UserBloc>().add(SignOutUser());
                      },
                    )
                  ],
                );
              } else {
                return SpinKitFadingCircle(color: mainColor, size: 50);
              }
            },
          ),
        ],
      ),
    );
  }
}
