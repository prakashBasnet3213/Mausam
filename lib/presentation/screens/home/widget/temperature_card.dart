import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mausam/common/constants/color_constants.dart';
import 'package:mausam/common/constants/custom_popins_text.dart';
import 'package:mausam/domain/entities/refined_weather.dart';

class TemperatureCard extends StatelessWidget {
  final RefinedWeatherModel model;
  const TemperatureCard({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        border: Border.all(
          color: ColorConstant.mainColor,
          width: 0.9,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: customPoppinsText(
              content: "${model.name}, ${model.country}",
              style: TextStyle(
                fontSize: 15,
                color: Colors.black.withOpacity(0.85),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              customPoppinsText(
                content: "Temperature: ${model.tempC.toString()} C",
                style: const TextStyle(
                  fontSize: 13.4,
                  color: Colors.black,
                ),
              ),
              Container(
                height: 40,
                width: 40,
                decoration: const BoxDecoration(shape: BoxShape.circle),
                clipBehavior: Clip.antiAlias,
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: "https:${model.icon}",
                ),
              ),
            ],
          ),
          const SizedBox(),
          customPoppinsText(
            content: "Weather Status: ${model.text}",
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
