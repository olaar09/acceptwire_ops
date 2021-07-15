import 'package:flutter/material.dart';

ScaffoldFeatureController mSnackBar({@required context, @required message}) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text('$message'),
  ));
}
