part of 'services.dart';

class AuthServices {
  static auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

  static Future<SignInSignUpResult> signUp(
      String email, String password, String name) async {
    try {
      auth.UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      User user = result.user.convertToUser(name: name);
      await UserServices.regisUser(user);
      return SignInSignUpResult(user: user);
    } catch (e) {
      return SignInSignUpResult(message: "Error Auth signUp: " + e.toString());
    }
  }

  static Future<SignInSignUpResult> signIn(
      String email, String password) async {
    try {
      auth.UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      User user = await result.user.fromDatabase();
      return SignInSignUpResult(user: user);
    } catch (e) {
      print(e.toString());
      return SignInSignUpResult(message: "Error Auth signIn: " + e.toString());
    }
  }

  static Future<void> signOut() async {
    await _auth.signOut();
  }

  // static Future<void> updateEmail(String email) async {
  //   await _auth.currentUser.reauthenticateWithCredential(
  //       auth.EmailAuthProvider.getCredential(email: email, password: '123456'));
  // }

  static Stream<auth.User> get userStream => _auth.authStateChanges();
}

class SignInSignUpResult {
  final User user;
  final String message;

  SignInSignUpResult({this.user, this.message});
}
