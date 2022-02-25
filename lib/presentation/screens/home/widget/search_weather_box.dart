import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mausam/common/constants/color_constants.dart';

class SearchWeatherBox extends StatelessWidget {
  final TextEditingController searchController;
  const SearchWeatherBox({
    Key? key,
    required this.searchController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: searchController,
      style: GoogleFonts.poppins(
        fontSize: 13,
        color: Colors.black.withOpacity(0.95),
      ),
      cursorColor: ColorConstant.mainColor,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        isDense: false,
        hintText: "Search from location....",
        hintStyle: GoogleFonts.poppins(
          fontSize: 13,
          color: Colors.black.withOpacity(0.6),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            width: 0.8,
          ),
        ),
        errorBorder: InputBorder.none,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorConstant.mainColor,
            width: 0.8,
          ),
        ),
      ),
    );
  }
}
