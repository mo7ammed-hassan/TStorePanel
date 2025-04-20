import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:t_store_admin_panel/app.dart';
import 'package:t_store_admin_panel/bloc_observier.dart';
import 'package:t_store_admin_panel/config/service_locator/service_locator.dart';
import 'package:t_store_admin_panel/data/services/authentication/authentaication_local_data_source.dart';
import 'package:t_store_admin_panel/data/services/user/user_manager.dart';
import 'package:t_store_admin_panel/firebase_options.dart';
import 'package:url_strategy/url_strategy.dart';

void main() async {
  // Ensure that widgets are initialized before running the app
  WidgetsFlutterBinding.ensureInitialized();

  // Load Environment Variables
  await dotenv.load();

  // Remove # from Web Url
  setPathUrlStrategy();

  // initialize Firebase For This Project
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // initialize Firebase For Firebase Storage
  await Firebase.initializeApp(
    name: 'StorageBucket',
    options: FirebaseOptions(
      apiKey: dotenv.get('STORAGE_kEY'),
      appId: dotenv.get('STORAGE_APP_ID'),
      messagingSenderId: dotenv.get('STORAGE_MESSAGING_SENDER_ID'),
      projectId: dotenv.get('STORAGE_PROJECT_ID'),
      storageBucket: dotenv.get('STORAGE_BUCKET'),
    ),
  );

  // Setup Service Locator
  setupServiceLocator();

  // Initialize User Manager
  await getIt<UserManager>().onReady();

  // Check If User Is Aleady Logged In
  await AuthLocalDataSource.isLoggedIn();

  // Bloc Observers
  Bloc.observer = MyBlocObserver();

  // Initialize Hive
  await Hive.initFlutter();

  // Main App Start
  runApp(const MyApp());
}
