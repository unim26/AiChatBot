import 'dart:async';
import 'package:aichatbot/pages/home_page.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Timer(
      const Duration(seconds: 5),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenheight = MediaQuery.of(context).size.height;
    final screenwidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade400,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            //image
            Center(
              child: Container(
                padding: const EdgeInsets.all(2),
                width: screenwidth * .4,
                height: screenheight * .2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.grey.shade200,
                    width: 3,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    "assets/logo.jpeg",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),

            const Text(
              "AI CHAT BOT",
              style: TextStyle(
                fontSize: 25,
              ),
            ),

            //text
            const Spacer(),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Made with",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Image.asset(
                  "assets/heart.png",
                  width: 50,
                ),
                const Text(
                  "by Abhishek",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
