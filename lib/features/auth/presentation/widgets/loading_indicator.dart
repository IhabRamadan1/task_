
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          width: 150,
          height: 150,
          padding: const EdgeInsets.all(10),
          color: Colors.white.withOpacity(0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                _getLoadingIndicator(context),
              ])),
    );
  }

  Padding _getLoadingIndicator(context) {
    return  Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: SpinKitFadingCube(
          color: Theme.of(context).primaryColor,
        ));
  }
}
