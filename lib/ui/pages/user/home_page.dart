part of '../pages.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: MaterialButton(
          onPressed: () async {
            await AuthServices.signOut();
            context.bloc<UserBloc>().add(SignOutUser());
          },
          child: Text("Logout")),
    )
        //  BlocBuilder<UserBloc, UserState>(
        //   builder: (_, userState) {
        //     if (userState is UserLoaded) {
        //       User user = userState.user;
        //       return Column(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: [
        //           Text("Home Page"),
        //           Text(userState.user.name ?? 'null'),
        //           MaterialButton(
        //             onPressed: () async {
        //               await AuthServices.signOut();
        //               context.bloc<UserBloc>().add(SignOutUser());
        //             },
        //           )
        //         ],
        //       );
        //     } else {
        //       return SpinKitFadingCircle(color: mainColor, size: 50);
        //     }
        //   },
        // ),
        );
  }
}
