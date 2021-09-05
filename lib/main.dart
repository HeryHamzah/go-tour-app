import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:travel_tourguide_app/services/services.dart';
import 'package:travel_tourguide_app/ui/pages/pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: AuthServices.userStream,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Go Tour',
        theme: ThemeData(
            primarySwatch: Colors.blue, textTheme: GoogleFonts.latoTextTheme()),
        home: Wrapper(),
      ),
    );
  }
}
