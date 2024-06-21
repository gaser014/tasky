import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tasky/core/unit/app_strings.dart';

import '../../../core/logic/helper_methods.dart';

class TaskModel {
  late final String sId;
  late final String image;
  late final String title;
  late final String desc;
  late final String priority;
  late final String status;
  late final String user;
  late final String createdAt;
  late final String updatedAt;
  late final int iV;
  late final TaskType taskType;
   Color taskTypeFontColor=Colors.white;
  Color taskTypeColor=Colors.white;
  late final TaskPriority taskPriority;
  Color taskPriorityFontColor=Colors.white;
 Color taskPriorityColor =Colors.white;

  TaskModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'] ?? '';
    image = json['image'] ?? '';
    title = firstLetterCapital(json['title'] ?? '');
    desc = json['desc'] ?? '';
    priority = firstLetterCapital(json['priority'].toString());
    status = firstLetterCapital(json['status'] ?? '');
    user = json['user'] ?? '';
    //format date
    createdAt =
        json['createdAt'].substring(0, 10).split('-').reversed.join('/') ?? '';
    updatedAt = json['updatedAt'] ?? '';
    iV = json['__v'] ?? '';
    print('*' * 400);
    print('status is $status');
    if (status.toLowerCase() == DataString.finished.toLowerCase()) {

        taskType = TaskType.finished;
        taskTypeFontColor = const Color(0xff0087FF);
        taskTypeColor = const Color(0xffE3F2FF);


    } else if (status.toLowerCase() == DataString.waiting.toLowerCase()) {

        print('waiting');
        taskType = TaskType.waiting;
        taskTypeFontColor = const Color(0xffFF7D53);
        taskTypeColor = const Color(0xffFFE4F2);

    } else if (status.toLowerCase() == DataString.inProgress.toLowerCase()) {

        taskType = TaskType.inpogress;
        taskTypeFontColor = const Color(0xff5F33E1);
        taskTypeColor = const Color(0xffF0ECFF);

    } else {

        taskType = TaskType.all;
        taskTypeFontColor = Colors.white;
        taskTypeColor = Colors.white;

    }
    if (priority.toLowerCase() == DataString.high.toLowerCase()) {

        taskPriority = TaskPriority.high;
        taskPriorityFontColor = const Color(0xffFF7D53);

    } else if (priority.toLowerCase() == DataString.medium.toLowerCase()) {

        taskPriority = TaskPriority.medium;
        taskPriorityFontColor = const Color(0xff5F33E1);

    } else if (priority.toLowerCase() == DataString.low.toLowerCase()) {

        taskPriority = TaskPriority.low;
        taskPriorityFontColor = const Color(0xff0087FF);

    } else {

        taskPriority = TaskPriority.low;
        taskPriorityFontColor = Colors.white;
        taskPriorityColor = Colors.white;

    }
    print('taskType is ${taskType.toString()}');
  }

  String firstLetterCapital(String text) =>
      text[0].toUpperCase() + text.substring(1).toLowerCase();
}
