import 'package:flutter/material.dart';

import 'loading_indicator.dart';

void showLoadingIndicator(context){
  showDialog(
      context: context,
      barrierColor: Colors.white.withOpacity(0),
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const AlertDialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0))),
          content: LoadingIndicator(),
        );
      });
}