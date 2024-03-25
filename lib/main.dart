import 'package:nattt_bazaar/my_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  //load .env files
  await dotenv.load(fileName: ".env");

  //run the app
  runApp(const ProviderScope(child: MyApp()));
}
