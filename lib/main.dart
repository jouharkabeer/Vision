import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:stacked_services/stacked_services.dart';

import 'app/app.locator.dart';
import 'app/app.router.dart';
import 'ui/setup_snackbar_ui.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setupLocator(); // stacked architecture
  setupSnackbarUi();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

  // cameras = await availableCameras();
  // for (int i = 0; i < cameras.length; i++) {
  //   print('AVAILABLE CAMERAS: $i  '
  //       'name: ${cameras[i].name}   '
  //       'lensDirection: ${cameras[i].lensDirection}   '
  //       'sensorOrientation: ${cameras[i].sensorOrientation}');
  // }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vision',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        primarySwatch: Colors.teal,
        // backgroundColor: kBackgroundColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      navigatorObservers: [StackedService.routeObserver],
      navigatorKey: StackedService.navigatorKey,
      onGenerateRoute: StackedRouter().onGenerateRoute,
    );
  }
}
