import 'dart:async';

import 'package:deceasefinder/main.dart';
import 'package:flutter/material.dart';

import 'home.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isVisible = false;

  _SplashScreenState(){

    Timer(const Duration(milliseconds: 2000), (){
      setState(() {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const Home()), (route) => false);
      });
    });

     Timer(
        const Duration(milliseconds: 10),(){
      setState(() {
        _isVisible = true; // Now it is showing fade effect and navigating to Home page
      });
    }
    );

  }

  @override
  Widget build(BuildContext context) {

    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AnimatedOpacity(
            opacity: _isVisible ? 1.0 : 0,
            duration: const Duration(milliseconds: 1200),
            child: Center(
              child: Center(
                child: Image.asset('assets/icon.png',scale: 1.5,),
              ),
            ),
          ),
          const Card(
            child: Text("DermAssist",
              style: TextStyle(
                  color: MyApp.primaryColor,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),),
          )
        ],
      ),
    );
  }
}