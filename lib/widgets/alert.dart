import 'package:flutter/material.dart';

class Alerts {
  showAlertDialog(BuildContext context, VoidCallback yes) {
    Widget cancelButton = TextButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: const Text(
        'Отмена',
        style: TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
    );

    Widget continueButton = TextButton(
      onPressed: yes,
      child: const Text(
        'Да',
        style: TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Вы уверены?'),
          actions: [
            cancelButton,
            continueButton,
          ],
        );
      },
    );
  }
}
