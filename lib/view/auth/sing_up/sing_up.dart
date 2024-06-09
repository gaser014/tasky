import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tasky/core/widget/app_input.dart';

import '../../../core/logic/get_it.dart';
import '../../../core/logic/helper_methods.dart';
import '../../../core/unit/app_assets.dart';
import '../../../core/unit/app_strings.dart';
import '../../../core/unit/routes.dart';
import '../../../core/widget/app_button.dart';
import '../../../core/widget/app_image.dart';
import '../../../feature/auth/register/bloc.dart';

class SingUpView extends StatefulWidget {
  SingUpView({super.key});

  @override
  State<SingUpView> createState() => _SingUpViewState();
}

class _SingUpViewState extends State<SingUpView> {
  final formKey = GlobalKey<FormState>();
  String? levelOfExperience;
  late final RegisterBloc bloc;

  final phoneController = TextEditingController();

  final nameController = TextEditingController();

  final addressController = TextEditingController();

  final yearOfExpController = TextEditingController();


  final passwordController = TextEditingController();
  final List<String> levelOfExperiences = [
    DataString.fresh,
    DataString.junior,
    DataString.midLevel,
    DataString.senior,
  ];
@override
  void initState() {
    bloc = getIt<RegisterBloc>();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
      key: formKey,
      child: ListView(
        children: [
          SizedBox(
            height: 343.h,
            width: double.infinity,
            child: Stack(
              children: [
                PositionedDirectional(
                  height: 343.h,
                  width: 256.w,
                  start: 62.w,
                  child: Image.asset(
                    height: 482.h,
                    width: 375.w,
                    DataAssets.imagesIntro,
                    fit: BoxFit.fill,
                  ),
                ),
                PositionedDirectional(
                  top: 200.h,
                  width: 1.sw,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.0.w),
                        child: Text(
                          DataString.register,
                          style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xff24252C),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      AppInput(
                        label: DataString.name,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return DataString.empty(DataString.name);
                          }
                          return null;
                        },
                        controller: nameController,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          CountryPhone(
            phoneController: phoneController,
          ),
          AppInput(
            label: DataString.yearsOfExperience,
            validator: (value) {
              if (value == null || value.isEmpty|| (int.tryParse(value)??0)<0 ){
                return DataString.empty(DataString.yearsOfExperience);
              }
              return null;
            },
            controller: yearOfExpController,
          ),
          SizedBox(
            height: 24.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: const Color(0xffBABABA).withOpacity(.2),
                ),
              ),
              margin: EdgeInsets.zero,
              child: DropdownButton<String>(
                isExpanded: true,
                borderRadius: BorderRadius.circular(8.r),
                padding: EdgeInsets.zero,
                elevation: 0,
                dropdownColor: Colors.white,
                underline: Container(),
                onChanged: (value) {
                  setState(() {
                    levelOfExperience = value;
                  });
                },
                value: levelOfExperience,
                icon: SizedBox(
                  width: 1.sw - 60.w,
                  child: Row(
                    children: [
                      Text(
                        levelOfExperience ?? DataString.levelOfExperience,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xff2F2F2F),
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        Icons.keyboard_arrow_down_sharp,
                        color: const Color(0xff7F7F7F),
                        size: 24.w,
                      ),
                    ],
                  ),
                ),
                items: List.generate(levelOfExperiences.length, (index) {
                  return DropdownMenuItem(
                    value: levelOfExperiences[index].toUpperCase(),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Text(
                        levelOfExperiences[index].toUpperCase(),
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xff7F7F7F),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
          SizedBox(
            height: 24.h,
          ),
          AppInput(
            label: DataString.address,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return DataString.empty(DataString.address);
              }
              return null;
            },
            controller: addressController,
          ),
          SizedBox(
            height: 24.h,
          ),
          AppInput(
            label: DataString.password,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return DataString.empty(DataString.password);
              } else if (value.length < 6) {
                return 'Password must be at least 6 characters';
              }
              return null;
            },
            controller: passwordController,
            isPassword: true,
            isEnable: true,
          ),
          SizedBox(
            height: 24.h,
          ),
          BlocConsumer(
            builder: (BuildContext context, state) {
              return AppButton(
                onPressed: () {
                  if (formKey.currentState!.validate() &&
                      phoneController.text.isNotEmpty&&
                      levelOfExperience != null
                  ) {
                    bloc.add(RegisterEvent(
                      phone: phoneController.text,
                      level: levelOfExperience!,
                      experienceYears:
                          int.tryParse(yearOfExpController.text) ?? 0,
                      password: passwordController.text,
                      address: addressController.text,
                      displayName: nameController.text,
                    ));

                  }
                  else{
                    showMessage(message: 'Please fill all fields', type: MassageType.warning);
                }},
                text: DataString.singUp,
                icon: SizedBox(
                    height: 24.h,
                    width: 24.w,
                    child: const AppImage(
                      path: DataAssets.arrow,
                      fit: BoxFit.scaleDown,
                    )),
                isLoading: state is RegisterLoadingState,
              );
            },
            bloc: bloc,
            listener: (BuildContext context, Object? state) {
              if (state is RegisterSuccessState) {
                GoRouter.of(context).go(AppRouter.rOnBoarding);
              }

            },
          ),
          SizedBox(
            height: 24.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  DataString.haveAccount,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xff7F7F7F),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    GoRouter.of(context).go(AppRouter.rLogIn);
                  },
                  child: Text(
                    DataString.signIn,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                SizedBox(
                  height: 32.h,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 32.h,
          ),
        ],
      ),
    ));
  }
}
