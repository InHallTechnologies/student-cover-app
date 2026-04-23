import "package:flutter/material.dart";
import "package:student_cover/constants.dart";

AppBar MyAppBar() {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    title: Text(
      "Student Cover",
      style: kHeadlineStyle.copyWith(
        color: kPrimaryDark,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    ),
    leading: Padding(
      padding: const EdgeInsets.only(
        left: 16.0,
        top: 12.0,
        bottom: 16.0,
        right: 0,
      ),
      child: Image.asset(
        "images/student_cover_logo_only.png",
        fit: BoxFit.contain,
      ),
    ),
    actions: const [
      Icon(Icons.notifications_outlined, color: kGreyColor, size: kIconSize),
      SizedBox(width: 15),
      CircleAvatar(
        backgroundImage: NetworkImage("https://picsum.photos/200"),
        radius: 15,
      ),
      SizedBox(width: 15),
    ],
  );
}
