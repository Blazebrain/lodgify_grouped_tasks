import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lodgify/ui/shared/colors.dart';
import 'package:lodgify/ui/views/tasks/tasks_viewmodel.dart';
import 'package:lodgify/utils/constants/app_assets.dart';

class TaskGroupDisplayWidget extends StatelessWidget {
  final TasksViewModel viewModel;
  const TaskGroupDisplayWidget({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.whiteColor,
        border: Border.all(
          color: AppColors.greyColor.withOpacity(0.3),
          width: 1.5.w,
        ),
      ),
      child: ListView.builder(
        controller: viewModel.scrollController,
        shrinkWrap: true,
        itemCount: viewModel.taskGroupsList.length,
        itemBuilder: (context, index) {
          final group = viewModel.taskGroupsList[index];
          return Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              border: Border(
                bottom: group.isOpen || viewModel.taskGroupsList.last == group
                    ? BorderSide.none
                    : BorderSide(
                        color: AppColors.greyColor.withOpacity(0.3),
                        width: 1.5.w,
                      ),
              ),
            ),
            child: ExpansionTile(
              trailing: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    group.isOpen ? 'Hide' : 'Show',
                    style: TextStyle(
                      color: AppColors.greyColor,
                      fontSize: 14.sm,
                    ),
                  ),
                  Icon(
                    group.isOpen
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: AppColors.greyColor,
                    size: 20.w,
                  ),
                ],
              ),
              leading: viewModel.listOfGroupsWithAllTasksChecked.contains(group)
                  ? Image.asset(PngAssets.completedTaskGroupImage)
                  : Image.asset(PngAssets.unCompletedTaskGroupImage),
              onExpansionChanged: (value) {
                viewModel.updatedValue(value, index);
              },
              title: Text(
                group.name!,
                style: TextStyle(
                  color:
                      viewModel.listOfGroupsWithAllTasksChecked.contains(group)
                          ? AppColors.leafColor
                          : AppColors.blackColor,
                  fontSize: 16.0.sm,
                  fontWeight: FontWeight.w500,
                ),
              ),
              children: group.tasks!
                  .map(
                    (e) => ListTile(
                      shape: Border.all(color: AppColors.whiteColor),
                      leading: Checkbox(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        activeColor: AppColors.leafColor,
                        onChanged: (value) {
                          viewModel.updateTaskCheckedValue(group, e, value!);
                        },
                        value: e.checked,
                      ),
                      title: Text(
                        e.description ?? 'No title available',
                        style: TextStyle(
                          color: AppColors.blackColor,
                          fontSize: 16.0.sm,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          );
        },
      ),
    );
  }
}
