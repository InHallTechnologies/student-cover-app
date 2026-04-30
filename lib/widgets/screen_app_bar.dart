import 'package:flutter/material.dart';
import 'package:student_cover/constants.dart';

AppBar getScreenAppBar(String screenTitle) {
  return AppBar(
    title: Text(screenTitle, style: hSubheadlineStyle.copyWith(color: Colors.black)),
    backgroundColor: Colors.white,
    actions: const [
      Icon(Icons.notifications_outlined, color: kGreyColor, size: kIconSize),
      SizedBox(width: 15),
      CircleAvatar(backgroundImage: NetworkImage("https://picsum.photos/200"), radius: 15),
      SizedBox(width: 15),
    ],
  );
}
