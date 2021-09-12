import 'dart:io';
import 'dart:ui';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
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

part 'sign_up_page.dart';
part 'splash_page.dart';
part 'sign_in_page.dart';
part 'wrapper.dart';
part 'user/home_page.dart';
part 'user/main_page.dart';
part 'user/activity_page.dart';
part 'user/drawer_page.dart';
part 'user/favorites_page.dart';
