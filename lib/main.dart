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
          BlocProvider(create: (_) => TourguideTicketBloc()),
          BlocProvider(create: (_) => TourGuideBloc())
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
                page: () => SuccesTourGuideReservation()),
            GetPage(
                name: '/tourGuideTicketDetailPage',
                page: () => TourGuideTicketDetailPage()),
            GetPage(name: '/reviewPage', page: () => ReviewPage()),
            GetPage(
                name: '/resetPasswordPage', page: () => ResetPasswordPage()),
            GetPage(name: '/mapScreenPage', page: () => MapScreen()),
            GetPage(
                name: '/tourGuideSignIn', page: () => TourGuideSignInPage()),
            GetPage(name: '/tourGuideHome', page: () => TourGuideHomePage()),
            GetPage(
                name: '/tourGuideProfile', page: () => TourGuideProfilePage()),
            GetPage(
                name: '/tourGuideChangePassword',
                page: () => TourGuideChangepassword()),
            GetPage(name: '/tripHistory', page: () => TripHistoryPage()),
            GetPage(name: '/historyDetail', page: () => HistoryDetailPage()),
            GetPage(name: '/termsConditions', page: () => TermsConditionsPage())
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
