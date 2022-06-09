import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:frontend/services/auth_service.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Sign {
  AuthService service = AuthService();
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<User?> credentials({required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    if (kIsWeb) {
      GoogleAuthProvider authProvider = GoogleAuthProvider();

      try {
        final UserCredential userCredential =
            await auth.signInWithPopup(authProvider);

        user = userCredential.user;
      } catch (e) {
        print(e);
      }
    } else {
      final GoogleSignIn googleSignIn = GoogleSignIn();

      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        try {
          final UserCredential userCredential =
              await auth.signInWithCredential(credential);

          user = userCredential.user;
        } on FirebaseAuthException catch (e) {
          if (e.code == 'account-exists-with-different-credential') {
          } else if (e.code == 'invalid-credential') {}
        } catch (e) {}
      }
    }
    return user;
  }

  Future<User?> signInWithGoogle({required BuildContext context}) async {
    User? user = await credentials(context: context);
    if (user != null) {
      var parts = user.displayName?.split(' ');
      //Separamos el nombre completo que proporciona Google en nombre y apellido, porque así se muestra a los usuarios
      String nameUserFound = parts![0].trim();
      String surnameUserFound = parts[1].trim();
      String username = nameUserFound + surnameUserFound;
      //Como Google no proporciona la contraseña, se utiliza la misma que se ha utilizado en el register por defecto, ya que no puede ser Null pero tampoco tiene ninguna utilidad
      String password = "Google";
      if (await service.login(username, password)) {
        print("Log in with Google done");
      }
    }
    return user;
  }
}
