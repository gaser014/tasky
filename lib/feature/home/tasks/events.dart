part of 'bloc.dart';

class TasksEvents {}

class TasksEvent extends TasksEvents {
  TaskType type;
  TasksEvent(
    this.type,
      );
}
