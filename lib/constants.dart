import "package:flutter/material.dart";

const Color kPrimary = Color(0xFF3A2D7D);
const Color kPrimaryLight = Color(0xFF6C63FF);
const Color kPrimaryDark = Color(0xFF2A1F66);

// Gradient
const Color gradientStart = kPrimaryDark;
const Color gradientEnd = Color.fromARGB(234, 42, 31, 102);

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

const kHeadlineStyle = TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800);
const hSubheadlineStyle = TextStyle(color: Colors.white, fontSize: 17);

const kHeroHeadlineStyle = TextStyle(
  color: Colors.white,
  fontSize: 24,
  fontWeight: FontWeight.w800,
  letterSpacing: 0.5,
);
const kHeroSubheadlineStyle = TextStyle(
  color: Colors.white,
  fontSize: 16,
  height: 1.5,
  fontWeight: FontWeight.w400,
);

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

const kCtaHeadlineStyle = TextStyle(
  color: Colors.white,
  fontSize: 19,
  fontWeight: FontWeight.bold,
  letterSpacing: 0.5,
);
const kCtaSubheadlineStyle = TextStyle(
  color: Colors.white70,
  fontSize: 14,
  fontWeight: FontWeight.w400,
);

final BoxDecoration kCtaBoxDecoration = BoxDecoration(
  borderRadius: BorderRadius.circular(16),
  gradient: const LinearGradient(
    colors: [kPrimaryLight, kPrimary],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  ),
  boxShadow: [
    BoxShadow(color: kPrimaryLight.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 4)),
  ],
);

final ButtonStyle kAccentButtonStyle = ButtonStyle(
  backgroundColor: const WidgetStatePropertyAll(accent),
  foregroundColor: const WidgetStatePropertyAll(Colors.white),
  elevation: const WidgetStatePropertyAll(0),
  padding: const WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 20, vertical: 12)),
  shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
);

final BoxDecoration kDefaultCardDecoration = BoxDecoration(
  color: cardBackground,
  borderRadius: BorderRadius.circular(20),
  border: Border.all(color: border),
  boxShadow: [
    BoxShadow(
      color: Colors.black.withOpacity(0.05),
      blurRadius: 10,
      offset: const Offset(0, 4),
    ),
  ],
);
