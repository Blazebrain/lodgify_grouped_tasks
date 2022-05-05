import 'package:flutter/foundation.dart';

import 'task_model.dart';

class TasksGroup {
  String? name;
  List<Tasks>? tasks;
  bool isOpen = false;

  TasksGroup({this.name, this.tasks});

  TasksGroup.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['tasks'] != null) {
      tasks = <Tasks>[];
      json['tasks'].forEach((v) {
        tasks!.add(Tasks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    if (tasks != null) {
      data['tasks'] = tasks!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TasksGroup &&
        other.name == name &&
        listEquals(other.tasks, tasks) &&
        other.isOpen == isOpen;
  }

  @override
  int get hashCode => name.hashCode ^ tasks.hashCode ^ isOpen.hashCode;
}
