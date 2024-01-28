import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:quicknote/pages/home.dart';
import 'package:quicknote/pages/login_page.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

bool isAnimated = false;

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            "Assets/Animation - 1704830714517.json",
          ),
          const Text(
            "Save your note now and access it anytime",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          const Gap(15),
          GestureDetector(
            onTap: () {
              Get.to(() => const Login(),
                  transition: Transition.fadeIn,
                  duration: const Duration(milliseconds: 1000));
            },
            child: AnimatedContainer(
                height: 55,
                width: 120,
                decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(30)),
                duration: const Duration(microseconds: 500),
                child: const Center(
                    child: Text(
                  "Get Started",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ))),
          )
        ],
      ),
    );
  }
}
