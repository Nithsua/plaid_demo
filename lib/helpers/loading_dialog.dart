import 'package:flutter/material.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: AlertDialog(
          contentPadding: const EdgeInsets.all(40.0),
          content: SizedBox(
            width: 50,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                CircularProgressIndicator(
                  color: Colors.black,
                  strokeWidth: 2.0,
                ),
                SizedBox(height: 30),
                Text(
                  'Processing Your Request, Please Wait',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          )),
    );
  }
}
