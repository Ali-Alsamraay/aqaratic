import 'package:aqaratak/providers/Auth_Provider.dart';
import 'package:aqaratak/providers/Blogs_provider.dart';
import 'package:aqaratak/providers/Maps_Provider.dart';
import 'package:aqaratak/providers/Properties_provider.dart';
import 'package:aqaratak/providers/State_Manager_Provider.dart';
import 'package:aqaratak/providers/favorite_provider.dart';
import 'package:aqaratak/providers/main_provider.dart';
import 'package:aqaratak/providers/services_provider.dart';
import 'package:aqaratak/screens/Register_screen.dart';
import 'package:aqaratak/screens/blogs_screen.dart';
import 'package:aqaratak/screens/creating_property_screen.dart';
import 'package:aqaratak/screens/home_screen.dart';
import 'package:aqaratak/screens/login_screen.dart';
import 'package:aqaratak/screens/main_screen.dart';
import 'package:aqaratak/screens/my_orders_screen.dart';
import 'package:aqaratak/screens/onBoarding_screen.dart';
import 'package:aqaratak/screens/update_user_profile_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';

import 'providers/filtration_provider.dart';

Future<void> main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
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
      ChangeNotifierProvider(
        create: (_) => AuthProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => StateManagerProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => MapsProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => FavoritesProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => MainProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => FiltrationProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => BlogsProvider(),
      ),
    ],
    child: MyApp(
      showBoardingScreens: sharedPreferences.getBool("show-boarding") == null
          ? true
          : sharedPreferences.getBool("show-boarding")!,
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.showBoardingScreens,
  }) : super(key: key);

  final bool showBoardingScreens;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Sizer(
      builder: (context, orientation, deviceType) => MaterialApp(
        routes: {
          MainScreen.screenName: (context) => MainScreen(),
          HomeScreen.screenName: (context) => HomeScreen(),
          CreatingPropertyScreen.screenName: (context) =>
              CreatingPropertyScreen(),
          LoginScreen.screenName: (context) => LoginScreen(),
          RegisterScreen.screenName: (context) => RegisterScreen(),
          UpdateUserProfileScreen.screenName: (context) =>
              UpdateUserProfileScreen(),
          BlogsScreen.screenName: (context) => BlogsScreen(),
          MyOrdersScreen.screenName: (context) => MyOrdersScreen(),
        },
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Cairo',
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 0.0,
          ),
        ),
        home: showBoardingScreens ? BoardingScreen() : MainScreen(),
      ),
    );
  }
}
