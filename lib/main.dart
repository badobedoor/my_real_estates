import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_real_estates/screens/splash.dart';
import 'package:my_real_estates/wight/appWight&Theme/theme.dart';
import 'package:provider/provider.dart';

import 'Provider/main_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp()
      // DevicePreview(
      //   // enabled: !kReleaseMode,
      //   builder: (context) =>, // Wrap your app
      // ),
      );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  Future<void> puase() async {
    await Future<dynamic>.delayed(const Duration(seconds: 3));
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => MainProvider()),
        ],
        builder: (context, snapshot) {
          // return Consumer<MainProvider>(builder: (context, notifier, child) {
          return ScreenUtilInit(
            designSize: const Size(375, 812),
            builder: () => FutureBuilder(
                future: puase(),
                builder: (context, snapshot) {
                  // Show splash screen while waiting for app resources to load:
                  // if (snapshot.connectionState == ConnectionState.done) {
                  Provider.of<MainProvider>(context, listen: false)
                      .getFristTime();
                  Provider.of<MainProvider>(context, listen: false)
                      .getFristTimeprivacy();

                  return MaterialApp(
                    useInheritedMediaQuery: true,
                    // locale: DevicePreview.locale(context),
                    // builder: DevicePreview.appBuilder,
                    title: 'The Game Academy',
                    theme: AppTheme.light,
                    home: const Splash(),
                  );
                  // } else {
                  //   return MaterialApp(
                  //     useInheritedMediaQuery: true,
                  //     // locale: DevicePreview.locale(context),
                  //     // builder: DevicePreview.appBuilder,
                  //     title: 'The Game Academy',
                  //     theme: AppTheme.light,
                  //     home: const Splash(),
                  //   );
                  // }
                }),
          );
        }
        // );
        // }
        );
  }
}
