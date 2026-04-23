import 'package:flutter/material.dart';

enum SnackbarType { success, warning, error }

class AlertManager {
  final BuildContext context;
  const AlertManager({required this.context});

  void showSnackBar(String message, SnackbarType type) {
    Map<SnackbarType, Color> colorCode = {SnackbarType.success: Colors.green, SnackbarType.error: Colors.red, SnackbarType.warning: const Color.fromARGB(255, 113, 113, 113)};
    Map<SnackbarType, IconData> iconCode = {SnackbarType.success: Icons.check, SnackbarType.error: Icons.error, SnackbarType.warning: Icons.warning};
    SnackBar snackBar = SnackBar(
      content: Row(
        spacing: 12,
        children: [
          Icon(iconCode[type], color: Colors.white, size: 20),
          Text(message),
        ],
      ),
      showCloseIcon: true,
      backgroundColor: colorCode[type],
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<dynamic> showAlertDialog(String message) {
    return showDialog(
      context: context,
      builder: (BuildContext alertContext) {
        return AlertDialog(
          title: Text("Alert"),
          content: Text(message),
          actions: [TextButton(child: Text("OK"), onPressed: () => Navigator.pop(context))],
        );
      },
    );
  }
}
