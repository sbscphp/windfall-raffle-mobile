import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/router.dart' as router;
import 'package:windfall/ui/pages/bottom_nav.dart';
import 'package:windfall/ui/pages/landing.dart';
import 'core/constants/app_config.dart';
import 'core/constants/app_theme/app_theme.dart';
import 'core/constants/named_routes.dart';
import 'core/data/enum/environment.dart';
import 'core/data/services/geolocator_service.dart';
import 'core/data/services/navigation_service.dart';
import 'core/data/view_models/theme_selection_view_model.dart';
import 'core/data/view_models/utility_view_models/config_view_model.dart';
import 'core/data/view_models/utility_view_models/lga_details_view_model.dart';
import 'core/utilities/firebase_messaging_utils.dart';
import 'core/utilities/secure_storage/secure_storage_init.dart';
import 'locator.dart';


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (message.notification != null) {

  }
}


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
 await Firebase.initializeApp();
  await dotenv.load(fileName: ".env");
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  // if(Platform.isAndroid){
  //   await Firebase.initializeApp(
  //       options: FirebaseOptions(
  //         apiKey: '${dotenv.env['API_KEY']}',
  //         appId: '${dotenv.env['APP_ID']}',
  //         messagingSenderId: '${dotenv.env['MESSAGING_SENDER_ID']}',
  //         projectId: '${dotenv.env['PROJECT_ID']}',
  //       )
  //   );
  // }else{
  //   await Firebase.initializeApp();
  // }
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  AppConfig.setEnvironment(Environment.staging);
  SecureStorageInit.initSecureStorage();
  setupLocator();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {


  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(configViewModel).fetchConfig();
      ref.read(lgaDetailsViewModel).fetchLgaDetails();
      //ref.read(hearAboutUsViewModel).fetchHearAboutUs();
    });

    //push notification initial set up
   FirebaseMessagingUtils.requestPushNotificationPermission();

    //location permission
    final locationService = locator<GeoLocatorService>();
    locationService.requestPermission();

    super.initState();
  }





  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) {
          final height = constraints.maxHeight - 32;
          final width = constraints.maxWidth - 16;
          return ScreenUtilInit(
            splitScreenMode: false,
            minTextAdapt: true,
            designSize: Size(width, height),
            //designSize: designSize,
            builder: (context, child) => Consumer(
              builder: (context, ref, child) {
                final themeVm = ref.watch(themeSelectionViewModel);
                final themeMode = themeVm.themeMode;
                return MaterialApp(
                  title: 'Windfall Raffle',
                  debugShowCheckedModeBanner: false,
                  theme: AppTheme.lightTheme,
                  darkTheme: AppTheme.darkTheme,
                  themeMode: themeMode,
                  navigatorKey: locator<NavigationService>().navigationKey,
                  onGenerateRoute: router.generateRoute,
                  //home: const Landing(),
                  home: const BottomNav(),
                  routes: {
                    NamedRoutes.bottomNav: (context) => const BottomNav(),
                  },
                  builder: (context, child) {
                    final mq = MediaQuery.of(context);
                    return MediaQuery(
                      data: mq.copyWith(textScaler: TextScaler.noScaling),
                      child: child!,
                    );
                  },
                );
              },
            ),
          );
        }
    );
  }
}

