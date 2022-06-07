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

  Future<User?> signUpWithGoogle({required BuildContext context}) async {
    User? user = await credentials(context: context);
    if (user != null) {
      var parts = user.displayName?.split(' ');
      //Separamos el nombre completo que proporciona Google en nombre y apellido, porque así se muestra a los usuarios
      String? name = parts![0].trim();
      String? surname = parts[1].trim();
      String? username = user.displayName;
      //Los valores que no proporciona Google se han puesto por defecto, ya que sin estos la API no funciona ya que son requeridos para el funcionamiento de esta
      String password = "Hola";
      String? email = user.email;
      if (user.email == "") {
        String? email = "jordi@gmail.com";
      }
      String? phone = "123467";
      List? _myLanguages = ["Catalan", "Spanish"];
      List<String> location = ["41.276162923989475", "1.987217865082827"];
      String? photo =
          "unnamed.png"; //Nombre de una foto que esta subida a nuestro Firebase

      if (await service.register(name, surname, username, password, email,
          phone, location, _myLanguages.cast<String>(), photo)) {
        print("Register with Google done");
      }
    }
    return user;
  }

  Future<User?> signInWithGoogle({required BuildContext context}) async {
    User? user = await credentials(context: context);
    if (user != null) {
      String? username = user.displayName;
      //Como Google no proporciona la contraseña, se utiliza la misma que se ha utilizado en el register por defecto
      String password = "Hola";
      if (await service.loginGoogle(username, password)) {
        print("Log in with Google done");
      }
    }
    return user;
  }
}
