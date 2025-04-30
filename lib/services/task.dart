import 'dart:convert';

import 'package:flutter_b9_api/models/task.dart';
import 'package:flutter_b9_api/models/task_list.dart';
import 'package:http/http.dart' as http;

class TaskServices {
  String baseUrl = "https://todo-nu-plum-19.vercel.app";

  ///Create Task
  Future<TaskModel> createTask(
      {required String token, required String description}) async {
    try {
      http.Response response = await http.post(Uri.parse('$baseUrl/todos/add'),
          headers: {'Content-Type': 'application/json', 'Authorization': token},
          body: jsonEncode({"description": description}));

      if (response.statusCode == 200 || response.statusCode == 201) {
        return TaskModel.fromJson(jsonDecode(response.body));
      } else {
        throw response.reasonPhrase.toString();
      }
    } catch (e) {
      throw e.toString();
    }
  }

  ///Get All Tasks
  Future<TaskListingModel> getAllTasks(String token) async {
    try {
      http.Response response = await http.get(Uri.parse('$baseUrl/todos/get'),
          headers: {'Authorization': token});

      if (response.statusCode == 200 || response.statusCode == 201) {
        return TaskListingModel.fromJson(jsonDecode(response.body));
      } else {
        throw response.reasonPhrase.toString();
      }
    } catch (e) {
      throw e.toString();
    }
  }

  ///Get Completed Tasks
  Future<TaskListingModel> getCompletedTasks(String token) async {
    try {
      http.Response response = await http.get(
          Uri.parse('$baseUrl/todos/completed'),
          headers: {'Authorization': token});

      if (response.statusCode == 200 || response.statusCode == 201) {
        return TaskListingModel.fromJson(jsonDecode(response.body));
      } else {
        throw response.reasonPhrase.toString();
      }
    } catch (e) {
      throw e.toString();
    }
  }

  ///Get In Completed Tasks
  Future<TaskListingModel> getInCompletedTasks(String token) async {
    try {
      http.Response response = await http.get(
          Uri.parse('$baseUrl/todos/incomplete'),
          headers: {'Authorization': token});

      if (response.statusCode == 200 || response.statusCode == 201) {
        return TaskListingModel.fromJson(jsonDecode(response.body));
      } else {
        throw response.reasonPhrase.toString();
      }
    } catch (e) {
      throw e.toString();
    }
  }

  ///Search Tasks
  Future<TaskListingModel> searchTask(
      {required String token, required String searchKey}) async {
    try {
      http.Response response = await http.get(
          Uri.parse('$baseUrl/todos/search?keywords=$searchKey'),
          headers: {'Authorization': token});

      if (response.statusCode == 200 || response.statusCode == 201) {
        return TaskListingModel.fromJson(jsonDecode(response.body));
      } else {
        throw response.reasonPhrase.toString();
      }
    } catch (e) {
      throw e.toString();
    }
  }

  ///Filter Task
  Future<TaskListingModel> filterTask(
      {required String token,
      required String startDate,
      required String endDate}) async {
    try {
      http.Response response = await http.get(
          Uri.parse(
              '$baseUrl/todos/filter?startDate=$startDate&endDate=$endDate'),
          headers: {'Authorization': token});

      if (response.statusCode == 200 || response.statusCode == 201) {
        return TaskListingModel.fromJson(jsonDecode(response.body));
      } else {
        throw response.reasonPhrase.toString();
      }
    } catch (e) {
      throw e.toString();
    }
  }

  ///Delete Task
  Future<bool> deleteTask(
      {required String token, required String taskID}) async {
    try {
      http.Response response = await http.delete(
          Uri.parse('$baseUrl/todos/delete/$taskID'),
          headers: {'Authorization': token});

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        throw response.reasonPhrase.toString();
      }
    } catch (e) {
      throw e.toString();
    }
  }

  ///Update Task
  Future<bool> updateTask(
      {required String token,
      required String taskID,
      required String description}) async {
    try {
      http.Response response = await http.patch(
          Uri.parse('$baseUrl/todos/update/$taskID'),
          headers: {'Authorization': token, 'Content-Type': 'application/json'},
          body: jsonEncode({'description': description}));

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        throw response.reasonPhrase.toString();
      }
    } catch (e) {
      throw e.toString();
    }
  }
}
