import "package:flutter/material.dart";

const Color kPrimary = Color(0xFF3A2D7D);
const Color kPrimaryLight = Color(0xFF6C63FF);
const Color kPrimaryDark = Color(0xFF2A1F66);

// Gradient
const Color gradientStart = Color(0xFF4A3ED1);
const Color gradientEnd = Color(0xFF6C63FF);

// Accent
const Color accent = Color(0xFFFF7A2F);
const Color accentLight = Color(0xFFFFA45C);

// Text
const Color textPrimary = Color(0xFF1E2A5A);
const Color textSecondary = Color(0xFF6B7280);

// Backgrounds
const Color background = Color(0xFFFEFCF8);
const Color cardBackground = Color(0xFFFFFFFF);

// Borders
const Color border = Color(0xFFE5E7EB);

// Greys
const Color kGreyColor = Color(0xff6B7280);

const double kIconSize = 25;

const kHeadlineStyle = TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w800);
const hSubheadlineStyle = TextStyle(color: Colors.white, fontSize: 17);

ButtonStyle kPrimaryButtonStyle = ButtonStyle(
  backgroundColor: WidgetStatePropertyAll(kPrimaryDark),
  shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
);

InputDecoration kAuthenticationInputDecoration = InputDecoration(
  labelStyle: const TextStyle(color: textSecondary),
  hintStyle: const TextStyle(color: textSecondary),
  prefixIcon: const Icon(Icons.phone_android_rounded, color: textSecondary),
  filled: true,
  fillColor: cardBackground,
  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: const BorderSide(color: border, width: 1.5),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: const BorderSide(color: kPrimaryDark, width: 2),
  ),
);
