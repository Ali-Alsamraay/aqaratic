import 'package:aqaratak/providers/Auth_Provider.dart';
import 'package:aqaratak/providers/Maps_Places_Provider.dart';
import 'package:aqaratak/providers/Properties_provider.dart';
import 'package:aqaratak/providers/State_Manager_Provider.dart';
import 'package:aqaratak/providers/services_provider.dart';
import 'package:aqaratak/screens/Register_screen.dart';
import 'package:aqaratak/screens/creating_property_screen.dart';
import 'package:aqaratak/screens/home_screen.dart';
import 'package:aqaratak/screens/login_screen.dart';
import 'package:aqaratak/screens/main_screen.dart';
import 'package:aqaratak/screens/onBoarding_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  final bool? isLogged = await AuthProvider().isCurrentUserLoggedIn();
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
        create: (_) => MapsPlacesProvider(),
      ),
    ],
    child: MyApp(
      isLogged: isLogged!,
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
        },
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Cairo',
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 0.0,
          ),
        ),
        home: BoardingScreen(),
      ),
    );
  }
}
