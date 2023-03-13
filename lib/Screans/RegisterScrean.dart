import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholor_chat/Widget/Custombottom.dart';
import 'package:validators/validators.dart';

import '../Widget/CustomTextFormFiled.dart';
import '../constans.dart';

class RegisterScrean extends StatefulWidget {
  const RegisterScrean({Key? key}) : super(key: key);

  @override
  State<RegisterScrean> createState() => _RegisterScreanState();
}

class _RegisterScreanState extends State<RegisterScrean> {
  TextEditingController FirstController = TextEditingController();
  TextEditingController LastController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController comfirmController = TextEditingController();
  TextEditingController phoneController = TextEditingController();


  bool IsLoading = false;
  bool IsPasswordShow = true;
  bool IsComFirmPasswordShow = true;
   bool IsEmailCorrect = false;
  String? email;
  String? password;
  String? Comfirmpassword;

  final GlobalKey<FormState> key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: IsLoading,
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
                      height: 50,
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
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Text(
                          'Register',
                          style: TextStyle(fontSize: 26, color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ListTile(
                            title: const Padding(
                              padding: const EdgeInsets.all(5),
                              child: Text(
                                'First Name',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                            subtitle: CustomTextFormFiled(
                              onChanged: (value) {
                                FirstName = value;
                              },
                              obscureText: false,
                              HintText: 'First Name',
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            title: const Padding(
                              padding: const EdgeInsets.all(5),
                              child: Text(
                                'Last Name',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                            subtitle: CustomTextFormFiled(
                              onChanged: (value) {
                                LastName = value;
                              },
                              obscureText: false,
                              HintText: 'Last Name',
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextFormFiled(
                      onChanged: (data)  {
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
                      height: 10,
                    ),
                    CustomTextFormFiled(
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
                      height: 10,
                    ),
                    CustomTextFormFiled(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'password is empty';
                          } else if (value.length < 5)
                            return 'password is too short';
                        },
                        onChanged: (data) {
                          Comfirmpassword = data;
                        },
                        obscureText: IsComFirmPasswordShow,
                        HintText: 'Comfirm password',
                        SuffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              IsComFirmPasswordShow = !IsComFirmPasswordShow;
                            });
                          },
                          icon: IsComFirmPasswordShow
                              ? const Icon(Icons.visibility_off_sharp,
                                  color: Colors.white)
                              : const Icon(
                                  Icons.visibility,
                                  color: Colors.white,
                                ),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextFormFiled(
                      validator: (value)
                      {
                        if (value!.isEmpty) {
                          return 'phone is empty';
                        } else if (value.length < 11)
                          return 'phone is not complite';
                      },
                      type: TextInputType.phone,
                      obscureText: false,
                      HintText: 'Phone number',
                      SuffixIcon: const Icon(
                        Icons.phone_outlined,
                        color: Colors.white,
                      ),
                      onChanged: (value) {
                        Phone = value;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomBottom(
                      onTap: () async {
                        if (key.currentState!.validate() &&
                            Comfirmpassword == password&&
                            IsEmailCorrect) {
                          IsLoading= true ;
                          setState(() {});
                          try {
                            await RegisterUser();
                            Navigator.pushNamed(context, KChatScrean);
                            FirstController.clear();
                            LastController.clear();
                            emailController.clear();
                            passwordController.clear();
                            comfirmController.clear();
                            phoneController.clear();
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'weak-password') {
                              ShowSnackBar(context, 'weak password');
                            } else if (e.code == 'email-already-in-use') {
                              ShowSnackBar(context, 'email already is used');
                            }
                          } catch (e) {
                            print(e);
                          }
                        }else if (IsEmailCorrect == false)
                          {
                            ShowSnackBar(context, 'Email is not correct');
                          }else if ( Comfirmpassword != password)
                            {
                              ShowSnackBar(context, 'Password is not match');
                            }
                        IsLoading= false;
                        setState(() {});
                      },
                      text: 'Register',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'if you have acount ? ',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 12
                          ),
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.white)),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Sigh in',
                              style: TextStyle(
                                color: Color(0xff2B475E)
                              ),
                            ),
                          ),
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

  void ShowSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> RegisterUser() async {
    final User = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }
}
