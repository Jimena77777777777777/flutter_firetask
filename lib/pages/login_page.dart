import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase/models/user_model.dart';
import 'package:flutter_firebase/pages/home_page.dart';
import 'package:flutter_firebase/pages/register_page.dart';
import 'package:flutter_firebase/services/my_service_firestore.dart';
import 'package:flutter_firebase/ui/general/colors.dart';
import 'package:flutter_firebase/ui/widgets/button_custom_widget.dart';
import 'package:flutter_firebase/ui/widgets/button_normal_widget.dart';
import 'package:flutter_firebase/ui/widgets/general_widgets.dart';
import 'package:flutter_firebase/ui/widgets/textfield_normal_widget.dart';
import 'package:flutter_firebase/ui/widgets/textfield_password_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ["email"]);
  MyServiceFirestore userService = MyServiceFirestore(collection: "users");

  _login() async {
    try {
      if (formKey.currentState!.validate()) {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
        if (userCredential.user != null) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
              (route) => false);
        }
      }
    } on FirebaseAuthException catch (error) {
      if (error.code == "invalid-email") {
        showSnackBarError(context, "El correo electrónico es invalido");
      } else if (error.code == "user-not-found") {
        showSnackBarError(context, "El usuario no está registrado");
      } else if (error.code == "wrong-password") {
        showSnackBarError(context, "La contraseña es incorrecta");
      }
    }
  }

  _loginWithGoogle() async {
    GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();

    if (googleSignInAccount == null) {
      return;
    }

    GoogleSignInAuthentication _googleSignInAuth =
        await googleSignInAccount.authentication;

    OAuthCredential credential = GoogleAuthProvider.credential(
      idToken: _googleSignInAuth.idToken,
      accessToken: _googleSignInAuth.accessToken,
    );

    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    if (userCredential.user != null) {
      UserModel userModel = UserModel(
        fullName: userCredential.user!.displayName!,
        email: userCredential.user!.email!,
      );
      userService.existUser(userCredential.user!.email!).then((value) {
        if (!value) {
          userService.addUser(userModel).then((value) {
            if (value.isNotEmpty) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                  (route) => false);
            }
          });
        } else {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
              (route) => false);
        }
      });
    }
  }

  _loginWithFacebook() async {
    LoginResult _loginResult = await FacebookAuth.instance.login(
      permissions: ['public_profile', 'email'],
    );

    if (_loginResult.status == LoginStatus.success) {
      Map<String, dynamic> userData = await FacebookAuth.instance.getUserData();

      AccessToken accessToken = _loginResult.accessToken!;

      OAuthCredential credential =
          FacebookAuthProvider.credential(accessToken.tokenString);

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      if (userCredential.user != null) {
        UserModel userModel = UserModel(
          fullName: userCredential.user!.displayName!,
          email: userCredential.user!.email!,
        );

        userService.existUser(userCredential.user!.email!).then((value) {
          if (!value) {
            userService.addUser(userModel).then((value) {
              if (value.isNotEmpty) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                    (route) => false);
              }
            });
          } else {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
                (route) => false);
          }
        });
      }
    } else {
      // Manejar el caso de error aquí
      print("Error durante el inicio de sesión: ${_loginResult.status}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                divider30(),
                SvgPicture.asset(
                  'assets/images/login.svg',
                  height: 180.0,
                ),
                divider30(),
                Text(
                  "Iniciar Sesión",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                    color: kBrandPrimaryColor,
                  ),
                ),
                divider10(),
                TextFieldNormalWidget(
                  hintText: "Correo electrónico",
                  icon: Icons.email,
                  controller: _emailController,
                ),
                divider10(),
                divider6(),
                TextFieldPasswordWidget(
                  controller: _passwordController,
                ),
                divider20(),
                ButtonCustomWidget(
                  text: "Iniciar Sesión",
                  icon: "check",
                  color: kBrandPrimaryColor,
                  onPressed: () {
                    _login();
                  },
                ),
                divider20(),
                Text(
                  "O ingresa con tus redes sociales",
                ),
                divider20(),
                ButtonCustomWidget(
                  text: "Iniciar sesión con Google",
                  icon: "google",
                  color: Color(0xfff84b2a),
                  onPressed: () {
                    _loginWithGoogle();
                  },
                ),
                divider20(),
                ButtonCustomWidget(
                  text: "Iniciar sesión con Facebook",
                  icon: "facebook",
                  color: Color(0xff507CC0),
                  onPressed: () {
                    _loginWithFacebook();
                  },
                ),
                divider20(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Aún no estás registrado?",
                    ),
                    divider10Width(),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterPage()));
                      },
                      child: Text(
                        "Regístrate",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: kBrandPrimaryColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}