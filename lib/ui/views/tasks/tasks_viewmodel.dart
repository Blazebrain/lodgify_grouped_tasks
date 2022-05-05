import 'package:flutter/cupertino.dart';
import 'package:lodgify/model/task_model.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.logger.dart';
import '../../../model/tasks_group_model.dart';
import '../../../services/tasks/tasks.dart';

class TasksViewModel extends BaseViewModel {
  final log = getLogger('TasksViewModel');
  final _tasksService = locator<ITasks>();

  List<TasksGroup> taskGroupsList = [];
  List<TasksGroup> listOfGroupsOpenedGroups = [];
  List<TasksGroup> listOfGroupsWithAllTasksChecked = [];

  String? trailingText = 'Show';
  double totalTaskValue = 0.0;
  double progressValue = 0.0;
  double progressValueInPercentage = 0.0;
  bool allTasksCheckedForGroup = false;
  ScrollController scrollController = ScrollController();

  /// Sets the viewModel to the busy state, enabling
  /// us to display a loading indicator while the data #
  /// is being fetched from the API
  ///
  Future<void> setUp() async {
    await runBusyFuture(runTasks());
  }

  /// Contains the list of tasks we want to initiate
  /// immediately the page comes up
  ///
  Future<void> runTasks() async {
    // First, fetch the list of TasksGroups from the TaskService
    taskGroupsList = await _tasksService.getTasks();

    // Next, get the sum of all the tasks
    getSumOfAllTasks(taskGroupsList);

    // Lastly, get the initial value for the progress bar
    getInitialProgressBarValue(taskGroupsList);
  }

  /// Get the sum of all the task values for all the groups
  /// returned from the API
  ///
  void getSumOfAllTasks(List<TasksGroup> tasksGroupList) {
    for (var taskGroup in tasksGroupList) {
      for (var task in taskGroup.tasks!) {
        totalTaskValue = totalTaskValue + task.value!;
      }
    }

    log.i('sum of all tasks: $totalTaskValue');
  }

  /// Get the initial value for the progress bar using
  /// the [totalTaskValue] and the checked status for
  /// each task returned from the API
  ///
  void getInitialProgressBarValue(List<TasksGroup> tasksGroupList) {
    for (var taskGroup in tasksGroupList) {
      for (var task in taskGroup.tasks!) {
        if (task.checked == true) {
          final normalizedValue = getNormalizedValue(task.value!);
          increaseProgressValue(normalizedValue!);
          log.i('progressValue: $progressValue');
        }
      }
    }
  }

  /// Guiding Formula: $Nt = Vt * 100 / ∑(Vt)
  ///
  /// Where :
  ///
  ///      Nt = normalizedValue
  ///      Vt = taskValue
  ///      ∑(Vt) = Sum of all tasksValue
  double? getNormalizedValue(int taskValue) {
    double normalizedValue = (taskValue * 100 / totalTaskValue).roundToDouble();
    log.i('=====>>> Logging relevant parameters<<<======');
    log.i('taskValue: $taskValue');
    log.i('totalTaskValue: $totalTaskValue');
    log.i('normalizedValue: $normalizedValue');

    return normalizedValue;
  }

  /// Increase the [progressValue] if the box is checked
  ///
  void increaseProgressValue(double normalizedValue) {
    progressValue = progressValue + normalizedValue;
    progressValueInPercentage = progressValue / 100;

    log.i('=====>>> Logging relevant parameters<<<======');
    log.i('normalizedValue: $normalizedValue');
    log.i('progressValue: $progressValue');
    notifyListeners();
  }

  /// Increase the [progressValue] if the box is unchecked
  ///
  void decreaseProgressValue(double normalizedValue) {
    progressValue = progressValue - normalizedValue;
    progressValueInPercentage = progressValue.abs() / 100;

    log.i('=====>>> Logging relevant parameters<<<======');
    log.i('normalizedValue: $normalizedValue');
    log.i('progressValue: $progressValue');
    notifyListeners();
  }

  /// Updates the checked value(true/false) of a particular
  /// task and then get the normalized value for the progress
  /// bar using the task value.
  ///
  /// It first gets the NormalizedValue for this particular task
  /// and then uses that value to determine the progress
  void updateTaskCheckedValue(TasksGroup group, Tasks task, bool value) {
    final normalizedValueForTask = getNormalizedValue(task.value!);

    if (value == true) {
      task.checked = value;
      increaseProgressValue(normalizedValueForTask ?? 0);
      updateGroupColor(group);
      notifyListeners();
    } else {
      task.checked = value;
      decreaseProgressValue(normalizedValueForTask ?? 0);
      updateGroupColor(group);
      notifyListeners();
    }
  }

  void updatedValue(bool? value, index) {
    taskGroupsList[index].isOpen = value ?? false;
    notifyListeners();
  }

  /// Updates the Color of the taskGroup if all its
  /// tasks are checked. It does this by adding the group
  /// to the list of tasksGroup with tasks checked.
  ///
  /// If a group previously had all its task checked, and then a
  /// task was unchecked, it checkes if the task is in the
  /// [listOfGroupsWithAllTasksChecked] and removes it, if it's not
  /// there, it does nothing.
  void updateGroupColor(TasksGroup group) {
    if (group.tasks!.every((element) => element.checked == true)) {
      listOfGroupsWithAllTasksChecked.add(group);
      notifyListeners();
    } else {
      listOfGroupsWithAllTasksChecked.contains(group)
          ? listOfGroupsWithAllTasksChecked.remove(group)
          : null;
      notifyListeners();
    }
  }
}
