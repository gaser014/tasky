import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tasky/core/unit/app_assets.dart';
import 'package:tasky/core/unit/app_strings.dart';
import 'package:tasky/core/widget/app_image.dart';
import 'package:tasky/core/widget/app_menu.dart';
import 'package:tasky/feature/home/tasks/bloc.dart';

import '../../core/logic/helper_methods.dart';
import '../../core/unit/routes.dart';
part 'app_ bar.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  TaskType taskType = TaskType.all;
  Color color = const Color(0xffF0ECFF);
  late final TasksBloc bloc;

  final List<TaskType> tasks = [
    TaskType.all,
    TaskType.finished,
    TaskType.waiting,
    TaskType.inpogress,
  ];

  @override
  void initState() {
    bloc = TasksBloc();
    bloc.add(TasksEvent(
      taskType,
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const _HomeAppBar(),
      body: Padding(
        padding: EdgeInsets.all(22.0.r),
        child: Stack(
          children: [
            ListView(
              children: [
                Text(
                  DataString.myTasks,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 16.h),
                SizedBox(
                  height: 40.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      tasks.length,
                      (index) => Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(24.r),
                          child: FilledButton(
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(
                                taskType == tasks[index]
                                    ? Theme.of(context).primaryColor
                                    : color,
                              ),
                              padding: WidgetStateProperty.all(
                                EdgeInsets.all(4.r),
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                taskType = tasks[index];
                                bloc.add(TasksEvent(
                                  taskType,
                                ));
                              });
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                              child: Text(
                                tasks[index]
                                        .toString()
                                        .split('.')
                                        .last[0]
                                        .toUpperCase() +
                                    tasks[index]
                                        .toString()
                                        .split('.')
                                        .last
                                        .substring(1)
                                        .toLowerCase(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16.sp,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                BlocConsumer(
                  listener: (context, state) {},
                  bloc: bloc,
                  builder: (context, state) {
                    if (state is TasksLoadingState) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (state is TasksFailedState) {
                      return Center(
                        child: Text(state.message),
                      );
                    }
                    if (state is TasksSuccessState) {
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.model.length,
                          padding: EdgeInsets.symmetric(vertical: 8.h),
                          itemBuilder: (context, index) {
                            return SizedBox(
                              height: 100.h,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: AppImage(
                                      path: state.model[index].image,
                                      fit: BoxFit.cover,
                                      width: 64,
                                      height: 64,
                                    ),
                                  ),
                                  SizedBox(width: 12.w),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 28.h,
                                        width: 236.w,
                                        child: Row(
                                          children: [
                                            Text(
                                              state.model[index].title,
                                              style: TextStyle(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w700,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const Spacer(),
                                            Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 6.w,
                                                    vertical: 2.h),
                                                decoration: BoxDecoration(
                                                  color: state.model[index]
                                                      .taskTypeColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.r),
                                                ),
                                                child: Text(
                                                  state.model[index].status,
                                                  style: TextStyle(
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.w500,
                                                    color: state.model[index]
                                                        .taskTypeFontColor,
                                                  ),
                                                )),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 4.h),
                                      SizedBox(
                                        width: 236.w,
                                        child: Text(
                                          state.model[index].desc,
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400,
                                            color: const Color(0xff24252C),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      SizedBox(height: 4.h),
                                      SizedBox(
                                          height: 18.h,
                                          width: 236.w,
                                          child: Row(
                                            children: [
                                              AppImage(
                                                path: DataAssets.flag,
                                                fit: BoxFit.scaleDown,
                                                width: 16.w,
                                                height: 16.h,
                                                color: state.model[index]
                                                    .taskPriorityFontColor,
                                              ),
                                              SizedBox(width: 4.w),
                                              Text(
                                                state.model[index].priority,
                                                style: TextStyle(
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w500,
                                                  color: state.model[index]
                                                      .taskPriorityFontColor,
                                                ),
                                              ),
                                              const Spacer(),
                                              Text(
                                                state.model[index].createdAt,
                                                style: TextStyle(
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w400,
                                                  color:
                                                      const Color(0xff24252C),
                                                ),
                                              ),
                                            ],
                                          ))
                                    ],
                                  ),
                                  SizedBox(width: 12.w),
                                  const Spacer(),
                                  AppMenu(
                                    scale: .8,
                                    id: state.model[index].sId,
                                    onPop: () {
                                      bloc.add(TasksEvent(taskType));
                                    },
                                  ),
                                ],
                              ),
                            );
                          });
                    }
                    return const SizedBox();
                  },
                ),
              ],
            ),
            PositionedDirectional(
              end: 32.w,
              bottom: 110.h,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusDirectional.circular(24.r),
                  color: Color(0xffEBE5FF),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 32,
                      offset: const Offset(0, 4), // changes position of shadow
                    ),
                  ],
                ),
                width: 50.r,
                height: 50.r,
                child: AppImage(
                  path: DataAssets.scan,
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
            PositionedDirectional(
              end: 24.w,
              bottom: 32.h,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusDirectional.circular(32.r),
                  color: Theme.of(context).primaryColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.34),
                      blurRadius: 32,
                      offset: const Offset(0, 4), // changes position of shadow
                    ),
                  ],
                ),
                width: 64.r,
                height: 64.r,
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 32.r,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

