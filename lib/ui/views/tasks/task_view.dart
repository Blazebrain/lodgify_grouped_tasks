import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lodgify/ui/shared/colors.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:stacked/stacked.dart';

import 'tasks_viewmodel.dart';
import 'widgets/task_group_display_widget.dart';

class TasksView extends StatelessWidget {
  const TasksView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ViewModelBuilder<TasksViewModel>.reactive(
      viewModelBuilder: () => TasksViewModel(),
      onModelReady: (viewModel) => viewModel.setUp(),
      builder: (context, viewModel, child) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: AppColors.backgroundColor,
            body: viewModel.isBusy
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CircularProgressIndicator(
                          color: AppColors.leafColor,
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          'Loading tasks...',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20.sm,
                          ),
                        ),
                      ],
                    ),
                  )
                : Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 24, vertical: 24.h),
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.r),
                          color: AppColors.whiteColor,
                          border: Border.all(
                            color: AppColors.greyColor,
                            width: 1.5.w,
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 32.h,
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 12.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(8.0.r),
                                      child: Text(
                                        'Lodgify Grouped Tasks',
                                        style: TextStyle(
                                          fontSize: 16.0.sm,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 4.h),
                                    Stack(
                                      children: [
                                        LinearPercentIndicator(
                                          lineHeight: 24.0.h,
                                          animateFromLastPercent: true,
                                          percent: viewModel
                                              .progressValueInPercentage,
                                          barRadius: const Radius.circular(16),
                                          backgroundColor: AppColors.leafColor
                                              .withOpacity(0.2),
                                          progressColor: AppColors.leafColor,
                                        ),
                                        Positioned(
                                          left: viewModel
                                                      .progressValueInPercentage >
                                                  0.05
                                              ? viewModel
                                                      .progressValueInPercentage *
                                                  (size.width - 180.w)
                                              : 40,
                                          child: Text(
                                            '${viewModel.progressValue.toInt()}%',
                                            style: TextStyle(
                                              color: AppColors.whiteColor,
                                              fontSize: 16.0.sm,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 16.h),
                              TaskGroupDisplayWidget(
                                viewModel: viewModel,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
          ),
        );
      },
    );
  }
}
