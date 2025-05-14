import 'package:flutter/material.dart';
import 'package:flutter_b9_api/models/task.dart';
import 'package:flutter_b9_api/providers/token.dart';
import 'package:flutter_b9_api/services/task.dart';
import 'package:flutter_b9_api/views/get_all_task.dart';
import 'package:provider/provider.dart';

class UpdateTaskView extends StatefulWidget {
  final Task taskModel;

  UpdateTaskView({super.key, required this.taskModel});

  @override
  State<UpdateTaskView> createState() => _UpdateTaskViewState();
}

class _UpdateTaskViewState extends State<UpdateTaskView> {
  TextEditingController descriptionController = TextEditingController();

  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    descriptionController =
        TextEditingController(text: widget.taskModel.description.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var tokenProvider = Provider.of<TokenProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Task"),
      ),
      body: Column(
        children: [
          TextField(
            controller: descriptionController,
          ),
          SizedBox(
            height: 20,
          ),
          isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ElevatedButton(
                  onPressed: () async {
                    isLoading = true;
                    setState(() {});
                    try {
                      await TaskServices()
                          .updateTask(
                              taskID: widget.taskModel.id.toString(),
                              token: tokenProvider.getToken().toString(),
                              description: descriptionController.text)
                          .then((val) {
                        isLoading = false;
                        setState(() {});
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Message"),
                                content:
                                    Text("Task has been updated successfully"),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    GetAllTaskView()));
                                      },
                                      child: Text("Okay"))
                                ],
                              );
                            });
                      });
                    } catch (e) {
                      isLoading = false;
                      setState(() {});
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(e.toString())));
                    }
                  },
                  child: Text("Update Task"))
        ],
      ),
    );
  }
}
