// Clase para definir el tema principal de la aplicación

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FooderlichTheme {
  // Definir apariencia de texto para ambientes claros
  static TextTheme lightTextTheme = TextTheme(
      // El paquete google_fonts cuenta con mas de 900 fuentes listas para usarse en la aplicación
      bodyLarge: GoogleFonts.openSans(
          fontSize: 14.0, fontWeight: FontWeight.w700, color: Colors.black),
      displayLarge: GoogleFonts.openSans(
          fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.black),
      displayMedium: GoogleFonts.openSans(
          fontSize: 21.0, fontWeight: FontWeight.w700, color: Colors.black),
      displaySmall: GoogleFonts.openSans(
          fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.black),
      titleLarge: GoogleFonts.openSans(
          fontSize: 20.0, fontWeight: FontWeight.w600, color: Colors.black));

  // Definir apariencia de texto para ambientes oscuros
  static TextTheme darkTextTheme = TextTheme(
      bodyLarge: GoogleFonts.openSans(
          fontSize: 14.0, fontWeight: FontWeight.w700, color: Colors.white),
      displayLarge: GoogleFonts.openSans(
          fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.white),
      displayMedium: GoogleFonts.openSans(
          fontSize: 21.0, fontWeight: FontWeight.w700, color: Colors.white),
      displaySmall: GoogleFonts.openSans(
          fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.white),
      titleLarge: GoogleFonts.openSans(
          fontSize: 20.0, fontWeight: FontWeight.w600, color: Colors.white));

  // Definir apariencia de tema claro
  static ThemeData light() {
    return ThemeData(
        // El brillo de tema de la aplicación, que puede ser claro o oscuro
        brightness: Brightness.light,
        // La apariencia del texto para este tema, se debe contrastar con el brillo usado en este tema
        textTheme: lightTextTheme,
        checkboxTheme: CheckboxThemeData(
            fillColor:
                MaterialStateColor.resolveWith((states) => Colors.black)),
        appBarTheme: const AppBarTheme(
            foregroundColor: Colors.black, backgroundColor: Colors.white),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
            foregroundColor: Colors.white, backgroundColor: Colors.black),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            selectedItemColor: Colors.green));
  }

  // Definir apariencia de tema oscuro
  static ThemeData dark() {
    return ThemeData(
        brightness: Brightness.dark,
        textTheme: darkTextTheme,
        appBarTheme: AppBarTheme(
            foregroundColor: Colors.white, backgroundColor: Colors.grey[900]),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
            foregroundColor: Colors.white, backgroundColor: Colors.green),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            selectedItemColor: Colors.green));
  }
}
