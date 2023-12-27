import 'package:ecommercr_app/core/controllers/login_controller/login_cubit.dart';
import 'package:ecommercr_app/core/network/local/cache_helper.dart';
import 'package:ecommercr_app/core/network/remote/dio_helper.dart';
import 'package:ecommercr_app/screens/modules/onboarding.dart';
import 'package:ecommercr_app/screens/modules/products_screen.dart';
import 'package:ecommercr_app/screens/modules/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/controllers/cart_cubit/cart_cubit.dart';
import 'core/controllers/observer.dart';
import 'core/controllers/onboarding_cubit/onboarding_cubit.dart';
import 'core/controllers/products_controller/product_cubit.dart';
import 'core/controllers/register_cubit/register_cubit.dart';
import 'core/managers/themes.dart';
import 'core/managers/values.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelperStore.init();
  await CacheHelper.init();
  var boarding = CacheHelper.getData(key: "Boarding");
  token = CacheHelper.getData(key: 'token');
  natoinalId = CacheHelper.getData(key: 'userId');
  print(token);
  print(natoinalId);
  print(boarding);
  if(boarding== true){
    if(token!=null) {
      nextScreen = const ProductScreen();
    }else{
      nextScreen = RegisterScreen();
    }
  }else{
    nextScreen = const OnBoardingScreen();
  }
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => OnBoardingCubit(),
          lazy: true,
        ),

        BlocProvider(
          create: (context) => CartCubit()..getCart(),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => RegisterCubit(),
          lazy: true,
        ),
        BlocProvider(
          create: (context) => ProductCubit()..getHomeProducts(),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => LoginCubit(),
          lazy: true,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: lightTheme,
        home: nextScreen,
      ),
    );
  }
}
