import 'package:dashboard_fun/selected_menu_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DrawerButton extends StatefulWidget {
  Widget icon;
  bool isHighlighted;
  void Function() onHover;

  DrawerButton({
    Key? key,
    required this.icon,
    required this.isHighlighted,
    required this.onHover,
  });

  @override
  DrawerButtonState createState() => DrawerButtonState();
}

class DrawerButtonState extends State<DrawerButton>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 100,
      ),
    );
    animation = Tween<double>(begin: 0, end: 1).animate(controller)
      ..addListener(
        () {
          setState(
            () {},
          );
        },
      );
    if (widget.isHighlighted) {
      controller.forward();
    }
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isHighlighted != widget.isHighlighted) {
      if (widget.isHighlighted) {
        controller.forward();
      } else {
        controller.reverse();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        widget.onHover();
      },
      child: Container(
        height: 40,
        margin: const EdgeInsets.only(
          top: 5,
          bottom: 5,
        ),
        child: Row(
          children: [
            Container(
              height: 40,
              width: 8,
              alignment: const Alignment(-1, 0),
              child: SizedBox(
                height: 40,
                width: 8 * animation.value,
                child: CustomPaint(
                  painter: SelectedMenuPainter(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),
            Expanded(child: widget.icon),
          ],
        ),
      ),
    );
  }
}
