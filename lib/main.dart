import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mausam/common/helper/helper.dart';
import 'package:mausam/presentation/bloc/GetWeather/getweather_cubit.dart';
import 'package:mausam/presentation/screens/help/help_screen.dart';
import 'package:mausam/presentation/screens/home/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'di/injection.dart' as get_it;
import 'presentation/bloc/ChangeLabel/changelabel_cubit.dart';

late SharedPreferences sharedPreferences;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  sharedPreferences = await SharedPreferences.getInstance();
  get_it.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              get_it.sl<GetweatherCubit>()..getWeatherFromLocalStorage(),
        ),
        BlocProvider(
          create: (context) => get_it.sl<ChangelabelCubit>(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
