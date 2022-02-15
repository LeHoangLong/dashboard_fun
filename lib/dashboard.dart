import 'package:dashboard_fun/check_screen_size.dart';
import 'package:dashboard_fun/course_list.dart';
import 'package:dashboard_fun/course_model.dart';
import 'package:dashboard_fun/graph.dart';
import 'package:dashboard_fun/header_button.dart';
import 'package:dashboard_fun/my_drawer.dart';
import 'package:dashboard_fun/progress_bloc.dart';
import 'package:dashboard_fun/progress_state.dart';
import 'package:dashboard_fun/screen_model.dart';
import 'package:dashboard_fun/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class DashBoard extends StatefulWidget {
  @override
  DashBoardState createState() => DashBoardState();
}

typedef DrawerWidthSetter = void Function(double width);

class DashBoardState extends State<DashBoard> with WidgetsBindingObserver {
  int selectedCourseIndex = 0;
  List<CourseModel> courses = [];
  double drawerWidth = 50;

  @override
  void initState() {
    courses.add(const CourseModel(
      id: 0,
      name: "PHP Developer",
      videoCount: 124,
      image: "assets/php_icon.png",
    ));
    courses.add(const CourseModel(
      id: 1,
      name: "PHP Developer",
      videoCount: 124,
      image: "assets/python_icon.png",
    ));
    courses.add(const CourseModel(
      id: 2,
      name: "PHP Developer",
      videoCount: 124,
      image: "assets/figma_icon.png",
    ));
    courses.add(const CourseModel(
      id: 3,
      name: "PHP Developer",
      videoCount: 124,
      image: "assets/sketch_icon.jpeg",
    ));
    courses.add(const CourseModel(
      id: 4,
      name: "PHP Developer",
      videoCount: 124,
      image: "assets/grunt_icon.png",
    ));

    context.read<ProgressBloc>().fetchProgress(
        courses[0]); //  by right, this will be in a bloc listener
    super.initState();
  }

  Widget buildTitleText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Learn New Skills',
          style: TextStyle(
            color: Colors.black,
            letterSpacing: 1,
            fontSize: Theme.of(context).textTheme.headline5?.fontSize,
            fontWeight: FontWeight.w900,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            'One simple price. Unlimited skills',
            style: TextStyle(
              letterSpacing: 1,
              color: Colors.grey[400],
              fontSize: Theme.of(context).textTheme.bodyText2?.fontSize,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildExploreMoreButton() {
    return TextButton(
      style: Theme.of(context).textButtonTheme.style,
      onPressed: () {},
      child: Container(
        child: const Text('+   Explore More'),
        padding: const EdgeInsets.all(15),
      ),
    );
  }

  Widget buildTitle() {
    return Container(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Row(
            children: [
              Expanded(child: buildTitleText()),
              buildExploreMoreButton(),
            ],
          );
        },
      ),
    );
  }

  Widget buildHeader(ScreenModel screenModel) {
    return SizedBox(
      height: 80,
      child: Container(
        margin: const EdgeInsets.only(
          bottom: 20,
        ),
        child: Row(
          children: [
            Builder(
              builder: (context) {
                return Container(
                  margin: const EdgeInsets.only(right: 15, left: 5),
                  child: IconButton(
                    icon: Icon(
                      Icons.view_sidebar,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    onPressed: () {
                      if (screenModel == ScreenModel.small) {
                        Scaffold.of(context).openDrawer();
                      } else {
                        if (drawerWidth == 0) {
                          context.read<DrawerWidthSetter>()(50);
                        } else {
                          context.read<DrawerWidthSetter>()(0);
                        }
                      }
                    },
                  ),
                );
              },
            ),
            Expanded(
              child: SearchBar(
                onSubmitted: (value) {},
              ),
            ),
            SizedBox(
              width: 50,
              child: HeaderButton(
                icon: Icon(
                  Icons.message,
                  size: 20,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                onPressed: () {},
              ),
            ),
            SizedBox(
              width: 50,
              child: HeaderButton(
                icon: Icon(
                  Icons.notifications_active,
                  size: 20,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                onPressed: () {},
              ),
            ),
            SizedBox(
              width: 50,
              child: HeaderButton(
                icon: Icon(
                  Icons.person,
                  size: 20,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCoursesList(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 30,
      ),
      child: CourseList(
        courses: courses,
        selectedCourseIndex: selectedCourseIndex,
        onCourseSelected: (index) {
          setState(() {
            selectedCourseIndex = index;
          });
          var selectedCourse = courses[index];
          context.read<ProgressBloc>().fetchProgress(selectedCourse);
        },
      ),
    );
  }

  Widget buildGraph(BuildContext context) {
    if (selectedCourseIndex < 0 || selectedCourseIndex >= courses.length) {
      return Container();
    } else {
      var selectedCourse = courses[selectedCourseIndex];
      return BlocBuilder<ProgressBloc, ProgressState>(
          builder: (context, state) {
        var courseId = selectedCourse.id;
        if (state.isLoading[courseId] == true ||
            !state.progress.containsKey(courseId)) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          var progress = state.progress[courseId];
          if (progress != null) {
            return Graph(progress: progress);
          } else {
            return const Center(
              child: Text("You are not subscribed to this course"),
            );
          }
        }
      });
    }
  }

  Widget buildGraphAndButtons(BuildContext context, ScreenModel screenModel) {
    if (screenModel == ScreenModel.large) {
      return Container(
        margin: const EdgeInsets.symmetric(
          vertical: 15,
        ),
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromARGB(255, 245, 245, 245),
                  ),
                ),
                child: buildGraph(context),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 15,
              ),
              width: 450,
              child: Column(
                children: [
                  Expanded(child: buildButtons()),
                  TextButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.resolveWith(
                        (states) => const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.zero,
                          ),
                        ),
                      ),
                    ),
                    onPressed: () {},
                    child: Container(
                      width: double.infinity,
                      alignment: const Alignment(0, 0),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: const Text('Transfer'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    } else {
      return Container(
        margin: const EdgeInsets.symmetric(
          vertical: 15,
        ),
        child: Column(
          children: [
            Container(
              height: 400,
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromARGB(255, 245, 245, 245),
                ),
              ),
              child: buildGraph(context),
            ),
            Container(
              margin: const EdgeInsets.only(
                top: 15,
              ),
              child: Column(
                children: [
                  buildSmallScreenButtons(),
                  TextButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.resolveWith(
                        (states) => const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.zero,
                          ),
                        ),
                      ),
                    ),
                    onPressed: () {},
                    child: Container(
                      width: double.infinity,
                      alignment: const Alignment(0, 0),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: const Text('Transfer'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget buildButtons() {
    return Column(
      children: [
        Expanded(
          child: Row(
            children: [
              Expanded(child: buildButton(Icons.copy, "Courses")),
              Expanded(child: buildButton(Icons.star, "Favorites")),
              Expanded(child: buildButton(Icons.explore, "Explore")),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              Expanded(
                  child: buildButton(Icons.notifications, "Notifications")),
              Expanded(child: buildButton(Icons.warning, "Alerts")),
              Expanded(child: buildButton(Icons.lightbulb_outline, "Tips")),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildSmallScreenButtons() {
    return Column(
      children: [
        SizedBox(
          height: 90,
          child: Row(
            children: [
              Expanded(child: buildButton(Icons.copy, "Courses")),
              Expanded(child: buildButton(Icons.star, "Favorites")),
              Expanded(child: buildButton(Icons.explore, "Explore")),
            ],
          ),
        ),
        SizedBox(
          height: 90,
          child: Row(
            children: [
              Expanded(
                  child: buildButton(Icons.notifications, "Notifications")),
              Expanded(child: buildButton(Icons.warning, "Alerts")),
              Expanded(child: buildButton(Icons.lightbulb_outline, "Tips")),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildButton(IconData icon, String text) {
    return Container(
      margin: const EdgeInsets.all(15),
      alignment: const Alignment(0, 0),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromARGB(255, 235, 235, 235),
        ),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(10, 0, 0, 0),
            blurRadius: 1,
            spreadRadius: 0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      height: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Icon(
              icon,
              color: Colors.grey,
            ),
            margin: const EdgeInsets.only(bottom: 10),
          ),
          Text(
            text,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ],
      ),
    );
  }

  Widget buildMain(BuildContext context, ScreenModel screenModel) {
    if (screenModel == ScreenModel.large) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildHeader(screenModel),
          buildTitle(),
          buildCoursesList(context),
          Expanded(child: buildGraphAndButtons(context, screenModel)),
        ],
      );
    } else {
      return ListView(
        children: [
          buildHeader(screenModel),
          buildTitle(),
          buildCoursesList(context),
          buildGraphAndButtons(context, screenModel),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        var screenModel = checkScreenModel(constraints);
        if (screenModel == ScreenModel.small) {
          return Scaffold(
            drawer: const MyDrawer(width: 50),
            body: Container(
              margin: const EdgeInsets.only(left: 15, right: 15, bottom: 25),
              child: buildMain(context, screenModel),
            ),
          );
        } else {
          return Provider<DrawerWidthSetter>(
            create: (_) {
              return (double width) {
                setState(() {
                  drawerWidth = width;
                });
              };
            },
            child: Row(
              children: [
                MyDrawer(width: drawerWidth),
                Expanded(
                  child: Scaffold(
                    body: Container(
                      margin: const EdgeInsets.only(
                          left: 15, right: 15, bottom: 25),
                      child: buildMain(context, screenModel),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
