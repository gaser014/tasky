import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/unit/app_strings.dart';
import 'package:tasky/feature/home/tasks/model.dart';

import '../../../core/logic/dio_helper.dart';
import '../../../core/logic/helper_methods.dart';

part 'states.dart';

part 'events.dart';

class TasksBloc extends Bloc<TasksEvents, TasksStates> {
  TasksBloc() : super(TasksStates()) {
    on<TasksEvent>(_getTasks);
  }

  Future<void> _getTasks(
      TasksEvent event, Emitter<TasksStates> emit) async {
    emit(TasksLoadingState());

//5354544545
    final response = await DioHelper()
        .getData(endPoint: 'todos?page=1',haveToken: true);

    if (response.isSuccess) {
      print(response.response!.data);
      emit(TasksSuccessState(
        model:List.from(
          response.response!.data.map((e) => TaskModel.fromJson(e))??[],
        ),
        type: event.type,))      ;
    } else {
      emit(TasksFailedState(
        message: response.message,
      ));
    }
  }

}
