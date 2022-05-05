import 'dart:convert';

import 'package:lodgify/app/app.locator.dart';
import 'package:lodgify/app/app.logger.dart';
import 'package:lodgify/model/tasks_group_model.dart';
import 'package:lodgify/services/api/api.dart';
import 'package:lodgify/services/tasks/tasks.dart';
import 'package:lodgify/utils/constants/api_constants.dart';

class TasksService implements ITasks {
  final _apiService = locator<IApi>();
  final log = getLogger('TasksService');
  @override
  Future<List<TasksGroup>> getTasks() async {
    List<TasksGroup> tasksGroupList = [];

    final response = await _apiService.get(ApiConstants.fetchMockProgress);
    log.i('Response: $response');
    final decodedResponse = jsonDecode(response);

    for (var item in decodedResponse) {
      tasksGroupList.add(
        TasksGroup.fromJson(item),
      );
    }

    return tasksGroupList;
  }
}
