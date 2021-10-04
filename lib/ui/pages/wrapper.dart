part of 'pages.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    auth.User firebaseUser = Provider.of<auth.User>(context);

    if (firebaseUser == null) {
      return SplashPage();
    } else {
      print("LOGIN");
      context.bloc<UserBloc>().add(LoadUser(firebaseUser.uid));
      context
          .bloc<FavoriteDestinationBloc>()
          .add(GetFavorites(firebaseUser.uid));
      return MainDrawer();
    }
  }
}
