import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:travel_tourguide_app/bloc/blocs.dart';
import 'package:travel_tourguide_app/services/services.dart';
import 'package:travel_tourguide_app/shared/shared.dart';
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
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => UserBloc()),
          BlocProvider(create: (_) => NavdrawerBloc()),
          BlocProvider(create: (_) => TicketBloc()),
          BlocProvider(create: (_) => TourguideTicketBloc())
        ],
        child: GetMaterialApp(
          initialRoute: '/',
          getPages: [
            GetPage(name: '/', page: () => Wrapper()),
            GetPage(name: '/splash', page: () => SplashPage()),
            GetPage(name: '/signIn', page: () => SignInPage()),
            GetPage(name: '/signUp', page: () => SignUpPage()),
            GetPage(
              name: '/home',
              page: () => MainPage(
                bottomNavBarIndex: 0,
              ),
            ),
            GetPage(
              name: '/activity',
              page: () => MainPage(bottomNavBarIndex: 1),
            ),
            GetPage(name: '/destinations', page: () => DestinationsPage()),
            GetPage(
                name: '/destinationDetail',
                page: () => DestinationDetailPage()),
            GetPage(name: '/bookingPage', page: () => BookingPage()),
            GetPage(name: '/topUpPage', page: () => TopUpPage()),
            GetPage(name: '/topUpSuccesPage', page: () => SuccesTopUpPage()),
            GetPage(name: '/myWalletPage', page: () => MyWalletPage()),
            GetPage(
                name: '/succesBookingPage', page: () => SuccesBookingPage()),
            GetPage(name: '/ticketDetailPage', page: () => TicketDetailPage()),
            GetPage(
                name: '/tourGuideDetailPage',
                page: () => TourGuideDetailPage()),
            GetPage(
                name: '/tourGuideBookingPage',
                page: () => TourGuideBookingPage()),
            GetPage(
                name: '/successTourGuideReservation',
                page: () => SuccesTourGuideReservation())
          ],
          debugShowCheckedModeBanner: false,
          title: 'Go Tour',
          theme: ThemeData(
              primarySwatch: materialMainColor,
              textTheme: GoogleFonts.latoTextTheme()),
          // home: MainDrawer(),
        ),
      ),
    );
  }
}
