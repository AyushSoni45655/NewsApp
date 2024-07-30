import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'homepage.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 4),() {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const HomePage()));
    },);
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xffF1F5F7),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("asset/image/splash.jpg",fit: BoxFit.cover,width: size.width / .9,height: size.height *.5,),
            SizedBox(height: size.height * 0.04,),
            Text("TOP HEADLINES",style: TextStyle(
              letterSpacing: .6,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade700
            )),
            SizedBox(height: size.height * 0.04,),
            SpinKitChasingDots(
              color:  Colors.blue,
              size: 40,
            )

          ],
        ),
      ),
    );
  }
}
