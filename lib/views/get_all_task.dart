import 'package:flutter/material.dart';
import 'package:flutter_b9_api/models/task_list.dart';
import 'package:flutter_b9_api/providers/token.dart';
import 'package:flutter_b9_api/services/task.dart';
import 'package:flutter_b9_api/views/create_task.dart';
import 'package:flutter_b9_api/views/get_completed_task.dart';
import 'package:flutter_b9_api/views/get_incompleted_task.dart';
import 'package:flutter_b9_api/views/update_task.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

class GetAllTaskView extends StatefulWidget {
  const GetAllTaskView({super.key});

  @override
  State<GetAllTaskView> createState() => _GetAllTaskViewState();
}

class _GetAllTaskViewState extends State<GetAllTaskView> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    var tokenProvider = Provider.of<TokenProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Get All Task"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => GetCompletedTaskView()));
              },
              icon: Icon(Icons.circle)),
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => GetInCompletedTaskView()));
              },
              icon: Icon(Icons.incomplete_circle)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CreateTaskView()));
        },
        child: Icon(Icons.add),
      ),
      body: LoadingOverlay(
        isLoading: isLoading,
        child: FutureProvider.value(
          value:
              TaskServices().getAllTasks(tokenProvider.getToken().toString()),
          initialData: TaskListingModel(),
          builder: (context, child) {
            TaskListingModel taskListingModel =
                context.watch<TaskListingModel>();
            return taskListingModel.tasks == null
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: taskListingModel.tasks!.length,
                    itemBuilder: (context, i) {
                      return ListTile(
                        leading: Icon(Icons.task),
                        title: Text(
                            taskListingModel.tasks![i].description.toString()),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => UpdateTaskView(
                                              taskModel:
                                                  taskListingModel.tasks![i])));
                                },
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.blue,
                                )),
                            IconButton(
                                onPressed: () async {
                                  try {
                                    isLoading = true;
                                    setState(() {});
                                    await TaskServices()
                                        .deleteTask(
                                            token: tokenProvider
                                                .getToken()
                                                .toString(),
                                            taskID: taskListingModel
                                                .tasks![i].id
                                                .toString())
                                        .then((val) {
                                      isLoading = false;
                                      setState(() {});
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  "Task has been deleted successfully")));
                                    });
                                  } catch (e) {
                                    isLoading = false;
                                    setState(() {});
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text(e.toString())));
                                  }
                                },
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                )),
                          ],
                        ),
                      );
                    });
          },
        ),
      ),
    );
  }
}
