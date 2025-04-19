import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  // Remove # from Web Url
  setPathUrlStrategy();

  // initialize Firebase For This Project
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // initialize Firebase For Firebase Storage
  await Firebase.initializeApp(
    name: 'StorageBucket',
    options: const FirebaseOptions(
      apiKey: 'AIzaSyC0OcUuVYia8pBe3jYfwAnWgJ2wqQvdzVE',
      appId: '1:263376026617:android:faafe508435e3ac8fa1b28',
      messagingSenderId: 'spotify-010',
      projectId: 'spotify-010',
      storageBucket: 'spotify-010.appspot.com',
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
