import 'package:aqaratak/providers/Properties_provider.dart';
import 'package:aqaratak/providers/services_provider.dart';
import 'package:aqaratak/screens/add_unit_screen.dart';
import 'package:aqaratak/screens/contact_screen.dart';
import 'package:aqaratak/screens/home_screen.dart';
import 'package:aqaratak/screens/intro_screen.dart';
import 'package:aqaratak/screens/main_screen.dart';
import 'package:aqaratak/screens/map_screen.dart';
import 'package:aqaratak/screens/onBoarding_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLogged = prefs.getString('token') != null;
  if (defaultTargetPlatform == TargetPlatform.android) {
    AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
  }
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => PropertiesProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => ServicesProvider(),
      ),
    ],
    child: MyApp(
      isLogged: isLogged,
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.isLogged,
  }) : super(key: key);

  final bool isLogged;

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) => MaterialApp(
        routes: {
          MainScreen.screenName: (context) => MainScreen(),
        },
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Cairo',
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 0.0,
          ),
        ),
        // builder: (context, widget) => ResponsiveWrapper.builder(
        //     BouncingScrollWrapper.builder(context, widget!),
        //     maxWidth: 1200,
        //     minWidth: 450,
        //     defaultScale: true,
        //     breakpoints: [
        //       const ResponsiveBreakpoint.resize(450, name: MOBILE),
        //       const ResponsiveBreakpoint.autoScale(800, name: TABLET),
        //       const ResponsiveBreakpoint.autoScale(1000, name: TABLET),
        //       const ResponsiveBreakpoint.autoScale(1200, name: DESKTOP),
        //       const ResponsiveBreakpoint.autoScale(2460, name: "4K"),
        //     ],
        //     background: Container(color: const Color(0xff0c2757))),
        home: isLogged ? MainScreen() : BoardingScreen(),
      ),
    );
  }
}
