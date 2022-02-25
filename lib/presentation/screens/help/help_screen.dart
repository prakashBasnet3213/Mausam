import 'package:flutter/material.dart';
import 'package:mausam/common/constants/custom_popins_text.dart';
import 'package:mausam/presentation/screens/home/home_screen.dart';
import 'package:mausam/presentation/screens/widgets/custom_button.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  HelpScreenState createState() => HelpScreenState();
}

class HelpScreenState extends State<HelpScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5)).then(
      (value) => Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
          (route) => false),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/frame.png"),
            ),
          ),
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              customPoppinsText(
                content: "We show weather for you",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black.withOpacity(0.5),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              customPoppinsText(
                content: "Come on, Let's have it!!",
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.black.withOpacity(0.4),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.3),
              CustomButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                      (route) => false);
                },
                text: "Skip",
              )
            ],
          ),
        ),
      ),
    );
  }
}
