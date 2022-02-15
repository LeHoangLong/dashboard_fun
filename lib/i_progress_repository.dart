import 'package:dashboard_fun/progress_model.dart';

abstract class IProgressRepository {
  // throw NotFound if courseId not found
  Future<ProgressModel> fetchProgress(int courseId);
}
