import 'package:dini_maak/di/locator.dart';
import 'package:dini_maak/presentation/auth/login/login_page.dart';
import 'package:dini_maak/presentation/auth/provider/auth_provider.dart';
import 'package:dini_maak/presentation/auth/signup/signup_page.dart';
import 'package:dini_maak/presentation/bottomnav/navigation_page.dart';
import 'package:dini_maak/presentation/bottomnav/provider/bottom_navbar_provider.dart';
import 'package:dini_maak/presentation/cars/provider/car_provider.dart';
import 'package:dini_maak/presentation/home/provider/home_provider.dart';
import 'package:dini_maak/presentation/onboading/onboarding_page.dart';
import 'package:dini_maak/presentation/tipes/create_trip_page.dart';
import 'package:dini_maak/presentation/tipes/joined_trip_detals.dart';
import 'package:dini_maak/presentation/tipes/provider/trip_provider.dart';
import 'package:dini_maak/presentation/tipes/trip_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

String? accessToken;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDi();
  final pref = locator.get<SharedPreferences>();
  accessToken = pref.getString("token");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => BottomNavbarProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => HomeProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CarProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => TripProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Dini m3ak",
        theme: ThemeData(useMaterial3: true),
        initialRoute: accessToken == null
            ? OnBoardingPage.homePage
            : NavigationPage.navPage,
        onGenerateRoute: (settings) {
          if (settings.name == OnBoardingPage.homePage) {
            return MaterialPageRoute(
              builder: (_) => const OnBoardingPage(),
            );
          } else if (settings.name == LoginPage.logininPage) {
            return MaterialPageRoute(builder: (_) => const LoginPage());
          } else if (settings.name == SignupPage.signupPage) {
            return MaterialPageRoute(builder: (_) => const SignupPage());
          } else if (settings.name == NavigationPage.navPage) {
            return MaterialPageRoute(builder: (_) => const NavigationPage());
          } else if (settings.name == CreateTripPage.createTripRoute) {
            return MaterialPageRoute(builder: (_) => const CreateTripPage());
          } else if (settings.name == TripOwnerDetails.tripDetailsRoute) {
            return MaterialPageRoute(builder: (_) => const TripOwnerDetails());
          } else if (settings.name == JoinedTripDetails.joinedTripDetails) {
            return MaterialPageRoute(builder: (_) => const JoinedTripDetails());
          }
        },
        home: const OnBoardingPage(),
      ),
    );
  }
}
