import 'dart:math';

import 'package:dashboard_fun/i_progress_repository.dart';
import 'package:dashboard_fun/not_found.dart';
import 'package:dashboard_fun/progress_model.dart';

class MockProgressRepository extends IProgressRepository {
  Map<int, ProgressModel> progresses;
  MockProgressRepository(int numberOfCourses) : progresses = {} {
    var random = Random(0);
    for (int i = 0; i < numberOfCourses; i++) {
      progresses[i] = ProgressModel(
        janNumberOfVideos: random.nextInt(50),
        febNumberOfVideos: random.nextInt(50),
        marNumberOfVideos: random.nextInt(50),
        aprNumberOfVideos: random.nextInt(50),
        mayNumberOfVideos: random.nextInt(50),
        junNumberOfVideos: random.nextInt(50),
        julNumberOfVideos: random.nextInt(50),
        augNumberOfVideos: random.nextInt(50),
        sepNumberOfVideos: random.nextInt(50),
        octNumberOfVideos: random.nextInt(50),
        novNumberOfVideos: random.nextInt(50),
        decNumberOfVideos: random.nextInt(50),
      );
    }
  }

  @override
  Future<ProgressModel> fetchProgress(int courseId) async {
    await Future.delayed(const Duration(seconds: 1));
    var progress = progresses[courseId];
    if (progress != null) {
      return progress;
    } else {
      throw NotFound();
    }
  }
}
