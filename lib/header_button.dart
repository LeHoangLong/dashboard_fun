import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HeaderButton extends StatelessWidget {
  final Icon icon;
  final void Function() onPressed;

  const HeaderButton({
    Key? key,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var shadowColor = Theme.of(context).shadowColor;
    return Container(
      alignment: const Alignment(0, 0),
      child: Stack(
        children: [
          Positioned.fill(
            child: Align(
              alignment: const Alignment(0, 0),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(
                        10,
                        shadowColor.red,
                        shadowColor.green,
                        shadowColor.blue,
                      ),
                      blurRadius: 4,
                      spreadRadius: 2,
                      offset: const Offset(0, 10),
                    ),
                    BoxShadow(
                      color: Color.fromARGB(
                        30,
                        shadowColor.red,
                        shadowColor.green,
                        shadowColor.blue,
                      ),
                      blurRadius: 8,
                      spreadRadius: 4,
                      offset: const Offset(0, 16),
                    ),
                    BoxShadow(
                      color: Color.fromARGB(
                        30,
                        shadowColor.red,
                        shadowColor.green,
                        shadowColor.blue,
                      ),
                      blurRadius: 8,
                      spreadRadius: 4,
                      offset: const Offset(0, 24),
                    ),
                  ],
                ),
                child: icon,
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: const Alignment(0, 0),
              child: Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                padding: const EdgeInsets.all(10),
                child: icon,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
