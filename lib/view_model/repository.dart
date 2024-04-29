import 'package:flutter_todo/model/login_data.dart';
import 'package:flutter_todo/model/todo_data.dart';
import 'package:flutter_todo/model/todo_response.dart';
import 'package:flutter_todo/model/user_data.dart';
import 'package:flutter_todo/view_model/api_client.dart';

class Repository {
  final ApiClient _client = ApiClient();
  Future<List<TodoData>> getListUser(String userAccess) async {
    return _client.fetchListTodoService(userAccess);
  }

  Future<TodoData> addTodoService(TodoData todoData, String userAccess) async {
    return _client.addTodoService(todoData, userAccess);
  }

  Future<TodoData> updateTodoService(TodoData todoData, int completed, String userAccess) async {
    return _client.updateTodoService(todoData, completed, userAccess);
  }

  Future<UserData> loginService(LoginData loginData) async {
    return _client.loginUserService(loginData);
  }
}
