import 'package:dashboard_fun/course_model.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CourseList extends StatelessWidget {
  final List<CourseModel> courses;
  final int selectedCourseIndex;
  final void Function(int selectedCourseIndex) onCourseSelected;

  const CourseList({
    Key? key,
    required this.courses,
    required this.selectedCourseIndex,
    required this.onCourseSelected,
  }) : super(key: key);

  List<Widget> buildCourses(BuildContext context) {
    List<Widget> ret = [];
    for (var i = 0; i < courses.length; i++) {
      ret.add(
        GestureDetector(
          onTap: () {
            onCourseSelected(i);
          },
          child: Container(
            margin: const EdgeInsets.only(
              right: 15,
            ),
            width: 200,
            decoration: BoxDecoration(
              border: Border.all(
                color: i == selectedCourseIndex
                    ? Theme.of(context).colorScheme.primary
                    : Colors.transparent,
                width: i == selectedCourseIndex ? 1 : 0,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 15),
                        child: Image.asset(
                          courses[i].image,
                          width: 30,
                          height: 30,
                        ),
                      ),
                      Text(
                        courses[i].name,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          top: 5,
                          bottom: 15,
                        ),
                        child: Text(
                          "${courses[i].videoCount.toString()} Videos",
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 5,
                  ),
                  color: i == selectedCourseIndex
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.secondaryVariant,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Learn More',
                        style: TextStyle(
                          color: i == selectedCourseIndex
                              ? Theme.of(context).colorScheme.onPrimary
                              : Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 2,
                        ),
                      ),
                      IconButton(
                        tooltip: 'Lorenpisum something blah blah blah',
                        onPressed: () {},
                        icon: Icon(
                          Icons.info_outline,
                          color: i == selectedCourseIndex
                              ? Colors.white
                              : Colors.grey,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return ret;
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
        },
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: buildCourses(context),
        ),
      ),
    );
  }
}
