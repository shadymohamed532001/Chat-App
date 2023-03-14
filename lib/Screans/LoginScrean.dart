import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholor_chat/Widget/CustomTextFormFiled.dart';
import 'package:scholor_chat/Widget/Custombottom.dart';
import 'package:scholor_chat/constans.dart';
import 'package:validators/validators.dart';

class LoginScrean extends StatefulWidget {
  const LoginScrean({Key? key}) : super(key: key);

  @override
  State<LoginScrean> createState() => _LoginScreanState();
}

class _LoginScreanState extends State<LoginScrean> {
  bool IsLodaing = false;
  bool IsShow = true;
  String? email;
  String? password;
  var IsEmailCorrect = false;
  var IsPasswordShow = true;
  TextEditingController emailController = TextEditingController() ;
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: IsLodaing,
      child: Scaffold(
        backgroundColor: KPrimaryColor,
        body: Form(
          key: key,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 75,
                    ),
                    Image.asset(
                      'assets/images/scholar.png',
                      height: 100,
                      width: double.infinity,
                    ),
                    const Text(
                      'Scholor Caht',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontFamily: 'Pacifico'),
                    ),
                    const SizedBox(
                      height: 65,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Text(
                          'Sigh in',
                          style: TextStyle(fontSize: 25, color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomTextFormFiled(
                      controller:  emailController ,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'email is empty';
                        }
                      },
                      onChanged: (data) {
                        email = data;
                        IsEmailCorrect = isEmail(email!);
                      },
                      obscureText: false,
                      SuffixIcon: const Icon(
                        Icons.email_outlined,
                        color: Colors.white,
                      ),
                      HintText: 'Test123@gmail.com',
                      type: TextInputType.emailAddress,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomTextFormFiled(
                      controller: passwordController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'password is empty';
                          } else if (value.length < 5)
                            return 'password is too short';
                        },
                        onChanged: (data) {
                          password = data;
                        },
                        obscureText: IsPasswordShow,
                        HintText: 'password',
                        type: TextInputType.visiblePassword,
                        SuffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              IsPasswordShow = !IsPasswordShow;
                            });
                          },
                          icon: IsPasswordShow
                              ? const Icon(Icons.visibility_off_sharp,
                                  color: Colors.white)
                              : const Icon(
                                  Icons.visibility,
                                  color: Colors.white,
                                ),
                        )),
                    const SizedBox(
                      height: 32,
                    ),
                    CustomBottom(
                        text: 'Sign in',
                        onTap: ()async {
                          if (key.currentState!.validate() && IsEmailCorrect) {
                            IsLodaing = true;
                            setState(() {});
                            try {
                              await LoginUsers();
                              Navigator.pushNamed(context, KChatScrean,arguments: email);
                              emailController.clear();
                              passwordController.clear();
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'user-not-found') {
                                ShowSnackBar(context, 'User not found');
                              } else if (e.code == 'wrong-password') {
                                ShowSnackBar(context, 'Wrong password provided for that user');
                              }
                            } catch (e) {
                              print(e);
                            }
                          }else if (IsEmailCorrect == false)
                          {
                            ShowSnackBar(context, 'Wrong email');
                          }
                          IsLodaing = false;
                          setState(() {
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'don\'t have acount ? ',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 13,
                          ),
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.white)),
                              onPressed: () {
                                Navigator.pushNamed(context, KRegisterScrean);
                              },
                              child: const Text(
                                'Register',
                                style: TextStyle(color: Color(0xff2B475E)),
                              )),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

 Future<void> LoginUsers() async {
     final User =  await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: email!, password: password!);
  }
  void ShowSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

}
