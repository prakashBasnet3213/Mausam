import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mausam/common/constants/color_constants.dart';
import 'package:mausam/common/constants/custom_popins_text.dart';
import 'package:mausam/common/exception/app_exception.dart';
import 'package:mausam/presentation/bloc/ChangeLabel/changelabel_cubit.dart';
import 'package:mausam/presentation/bloc/GetWeather/getweather_cubit.dart';
import 'package:mausam/presentation/screens/home/widget/search_weather_box.dart';
import 'package:mausam/presentation/screens/home/widget/temperature_card.dart';
import 'package:mausam/presentation/screens/widgets/custom_button.dart';
import 'package:mausam/presentation/screens/widgets/custom_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController _searchController;
  late GetweatherCubit _getweatherCubit;
  late ChangelabelCubit _changelabelCubit;
  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _getweatherCubit = BlocProvider.of<GetweatherCubit>(context);
    _changelabelCubit = BlocProvider.of<ChangelabelCubit>(context);
    _searchController.addListener(() {
      if (_searchController.text.isEmpty) {
        _changelabelCubit.changeLabel(false);
      } else {
        _changelabelCubit.changeLabel(true);
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    if (!mounted) {
      _getweatherCubit.close();
      _changelabelCubit.close();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.7,
        title: customPoppinsText(
          content: "Mausam",
          style: TextStyle(
            fontSize: 16,
            color: Colors.black.withOpacity(0.8),
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.help_outline,
              color: Colors.black.withOpacity(0.8),
              size: 25,
            ),
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: SearchWeatherBox(
                      searchController: _searchController,
                    ),
                  ),
                  const SizedBox(width: 10),
                  BlocBuilder<ChangelabelCubit, ChangelabelState>(
                    builder: (context, state) {
                      if (state is ChangelabelLoaded) {
                        if (state.isUpdate) {
                          return CustomButton(
                            onPressed: () {
                              if (_searchController.text.isNotEmpty) {
                                _getweatherCubit.getWeatherFromLocation(
                                  _searchController.text.trim(),
                                );
                              }
                              FocusScope.of(context).unfocus();
                            },
                            text: "Update",
                          );
                        } else {
                          return CustomButton(
                            onPressed: () {
                              if (_searchController.text.isNotEmpty) {}
                              FocusScope.of(context).unfocus();
                            },
                            text: "Save",
                          );
                        }
                      }
                      return CustomButton(
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                        },
                        text: "Save",
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 30),
              BlocBuilder<GetweatherCubit, GetweatherState>(
                builder: (context, state) {
                  if (state is GetweatherLoaded) {
                    if (state.lastSearched != null) {
                      return customPoppinsText(
                        content:
                            "Your last searched was: ${state.lastSearched}",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black.withOpacity(0.8),
                        ),
                      );
                    }
                    return const SizedBox();
                  }
                  return const SizedBox();
                },
              ),
              const SizedBox(height: 20),
              BlocBuilder<GetweatherCubit, GetweatherState>(
                builder: (context, state) {
                  if (state is GetweatherLoaded) {
                    return TemperatureCard(
                      model: state.model,
                    );
                  } else if (state is GetweatherLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: ColorConstant.mainColor,
                      ),
                    );
                  } else if (state is GetweatherFailed) {
                    WidgetsBinding.instance!.addPostFrameCallback((_) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return CustomDialog(
                            heading: state.type == AppErrorType.network
                                ? "No Network Connection"
                                : state.type == AppErrorType.badRequest
                                    ? "Invalid Location Name"
                                    : "Server Sleeping",
                            message: state.type == AppErrorType.network
                                ? "Please check your internet connection"
                                : state.type == AppErrorType.badRequest
                                    ? "Please enter the valid location name"
                                    : "We are sorry for the inconvinence.\nServer under maintainence",
                          );
                        },
                      );
                    });
                  }
                  return Center(
                    child: customPoppinsText(
                      content: "Search weather by location....",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black.withOpacity(0.8),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
