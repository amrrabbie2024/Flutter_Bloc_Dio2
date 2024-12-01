import 'package:device_preview/device_preview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_apis_pagination/core/get_it.dart';
import 'package:flutter_apis_pagination/core/kiwi.dart';
import 'package:flutter_apis_pagination/core/logic/cash_helper.dart';
import 'package:flutter_apis_pagination/features/weather_task/bloc.dart';
import 'package:flutter_apis_pagination/views/new_login/view.dart';
import 'package:flutter_apis_pagination/views/tasks/x_0_game/view.dart';
import 'package:flutter_apis_pagination/widgets/animated_opcity/view.dart';
import 'package:flutter_apis_pagination/widgets/badge/view.dart';
import 'package:flutter_apis_pagination/widgets/ranger_slider/view.dart';
import 'package:flutter_apis_pagination/widgets/switch/view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/logic/helper_methods.dart';
import 'firebase_options.dart';
import 'views/advanced_news/view.dart';
import 'views/audio_player/view.dart';
import 'views/date_time/view.dart';
import 'views/dialogs_sheets/view.dart';
import 'views/g_news/view.dart';
import 'views/home/home_page.dart';
import 'views/image_picker/view.dart';
import 'views/locatization/view.dart';
import 'views/login/view.dart';
import 'views/login_regsister/login/view.dart';
import 'views/login_regsister_profile/login/view.dart';
import 'views/maps/map_loc.dart';
import 'views/marvel/view.dart';
import 'views/movies/view.dart';
import 'views/movies_m/view.dart';
import 'views/movies_options/carousel_slider.dart';
import 'views/movies_options/drop_down_button.dart';
import 'views/movies_options/movies_checkbox.dart';
import 'views/movies_options/movies_radio.dart';
import 'views/movies_pagination/view.dart';
import 'views/new_weather/view.dart';
import 'views/news_pagination/view.dart';
import 'views/persons_offline/home.dart';
import 'views/products/all_products/view.dart';
import 'views/splash/view.dart';
import 'views/tab_bar/tab_bar.dart';
import 'views/task_news/view.dart';
import 'views/v_movies/view.dart';
import 'views/v_weather/view.dart';
import 'views/video_player/video_player.dart';
import 'views/w_weather/view.dart';
import 'views/weather/view.dart';
import 'views/weather_task/view.dart';
import 'views/y_movies/view.dart';
import 'views/y_weather/view.dart';
import 'views/z_movies/view.dart';
import 'widgets/asweom_dialog/view.dart';
import 'widgets/auto_complete/view.dart';
import 'widgets/banner/view.dart';
import 'widgets/carousel_slider/view.dart';
import 'widgets/check_box/view.dart';
import 'widgets/curved_navigation_bar/view.dart';
import 'widgets/curved_navigation_bar/view2.dart';
import 'widgets/dismisible/view.dart';
import 'widgets/drop_button/view.dart';
import 'widgets/floating_bootom_bar/view.dart';
import 'widgets/flutter_slidable/view.dart';
import 'widgets/list_tile_check/view.dart';
import 'widgets/pages_view_builder/view.dart';
import 'widgets/pages_views/view.dart';
import 'widgets/radio_box/view.dart';
import 'widgets/slider/view.dart';
import 'widgets/vertical_divider/view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

 // await Firebase.initializeApp();

  CashHelper.init();
  initKiwi();
  initGetIt();


  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    DevicePreview(
      //enabled: !kReleaseMode,
        enabled: false,
      builder: (context) =>  EasyLocalization(
          supportedLocales: [Locale('en'), Locale('ar'),Locale('fr')],
          path: 'assets/translation', // <-- change the path of the translation files
          fallbackLocale: Locale('ar'),
          startLocale: Locale('en'),
          child: MyApp()
      ), // Wrap your app
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        // Use builder only if you need to use library outside ScreenUtilInit context
        builder: (_, child) {
          return MaterialApp(
            useInheritedMediaQuery: true,
            locale: DevicePreview.locale(context),
            builder: DevicePreview.appBuilder,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            //locale: context.deviceLocale,
            //locale: context.locale,
            title: 'Flutter_Apis_Pagination',
            debugShowCheckedModeBanner: false,
            navigatorKey: navigtorKey,
            theme: ThemeData(
              backgroundColor: Colors.yellow,
              //fontFamily: "PlayWrite Mexico",
              //colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                colorScheme: ColorScheme.fromSeed(
                    seedColor: Colors.blue, primary: Colors.green),
                useMaterial3: true,

                /* appBarTheme: AppBarTheme(
                centerTitle: true,
                color: Colors.yellow,
                titleTextStyle: TextStyle(color: Colors.orange,fontSize: 28,fontWeight: FontWeight.bold,fontFamily: "PlayWrite NZ")
              ),*/

                appBarTheme: AppBarTheme(
                    color: Color(0xfffeeb39),
                    centerTitle: true,
                    titleTextStyle: TextStyle(color: Color(0xff825d47),fontSize: 24,fontWeight: FontWeight.w600)
                ),

                /* filledButtonTheme: FilledButtonThemeData(
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.orange,
                  textStyle: TextStyle(fontWeight: FontWeight.w600,fontSize: 22),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(color: Colors.green)
                  )
                )
              ),*/

                filledButtonTheme: FilledButtonThemeData(
                    style: FilledButton.styleFrom(
                        textStyle: TextStyle(fontSize: 22,fontWeight: FontWeight.w600),
                        backgroundColor: Color(0xffae1356),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.r)
                        )
                    )
                ),

                /* textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.yellow,
                  textStyle: TextStyle(color: Colors.blue,fontSize: 22,fontWeight: FontWeight.w600),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                    side: BorderSide(color: Colors.orange)
                  )
                )
              ),*/

                textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                        textStyle: TextStyle(color: Color(0xff825d47))
                    )
                ),

                iconTheme: IconThemeData(
                    color: Colors.green
                ),

                iconButtonTheme: IconButtonThemeData(
                    style: IconButton.styleFrom(
                      //backgroundColor: Colors.green.withOpacity(.3),
                    )
                ),

                elevatedButtonTheme: ElevatedButtonThemeData(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.withOpacity(.5),
                        textStyle: TextStyle(color: Color(0xffffffff),fontWeight:  FontWeight.bold,fontSize: 22),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusDirectional.only(topStart: Radius.circular(25),bottomEnd: Radius.circular(16)),
                            side: BorderSide(color: Colors.orange,width: 5)
                        )
                    )
                )

            ),

            home: const MarvelView(),
          );
        }
    );
  }
}


