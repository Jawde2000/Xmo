// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:amazon/constants/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingOverlay {
  BuildContext context;
 
  void hide() {
    Navigator.of(context).pop();
  }

  void show() {
    showDialog(context: context, barrierDismissible: false, builder: ((ctx) => _LoadingIndicator()));
  }

  Future<T> during<T>(Future<T> future) {
    show();
    return future.whenComplete(() => hide());
  }

  LoadingOverlay._create(this.context);

  factory LoadingOverlay.of(BuildContext context) {
    return LoadingOverlay._create(context);
  }
}

class _LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: showLoadingStatus(true));
  }
}
