import 'package:flutter/material.dart';

class StepBars extends StatelessWidget {
  const StepBars({
    Key? key,
    required this.numberOfPages,
    required this.pageIndex,
  }) : super(key: key);

  final int numberOfPages;
  final int pageIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(
          numberOfPages,
          (index) => Container(
                height: 10,
                width: 50,
                margin: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                    color: index < pageIndex
                        ? Colors.blue
                        : (index == pageIndex ? Colors.green : Colors.blueGrey),
                    borderRadius: const BorderRadius.all(Radius.circular(16))),
              )),
    );
  }
}
