import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_tourguide_app/models/models.dart';
import 'package:travel_tourguide_app/extensions/extensions.dart';
import 'package:travel_tourguide_app/shared/shared.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import 'package:path/path.dart' as path;
import 'package:cloud_firestore/cloud_firestore.dart';

part 'auth_services.dart';
part 'user_services.dart';
part 'general_services.dart';
part 'tourguide_services.dart';
