import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/layout/news_app/cubit/cubit.dart';
import 'package:login/layout/news_app/cubit_mode/cubit.dart';
import 'package:login/layout/news_app/cubit_mode/states.dart';
import 'package:login/layout/shop_app/shop_layout.dart';
import 'package:login/modules/shop_app/login/shop_login_screen.dart';
import 'package:login/modules/social_app/social_login/social_login_screen.dart';
import 'package:login/shared/bloc_observer.dart';
import 'package:login/shared/components/constants.dart';
import 'package:login/shared/network/local/cache_helper.dart';
import 'package:login/shared/network/remote/DioHelper.dart';
import 'package:login/shared/styles/themes.dart';
import 'modules/shop_app/cubit/cubit.dart';
import 'modules/shop_app/on_boarding/on_boarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await Firebase.initializeApp();
  await CacheHelper.init();

  bool? isDark = CacheHelper.getData(key: 'isDark');

  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');

  Widget widget;

  if (onBoarding != null) {
    if (token != null) {
      widget = const ShopLayout();
    } else {
      widget = ShopLoginScreen();
    }
  } else {
    widget = OnBoardingScreen();
  }

  if (isDark == null) {
    isDark = false;
  } else {
    isDark = CacheHelper.getData(key: 'isDark') as bool;
  }
  runApp(MyApp(
    isDark: isDark,
    start_widget: widget,
  ));
}

class MyApp extends StatelessWidget {
  bool isDark = false;
  Widget start_widget;

  MyApp({super.key, required this.isDark, required this.start_widget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NewsCubit()
            ..getBusiness()
            ..getScience()
            ..getSports(),
        ),
        BlocProvider(
          create: (context) => ModeCubit()..changeAppMode(fromCache: isDark),
        ),
        BlocProvider(
          create: (context) => ShopCubit()
            ..getHomeData()
            ..getCategoriesData()
            ..getFavoritesData()
            ..getUserData(),
        ),
      ],
      child: BlocConsumer<ModeCubit, ModeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightThem,
            darkTheme: darkThem,
            themeMode: ModeCubit.get(context).isDark
                ? ThemeMode.dark
                : ThemeMode.light,
            home: SocialLoginScreen(),
          );
        },
      ),
    );
  }
}
