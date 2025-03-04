import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:goyn/customwidgets.dart/country_codes.dart';
import 'package:goyn/provider/DriverlistProvider.dart';
import 'package:goyn/provider/Dropdown_Provider.dart';
import 'package:goyn/provider/ImageProvider.dart';
import 'package:goyn/provider/Login_Provider.dart';
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
        ChangeNotifierProvider(create: (_) => DropdownProvider()),
        ChangeNotifierProvider(create: (_) => UnionProvider()),
        ChangeNotifierProvider(create: (_) => ProfilePhotoProvider()),
        ChangeNotifierProvider(create: (_) => AdharProvider()),
        ChangeNotifierProvider(create: (_) => PanProvider()),
        ChangeNotifierProvider(create: (_) => BankProvider()),
        ChangeNotifierProvider(create: (_) => PoliceProvider()),
        ChangeNotifierProvider(create: (_) => RegistrationnProvider()),
        ChangeNotifierProvider(create: (_) => InsuranceProvider()),
        ChangeNotifierProvider(create: (_) => FitnessProvider()),
        ChangeNotifierProvider(create: (_) => VehicleProvider()),
        // ChangeNotifierProvider(create: (_) => PermitProvider()),

        // ChangeNotifierProvider(create: (_) => OtpVerificationProvider(otp: otp, phoneNumber: phoneNumber)),
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
