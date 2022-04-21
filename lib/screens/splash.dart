import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_real_estates/wight/appWight&Theme/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../wight/tab_bar.dart';
import 'help.dart';
import 'home.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  // bool _checkConfiguration() => true;
  var fristTime = true;
  Future<void> getSharedPrefs() async {
    await Future<dynamic>.delayed(const Duration(seconds: 3));
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool? res = prefs.getBool('fristTime');

    setState(() {
      if (res != null) {
        fristTime = res;
      } else {
        fristTime = true;
      }

      fristTime == true
          ? SchedulerBinding.instance!.addPostFrameCallback((_) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute<dynamic>(
                      builder: (context) => const HelpPage()));
            })
          : SchedulerBinding.instance!.addPostFrameCallback((_) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute<dynamic>(builder: (context) => Home()));
            });
    });
  }

  @override
  void initState() {
    super.initState();
    getSharedPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Container(
        alignment: Alignment.center,
        child: SizedBox(
          width: 215.w,
          height: 130.h,
          child: Image.asset(
            'assets/images/logo.png',
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}

// class MyClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     var path = new Path();

//     path.lineTo(0, size.height - 80);
//     path.quadraticBezierTo(
//       size.width / 2,
//       size.height,
//       size.width,
//       size.height - 80,
//     );

//     path.lineTo(size.width, 0);
//     path.close();

//     return path;
//   }

//   @override
//   bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
// }
