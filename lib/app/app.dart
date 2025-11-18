import 'package:e_commerce/app/routes.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../../l10n/app_localizations.dart';
import 'package:get/get.dart';
import '../features/auth/presentation/screens/splash_screen.dart';
import 'app_theme.dart';
import 'controller_binder.dart';
import 'controllers/language_controller.dart';


class CraftyBay extends StatefulWidget {
  const CraftyBay({super.key});

  static final LanguageController languageController = LanguageController();
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();


  @override
  State<CraftyBay> createState() => _CraftyBayState();
}

class _CraftyBayState extends State<CraftyBay> {
  //TODO routeObserver analytics
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(
    analytics: analytics,
  );


  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: CraftyBay.languageController,
      builder: (languageController) {
        return GetMaterialApp(
          navigatorKey: CraftyBay.navigatorKey,
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: languageController.supportedLocales,
          locale: languageController.currentLocale,
          navigatorObservers: [observer],

          theme: AppTheme.lightThemeData,
          darkTheme: AppTheme.darkThemeData,
          themeMode: ThemeMode.light,

          home: SplashScreen(),
          initialRoute: SplashScreen.name,
          onGenerateRoute: onGenerateRoute,

          initialBinding: ControllerBinding(),
        );
      }
    );
  }
}


