// ignore_for_file: deprecated_member_use

import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:katon/languages/language_translation.dart';
import 'package:katon/screens/library_page/book_detail/book_details_provider.dart';
import 'package:katon/screens/library_page/controller/cnt_prv.dart';
import 'package:katon/screens/live_class/controller/live_class_prv.dart';
import 'package:katon/screens/past_paper/controller/past_paper_prv.dart';
import 'package:katon/screens/practice/assignment/controller/assignment_controller.dart';
import 'package:katon/screens/practice/controller/practice_prv.dart';
import 'package:katon/screens/practice/practice_details/controller/mcq_test_prv.dart';
import 'package:katon/screens/self_assessment/self_assesment_controller.dart';
import 'package:katon/screens/training/controller/training_prv.dart';
import 'package:katon/utils/app_binding.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/utils/global_singlton.dart';
import 'package:katon/widgets/custom_dialog.dart';
import 'package:provider/provider.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_crashlytics/firebase_crashlytics.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await AppPreference().initialAppPreference();
  await AppPreference().setString('pdfId', '');
  await AppPreference().setString('videoId', '');
  await AppPreference().setString('epubId', '');
  // WidgetsFlutterBinding.ensureInitialized();
  await GlobalSingleton().getApppath();
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge, overlays: []);

  // await Firebase.initializeApp();

  // // Pass all uncaught "fatal" errors from the framework to Crashlytics
  // FlutterError.onError = (errorDetails) {
  //   FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  // };
  // // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  // PlatformDispatcher.instance.onError = (error, stack) {
  //   FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
  //   return true;
  // };
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<void> checkForUpdate() async {
    InAppUpdate.checkForUpdate().then((info) {
      AppUpdateInfo updateInfo = info;
      if (updateInfo.updateAvailability == UpdateAvailability.updateAvailable) {
        if (updateInfo.immediateUpdateAllowed) {
          // Perform immediate update
          InAppUpdate.performImmediateUpdate().then((appUpdateResult) {
            if (appUpdateResult == AppUpdateResult.success) {
              print(" immediateUpdateAllowed App Update successful");
            }
          });
        } else if (updateInfo.flexibleUpdateAllowed) {
          print("Perform flexible update");
          InAppUpdate.startFlexibleUpdate().then((appUpdateResult) {
            if (appUpdateResult == AppUpdateResult.success) {
              print(" flexibleUpdateAllowed App Update successful");
              InAppUpdate.completeFlexibleUpdate();
            }
          });
        }
      }
    }).catchError((e) {
      log("catchError $e");
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // log("size0-------${MediaQuery.of(context).size.width}");

      // SystemChrome.setPreferredOrientations(
      //   MediaQueryData.fromView(WidgetsBinding.instance.window)
      //               .size
      //               .shortestSide <
      //           600
      //       ?
      //       [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]
      //       :
      //       [
      //           DeviceOrientation.landscapeRight,
      //           DeviceOrientation.landscapeLeft
      //         ],
      // );
      if (Device.get().isTablet) {
        log("tablet--------");
        await SystemChrome.setPreferredOrientations(
          [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight],
        ).whenComplete(() => AppPreference().setBool("isPortrait", false));
      } else if (Device.get().isPhone) {
        log("phone--------");
        await SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
        ).whenComplete(() => AppPreference().setBool("isPortrait", true));
      }
    });
    checkForUpdate();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ELearningProvider>(
            create: (context) => ELearningProvider()),
        ChangeNotifierProvider<BookDetailProvider>(
            create: (context) => BookDetailProvider()),
        ChangeNotifierProvider<LiveClassProvider>(
            create: (context) => LiveClassProvider()),
        ChangeNotifierProvider<PracticePrv>(create: (context) => PracticePrv()),
        ChangeNotifierProvider<McqTestPrv>(create: (context) => McqTestPrv()),
        ChangeNotifierProvider<PastPaperProvider>(
            create: (context) => PastPaperProvider()),
        ChangeNotifierProvider<TrainingProvider>(
            create: (context) => TrainingProvider()),
        ChangeNotifierProvider<AssignmentController>(
            create: (context) => AssignmentController()),
        ChangeNotifierProvider<SelfAssessmentController>(
            create: (context) => SelfAssessmentController()),
      ],
      builder: (context, child) {
        return ScreenUtilInit(
          designSize: const Size(1280, 800),
          minTextAdapt: true,
          splitScreenMode: true,
          useInheritedMediaQuery: true,
          builder: (BuildContext context, Widget? child) => GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'KATON',
            navigatorKey: navigatorKey,
            theme: AppTheme.theme,
            useInheritedMediaQuery: true,
            locale: AppPreference().getString(PreferencesKey.language).isEmpty
                ? Locale("en")
                : Locale(AppPreference().getString(PreferencesKey.language)),
            translations: LanguageTranslation(),
            routes: Routes.routes,
            initialRoute: RoutesConst.splash,
            //initialRoute: AppPreference().initRoute,
            initialBinding: AppBidding(),
          ),
        );
      },
    );
  }
}
