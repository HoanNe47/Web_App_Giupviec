import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class TemporaryDialog extends StatelessWidget {
  final String message;
  final Duration duration;

  const TemporaryDialog({
    Key? key,
    required this.message,
    this.duration = const Duration(seconds: 1),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          // Một lớp trạng thái để theo dõi khi dialog đã được hiển thị
          return StatefulBuilder(
            builder: (context, setState) {
              Future.delayed(duration, () {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
              });

              return AlertDialog(
                content: Text(
                  message,
                  style: primaryTextStyle(),
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
      );
    });

    return SizedBox.shrink();
  }
}
