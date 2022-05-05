import 'package:flutter/material.dart';
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
        color: Colors.white,
        border: Border.all(
          color: Colors.grey.shade300,
          width: 1.5,
        ),
      ),
      child: ListView.builder(
        controller: viewModel.scrollController,
        shrinkWrap: true,
        itemCount: viewModel.tasksList.length,
        itemBuilder: (context, index) {
          final group = viewModel.tasksList[index];
          return Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              border: Border(
                bottom: group.isOpen || viewModel.tasksList.last == group
                    ? BorderSide.none
                    : BorderSide(
                        color: Colors.grey.shade200,
                        width: 1.5,
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
                      color: Colors.grey.shade500,
                    ),
                  ),
                  Icon(
                    group.isOpen
                        ? Icons.keyboard_arrow_down
                        : Icons.keyboard_arrow_up,
                    color: Colors.grey.shade500,
                  ),
                ],
              ),
              leading: Image.asset(PngAssets.clipboardImage),
              onExpansionChanged: (value) {
                viewModel.updatedValue(value, index);
              },
              title: Text(
                group.name!,
                style: TextStyle(
                  color:
                      viewModel.listOfGroupsWithAllTasksChecked.contains(group)
                          ? Colors.green
                          : Colors.black,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              children: group.tasks!
                  .map(
                    (e) => ListTile(
                      shape: Border.all(color: Colors.white),
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
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
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
