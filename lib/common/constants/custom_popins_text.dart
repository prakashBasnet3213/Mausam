import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Text customPoppinsText({
  required String content,
  required TextStyle style,
  TextAlign? align,
}) {
  return Text(
    content,
    style: GoogleFonts.poppins(textStyle: style),
    textAlign: align,
  );
}
