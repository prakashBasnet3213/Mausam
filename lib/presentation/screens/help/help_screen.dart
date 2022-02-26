import 'package:flutter/material.dart';
import 'package:mausam/common/constants/custom_popins_text.dart';
import 'package:mausam/presentation/screens/home/home_screen.dart';
import 'package:mausam/presentation/screens/widgets/custom_button.dart';

class HelpScreen extends StatefulWidget {
  final bool isSplash;
  const HelpScreen({
    Key? key,
    required this.isSplash,
  }) : super(key: key);

  @override
  HelpScreenState createState() => HelpScreenState();
}

class HelpScreenState extends State<HelpScreen> {
  @override
  void initState() {
    super.initState();
    if (widget.isSplash) {
      Future.delayed(const Duration(seconds: 5)).then(
        (value) => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
            (route) => false),
      );
    }
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: customPoppinsText(
                    content: "We show weather for you",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black.withOpacity(0.5),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.25),
              CustomButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
                    ),
                    (route) => false,
                  );
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
