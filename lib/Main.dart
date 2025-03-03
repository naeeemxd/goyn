import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:goyn/customwidgets.dart/country_codes.dart';
import 'package:goyn/provider/Driver_Registration_provider.dart';
import 'package:goyn/provider/DriverlistProvider.dart';
import 'package:goyn/provider/Dropdown_Provider.dart';
import 'package:goyn/provider/Login_Provider.dart';
import 'package:goyn/provider/ProfilePhoto_Provider.dart';
import 'package:goyn/provider/Union_Provider.dart';
import 'package:provider/provider.dart';
import 'package:goyn/splash_screen.dart';
import 'package:goyn/Union/Union_List.dart'; // Import your home page

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CountryCodeProvider(countryCodes: countryCodes),
        ),
        ChangeNotifierProvider(create: (_) => DriverlistProvider()),
        ChangeNotifierProvider(create: (_) => SearchProvider()),
        ChangeNotifierProvider(create: (_) => RegistrationProvider()),
        ChangeNotifierProvider(create: (_) => DropdownProvider()),
        ChangeNotifierProvider(create: (_) => UnionProvider()),
        ChangeNotifierProvider(create: (_) => ProfilePhotoProvider()),
      ],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.amber,
          scaffoldBackgroundColor: Colors.white,
          fontFamily: GoogleFonts.openSans().fontFamily,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          '/home': (context) => const GoynHomePageContent(),
          // Add other routes as needed
        },
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(
              context,
            ).copyWith(textScaler: TextScaler.noScaling),
            child: child!,
          );
        },
      ),
    );
  }
}
