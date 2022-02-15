import 'package:dashboard_fun/compare_with_model.dart';
import 'package:dashboard_fun/month_model.dart';
import 'package:dashboard_fun/progress_model.dart';
import 'package:dashboard_fun/select_month.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Graph extends StatefulWidget {
  final ProgressModel progress;

  const Graph({
    Key? key,
    required this.progress,
  }) : super(key: key);

  @override
  GraphState createState() => GraphState();
}

class _MinMaxProgress {
  int min;
  int max;
  _MinMaxProgress({
    required this.min,
    required this.max,
  });
}

_MinMaxProgress _getMinMaxProgress(ProgressModel progress) {
  var max = progress.numberOfVideos[0], min = progress.numberOfVideos[0];
  for (var i = 1; i < 12; i++) {
    if (progress.numberOfVideos[i] > max) {
      max = progress.numberOfVideos[i];
    }
    if (progress.numberOfVideos[i] < min) {
      min = progress.numberOfVideos[i];
    }
  }
  return _MinMaxProgress(min: min, max: max);
}

class _GraphCurve extends CustomPainter {
  ProgressModel progress;
  double barWidth;
  double minY;
  double maxY;
  Color color;
  _GraphCurve({
    required this.progress,
    required this.barWidth,
    required this.maxY,
    required this.minY,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    var path = Path();

    var minMax = _getMinMaxProgress(progress);

    double prevY = 0;
    double prevX = 0;
    for (var i = 0; i < 12; i++) {
      double x = barWidth * (i + 0.5);
      double y = minY +
          (maxY - minY) *
              (progress.numberOfVideos[i] - minMax.min) /
              (minMax.max - minMax.min);
      y = maxY - y + 10;
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.cubicTo(prevX + 60, prevY, x - 60, y, x, y);
      }
      prevY = y;
      prevX = x;
    }

    paint.color = color;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 5;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    _GraphCurve curve = oldDelegate as _GraphCurve;
    for (var i = 0; i < progress.numberOfVideos.length; i++) {
      if (progress.numberOfVideos[i] != curve.progress.numberOfVideos[i]) {
        return true;
      }
    }
    return true;
  }
}

class GraphState extends State<Graph> {
  late Month selectedMonth;
  late CompareWith compareWith;

  GraphState() {
    selectedMonth = Month.values[DateTime.now().month - 1];
    compareWith = CompareWith.lastMonth;
  }

  @override
  void initState() {
    super.initState();
  }

  List<Widget> buildProgressBars(
      BuildContext context, BoxConstraints constraints) {
    var ret = <Widget>[];
    var barWidth = constraints.maxWidth / 12;
    var minMax = _getMinMaxProgress(widget.progress);

    for (var i = 0; i < 12; i++) {
      var barHeight = (widget.progress.numberOfVideos[i] - minMax.min) *
              (constraints.maxHeight - 30) /
              (minMax.max - minMax.min) +
          10;
      ret.add(
        Positioned(
          left: i * barWidth,
          bottom: 20,
          child: GestureDetector(
            onTap: () {
              setState(() {
                selectedMonth = Month.values[i];
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                ),
                color: i == selectedMonth.index
                    ? Theme.of(context).colorScheme.primary
                    : const Color.fromARGB(255, 248, 245, 255),
              ),
              height: barHeight,
              width: barWidth - 5,
            ),
          ),
        ),
      );

      ret.add(
        Positioned(
          left: i * barWidth,
          bottom: 0,
          child: Container(
            width: barWidth - 5,
            alignment: const Alignment(0, 0),
            child: Text(
              Month.values[i].initials,
              style: TextStyle(
                fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
        ),
      );
    }
    return ret;
  }

  Widget buildPath(BuildContext context, BoxConstraints constraints) {
    var barWidth = constraints.maxWidth / 12;
    return CustomPaint(
      painter: _GraphCurve(
        progress: widget.progress,
        barWidth: barWidth,
        maxY: constraints.maxHeight - 20,
        minY: constraints.maxHeight / 2,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Learning Curve',
                style: Theme.of(context).textTheme.headline5,
              ),
            )
          ],
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(bottom: 0),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Stack(
                  children: buildProgressBars(context, constraints),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
