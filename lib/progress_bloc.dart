import 'package:dashboard_fun/course_model.dart';
import 'package:dashboard_fun/i_progress_repository.dart';
import 'package:dashboard_fun/not_found.dart';
import 'package:dashboard_fun/progress_model.dart';
import 'package:dashboard_fun/progress_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProgressBloc extends Cubit<ProgressState> {
  Map<int, ProgressModel?> progress = {};
  Map<int, bool> isLoading = {};
  IProgressRepository repository;

  ProgressBloc(IProgressRepository iRepository)
      : repository = iRepository,
        super(ProgressState(isLoading: const {}, progress: const {}));

  Future<ProgressModel?> fetchProgress(CourseModel courseModel) async {
    if (progress.containsKey(courseModel.id)) {
      return progress[courseModel.id];
    } else {
      try {
        isLoading[courseModel.id] = true;
        emit(ProgressState(isLoading: isLoading, progress: progress));
        progress[courseModel.id] =
            await repository.fetchProgress(courseModel.id);
      } on NotFound {
        progress[courseModel.id] = null;
      } finally {
        isLoading[courseModel.id] = false;
        emit(ProgressState(isLoading: isLoading, progress: progress));
      }
      return progress[courseModel.id];
    }
  }
}
