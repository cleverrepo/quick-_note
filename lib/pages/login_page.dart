import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quicknote/pages/signup_page.dart';
import 'package:quicknote/pages/widgets.dart';

import 'constants.dart';
import 'home.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
final globalKey = GlobalKey<FormState>();

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Image.asset(
                  "Assets/background.png",
                  width: double.infinity,
                  fit: BoxFit.cover,
                  height: double.infinity,
                )),
            Center(
              child: Container(
                width: 330,
                decoration: const BoxDecoration(color: shadowColor, boxShadow: [
                  BoxShadow(
                    blurRadius: 1,
                    spreadRadius: 1,
                    color: shadowColor,
                  )
                ]),
                height: 370,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Form(
                    key: globalKey,
                    child: Column(
                      children: [
                        customTextFormField(
                          lable: "Email",
                          obsecure: true,
                          validator: (mail) {
                            return null;
                          },
                        ),
                        customTextFormField(
                          lable: "password",
                          obsecure: true,
                          validator: (pass) {
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TextButton(
                                onPressed: () {},
                                child: const Text("forgot password?")),
                            InkWell(
                              onTap: (){
                                Get.to(()=> const Home(),transition: Transition.fadeIn,
                                  duration: const Duration(milliseconds: 500),
                                );
                              },
                              child: Container(
                                height: 50,
                                width: 70,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: shadowColor,
                                    boxShadow: [
                                      const BoxShadow(
                                          blurRadius: 5,
                                          offset: Offset(2, 2),
                                          color: containerPrimaryColor,
                                          spreadRadius: 1),
                                      BoxShadow(
                                          blurRadius: 1,
                                          offset: const Offset(-2, -2),
                                          color: Colors.grey.shade900,
                                          spreadRadius: 1)
                                    ]),
                                child: const Center(
                                  child: Text(
                                    "Login",
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        TextButton(
                            onPressed: () {
                              Get.to(()=> const Register(),transition: Transition.fadeIn,
                              duration: const Duration(milliseconds: 500),
                              );
                            },
                            child: const Text("Don't have an Account?")),
                        const Row(
                          children: [
                            Expanded(
                              child: Divider(),
                            ),
                            Text("Or"),
                            Expanded(
                              child: Divider(),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: shadowColor,
                                      boxShadow: [
                                        const BoxShadow(
                                            blurRadius: 5,
                                            offset: Offset(2, 2),
                                            color: containerPrimaryColor,
                                            spreadRadius: 1),
                                        BoxShadow(
                                            blurRadius: 1,
                                            offset: const Offset(-2, -2),
                                            color: Colors.grey.shade900,
                                            spreadRadius: 1)
                                      ]),
                                  child: Image.asset("Assets/google.png")),
                            ),
                            InkWell(
                              child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: shadowColor,
                                      boxShadow: [
                                        const BoxShadow(
                                            blurRadius: 5,
                                            offset: Offset(2, 2),
                                            color: containerPrimaryColor,
                                            spreadRadius: 1),
                                        BoxShadow(
                                            blurRadius: 1,
                                            offset: const Offset(-2, -2),
                                            color: Colors.grey.shade900,
                                            spreadRadius: 1)
                                      ]),
                                  child:
                                      Image.asset("Assets/facebook.png")),
                            ),
                            InkWell(
                              child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: shadowColor,
                                      boxShadow: [
                                        const BoxShadow(
                                            blurRadius: 5,
                                            offset: Offset(2, 2),
                                            color: containerPrimaryColor,
                                            spreadRadius: 1),
                                        BoxShadow(
                                            blurRadius: 1,
                                            offset: const Offset(-2, -2),
                                            color: Colors.grey.shade900,
                                            spreadRadius: 1)
                                      ]),
                                  child:
                                      Image.asset("Assets/twitter.png")),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
