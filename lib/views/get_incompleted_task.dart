import 'package:flutter/material.dart';
import 'package:flutter_b9_api/models/task_list.dart';
import 'package:flutter_b9_api/providers/token.dart';
import 'package:flutter_b9_api/services/task.dart';
import 'package:provider/provider.dart';

class GetInCompletedTaskView extends StatelessWidget {
  const GetInCompletedTaskView({super.key});

  @override
  Widget build(BuildContext context) {
    var tokenProvider = Provider.of<TokenProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Get InCompleted Task"),
      ),
      body: FutureProvider.value(
        value: TaskServices()
            .getInCompletedTasks(tokenProvider.getToken().toString()),
        initialData: TaskListingModel(),
        builder: (context, child) {
          TaskListingModel taskListingModel = context.watch<TaskListingModel>();
          return ListView.builder(
              itemCount: taskListingModel.tasks!.length,
              itemBuilder: (context, i) {
                return ListTile(
                  leading: Icon(Icons.task),
                  title:
                      Text(taskListingModel.tasks![i].description.toString()),
                );
              });
        },
      ),
    );
  }
}
