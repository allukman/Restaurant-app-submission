import 'package:flutter/material.dart';
import 'package:restaurant_app/util/state.dart';

class ViewEmpty extends StatelessWidget {
  final String message;
  final ResultState state;

  const ViewEmpty({
    required this.message,
    required this.state,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      message,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: state == ResultState.noData ? Colors.black : Colors.red),
    );
  }
}
