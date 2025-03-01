import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:goyn/customwidgets.dart/country_codes.dart';
import 'package:goyn/provider/Driver_Registration_provider.dart';
import 'package:goyn/provider/DriverlistProvider.dart';
import 'package:goyn/provider/Dropdown_Provider.dart';
import 'package:goyn/provider/Login_Provider.dart';
import 'package:goyn/provider/Union_Provider.dart';
import 'package:provider/provider.dart';
import 'package:goyn/splash_screen.dart';

void main() {
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
        ChangeNotifierProvider(create: (context) => FilterProvider()),
        ChangeNotifierProvider(create: (_) => DriverlistProvider()),
        ChangeNotifierProvider(create: (_) => UnionProvider()),
        ChangeNotifierProvider(create: (_) => RegistrationProvider()),
        ChangeNotifierProvider(create: (_) => DropdownProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.amber,
          scaffoldBackgroundColor: Colors.white,
          fontFamily: GoogleFonts.openSans().fontFamily,
        ),
        home: const SplashScreen(),
        builder: (context, child) {
          // Prevent text from scaling with system font settings
          return MediaQuery(
            data: MediaQuery.of(
              context,
            ).copyWith(textScaler: TextScaler.linear(1.0)),
            child: child!,
          );
        },
      ),
    );
  }
}
