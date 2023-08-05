import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/shared/components/components.dart';
import 'package:login/shared/cubit/cubit.dart';

import '../../../shared/cubit/states.dart';

class ArchiveTasksScreen extends StatelessWidget {
  const ArchiveTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks = AppCubit.get(context).archiveTasks;
        return tasksBuilder(tasks: tasks);
      },
    );
  }
}
