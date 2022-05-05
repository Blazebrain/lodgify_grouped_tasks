import 'package:lodgify/services/api/api.dart';
import 'package:lodgify/services/api/api_service.dart';
import 'package:lodgify/services/tasks/tasks.dart';
import 'package:lodgify/services/tasks/tasks_service.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(
  dependencies: [
    LazySingleton(classType: TasksService, asType: ITasks),
    LazySingleton(classType: ApiService, asType: IApi),
    LazySingleton(classType: SnackbarService),
  ],
  logger: StackedLogger(),
)
class AppSetup {}
