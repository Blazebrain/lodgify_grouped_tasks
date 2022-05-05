import 'package:flutter/material.dart';
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
        return Scaffold(
          backgroundColor: Colors.grey[300],
          body: viewModel.isBusy
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      CircularProgressIndicator(
                        color: AppColors.leafColor,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Loading tasks...',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                )
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.5,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 32,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 24),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Lodgify Grouped Tasks',
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  SizedBox(
                                    width: size.width - 144,
                                    child: Stack(
                                      children: [
                                        LinearPercentIndicator(
                                          lineHeight: 24.0,
                                          animateFromLastPercent: true,
                                          percent: viewModel
                                              .progressValueInPercentage,
                                          barRadius: const Radius.circular(16),
                                          backgroundColor: Colors.green[100],
                                          progressColor:
                                              const Color(0xFF00B797),
                                        ),
                                        Positioned(
                                          left: viewModel
                                                      .progressValueInPercentage >
                                                  0.05
                                              ? viewModel
                                                      .progressValueInPercentage *
                                                  (size.width - 250)
                                              : 40,
                                          child: Text(
                                            '${viewModel.progressValue.toInt()}%',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 32),
                            TaskGroupDisplayWidget(
                              viewModel: viewModel,
                            )
                          ],
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
