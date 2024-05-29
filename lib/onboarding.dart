import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tugas_akhir_tpm/login.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  bool isLastPage = false;

  Future<void> _completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('seenOnboarding', true);

    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => LoginPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;

          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<String> imgList = [
      'assets/OB1.jpg',
      'assets/OB2.jpg',
      'assets/OB3.jpg'
    ];

    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                isLastPage = index == imgList.length - 1;
              });
            },
            itemCount: imgList.length,
            itemBuilder: (context, index) => Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imgList[index]),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20.0,
            left: 20.0,
            right: 20.0,
            child: Column(
              children: [
                SmoothPageIndicator(
                  controller: _controller,
                  count: imgList.length,
                  effect: WormEffect(
                    dotColor: Colors.grey,
                    activeDotColor: Colors.orange,
                    dotHeight: 10.0,
                    dotWidth: 10.0,
                  ),
                ),
                SizedBox(height: 20.0),
                isLastPage
                    ? ElevatedButton(
                        onPressed: _completeOnboarding,
                        child: Text(
                          'Get Started',
                          style: GoogleFonts.poppins(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          minimumSize: Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: Color(0xFFFEAA45),
                        ),
                      )
                    : SizedBox(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
