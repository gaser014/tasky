part of 'bloc.dart';

class TasksStates {}

class TasksLoadingState extends TasksStates {}

class TasksSuccessState extends TasksStates {
   List<TaskModel> model;
final TaskType type;
  TasksSuccessState({
    required this.model,
    required this.type,
  }) {
    switch(type){

      case TaskType.all:
model=model;
        break;
      case TaskType.finished:
model=model.where((element) => element.status.toLowerCase()==DataString.finished.toLowerCase()).toList();
        break;
      case TaskType.inpogress:
model=model.where((element) => element.status.toLowerCase()==DataString.inProgress.toLowerCase()).toList();
        break;
      case TaskType.waiting:
model=model.where((element) => element.status.toLowerCase()==DataString.waiting.toLowerCase()).toList();
        break;
    }
  }
}

class TasksFailedState extends TasksStates {
  final String message;

  TasksFailedState({required this.message}) {
    showMessage(
      message: message,
    );
  }
}
