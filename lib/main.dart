import 'package:flutter/material.dart';
import 'package:expense_tracker/widgets/expenses.dart';

var kColorSchema = ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 96, 59, 181),);
void main() {
  runApp(
    MaterialApp(
      theme: ThemeData().copyWith(
          useMaterial3: true, 
          colorScheme: kColorSchema,
          appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: kColorSchema.onPrimaryContainer,
            foregroundColor: kColorSchema.primaryContainer
          ),
          cardTheme: const CardTheme().copyWith(
            color: kColorSchema.secondaryContainer,
            margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom(
            backgroundColor: kColorSchema.primaryContainer,
          ),),
          textTheme: ThemeData().textTheme.copyWith(
            titleLarge: TextStyle(fontWeight: FontWeight.normal, color: kColorSchema.onSecondaryContainer, fontSize: 14)
            )
          ),
      home: const Expenses(),
          )
    );
}
