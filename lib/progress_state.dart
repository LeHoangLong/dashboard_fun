import 'package:dashboard_fun/progress_model.dart';

class ProgressState {
  Map<int, bool> isLoading; // key is the course id
  Map<int, ProgressModel?>
      progress; // key is the course id, null for courses without any history
  ProgressState({
    required this.isLoading,
    required this.progress,
  });
}
