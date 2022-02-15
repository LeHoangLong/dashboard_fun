import 'dart:math';

import 'package:dashboard_fun/drawer_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyDrawer extends StatefulWidget {
  final double width;
  const MyDrawer({
    Key? key,
    required this.width,
  }) : super(key: key);

  @override
  MyDrawerState createState() => MyDrawerState();
}

class MyDrawerState extends State<MyDrawer> {
  int selectedButton = 0;

  Widget buildButton(IconData icon, int index, [double rotateRad = 0]) {
    return DrawerButton(
      icon: Transform.rotate(
        angle: rotateRad,
        child: Icon(
          icon,
          color: selectedButton == index
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.secondary,
        ),
      ),
      isHighlighted: selectedButton == index,
      onHover: () {
        setState(() {
          selectedButton = index;
        });
      },
    );
  }

  Widget buildFontAwesomeIcon(int index, double rotate) {
    return DrawerButton(
      icon: FaIcon(
        FontAwesomeIcons.rocket,
        color: selectedButton == index ? Theme.of(context).primaryColor : null,
      ),
      isHighlighted: selectedButton == index,
      onHover: () {
        setState(() {
          selectedButton = index;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        width: widget.width,
        child: Drawer(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(
                  top: 20,
                  bottom: 40,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  width: 25,
                  height: 25,
                  alignment: const Alignment(0, 0),
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    width: 8,
                    height: 8,
                  ),
                ),
              ),
              buildButton(Icons.home_outlined, 0),
              buildButton(Icons.open_with_outlined, 1),
              buildButton(Icons.wallet_travel_outlined, 2),
              buildButton(FontAwesomeIcons.rocket, 3, -(45 / 180 * pi)),
            ],
          ),
        ),
      ),
    );
  }
}
