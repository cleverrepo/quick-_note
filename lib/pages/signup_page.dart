import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:quicknote/pages/widgets.dart';

import 'constants.dart';
import 'login_page.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}
TextEditingController userNameController=TextEditingController();
TextEditingController userEmailController=TextEditingController();
TextEditingController userPasswordController=TextEditingController();
final key=GlobalKey<FormState>();
class _RegisterState extends State<Register> {
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
                height: 430,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Form(
                    key: key,
                    child: Column(
                      children: [
                        customTextFormField(
                          lable: "UserName",
                          obsecure: true,
                          validator: (user) {
                            return null;
                          },
                        ),
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
                        InkWell(
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
                                "Register",
                              ),
                            ),
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              Get.to(()=> const Login(),transition: Transition.fadeIn,
                              duration: const Duration(milliseconds: 500));
                            },
                            child: const Text("Already have an Account?")),
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
