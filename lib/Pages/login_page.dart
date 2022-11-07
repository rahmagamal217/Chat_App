import 'package:chat_app/Pages/register_page.dart';
import 'package:chat_app/Widgets/custom_button.dart';
import 'package:chat_app/Widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../helper/show_snack_bar.dart';
import 'chat_page.dart';
//import 'com.facebook.FacebookSdk';
//import 'com.facebook.appevents.AppEventsLogger';


// ignore: must_be_immutable
class LoginPage extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  LoginPage({Key? key}) : super(key: key);
  static String id = 'LoginPage';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;

  String? email;

  String? password;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
          backgroundColor: kPrimaryColor,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Form(
              key: formKey,
              child: ListView(
                children: [
                  const SizedBox(
                    height: 75,
                  ),
                  Image.asset(
                    'assets/scholar.png',
                    height: 100,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Scholar Chat',
                        style: TextStyle(
                          fontSize: 32,
                          color: Colors.white,
                          fontFamily: 'pacifico',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 75,
                  ),
                  Row(
                    children: const [
                      Text(
                        'LOGIN',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomFormTextField(
                    onChanged: (data) {
                      email = data;
                    },
                    hintText: 'Email',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomFormTextField(
                    obscuretext: true,
                    onChanged: (data) {
                      password = data;
                    },
                    hintText: 'Password',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        isLoading = true;
                        setState(() {});
                        try {
                          await loginUser();
                          Navigator.pushNamed(
                            context,
                            ChatPage.id,
                            arguments: email
                          );
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            showSnackBar(context, 'User not found');
                          } else if (e.code == 'wrong-password') {
                            showSnackBar(context, 'Wrong password');
                          }
                        } catch (e) {
                          showSnackBar(context, 'There\'s an error');
                        }
                        isLoading = false;
                        setState(() {});
                      }
                    },
                    text: 'Login',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'don\'t have an account: ',
                        style: TextStyle(color: Colors.white),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, RegisterPage.id);
                        },
                        child: const Text(
                          'Register',
                          style: TextStyle(
                            color: Color(0xffC7EDE6),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }

  Future<void> loginUser() async {
    var auth = FirebaseAuth.instance;
    // ignore: unused_local_variable
    UserCredential user = await auth.signInWithEmailAndPassword(
        email: email!, password: password!);
  }
}
