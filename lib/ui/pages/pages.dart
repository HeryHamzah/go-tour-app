import 'dart:io';
import 'dart:async';

import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:random_string/random_string.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_tourguide_app/bloc/blocs.dart';
import 'package:travel_tourguide_app/services/services.dart';
import 'package:travel_tourguide_app/shared/shared.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_tourguide_app/models/models.dart';
import 'package:get/get.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:travel_tourguide_app/ui/widgets/widgets.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:path/path.dart' as path;
import 'package:ticketview/ticketview.dart';
import 'package:travel_tourguide_app/extensions/extensions.dart';
import 'package:qr_flutter/qr_flutter.dart';

part 'user/sign_up_page.dart';
part 'splash_page.dart';
part 'user/sign_in_page.dart';
part 'wrapper.dart';
part 'user/home_page.dart';
part 'user/main_page.dart';
part 'user/activity_page.dart';
part 'user/drawer_page.dart';
part 'user/favorites_page.dart';
part 'user/profile_page.dart';
part 'user/destinations_page.dart';
part 'user/destination_detail.dart';
part 'user/tourguide_page.dart';
part 'user/booking_page.dart';
part 'user/my_wallet_page.dart';
part 'user/topup_page.dart';
part 'user/topup_succes_page.dart';
part 'user/succes_booking_page.dart';
part 'user/ticket_detail_page.dart';
part 'user/tourguide_detail_page.dart';
part 'user/tourguide_booking_page.dart';
part 'user/succes_tourguide_reservation.dart';
part 'user/search_destination_page.dart';
part 'user/tourguide_ticket_detail.dart';
part 'user/review_page.dart';
part 'user/app_guide_page.dart';
part 'user/map_screen.dart';
part 'user/reset_password_page.dart';
part 'tour_guide/tourguide_home_page.dart';
part 'tour_guide/tourguide_sign_in_page.dart';
part 'tour_guide/tourguide_profile_page.dart';
part 'tour_guide/tourguide_change_password.dart';
part 'tour_guide/trip_history_page.dart';
part 'tour_guide/history_detail.dart';
part 'tour_guide/terms_conditions_page.dart';
