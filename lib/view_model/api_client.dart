import 'dart:isolate';

import 'package:dio/dio.dart';
import 'package:flutter_todo/model/login_data.dart';
import 'package:flutter_todo/model/todo_data.dart';
import 'package:flutter_todo/model/todo_response.dart';
import 'package:flutter_todo/model/user_data.dart';

class ApiClient {
  final Dio _dioClient = Dio();
  final devBaseUrl = 'https://dummyjson.com';
  final baseUrl = 'http://141.94.78.248:8750';
  final login = 'api/auth/login';
  final listTodo = 'api/todos';
  final addTodo = 'api/todos/add';

  Future<UserData> loginUserService(LoginData loginData) async {
    _dioClient.interceptors.add(LogInterceptor(
        responseBody: true, responseHeader: false,
        requestHeader: false, request: false
    ));
    Response response = await _dioClient.post('$baseUrl/$login', data: loginData.toJson());
    if(response.statusCode == 200){
      return UserData.fromJson(response.data);
    } else {
      throw 'Failed Get Data From Server';
    }
  }


  Future<List<TodoData>> fetchListTodoService(String userAccess) async {
    _dioClient.interceptors.add(LogInterceptor(
        responseBody: true, responseHeader: false,
        requestHeader: true, request: false
    ));
    Response response = await _dioClient.get('$baseUrl/$listTodo',
        options: Options(headers: {'Content-Type': 'application/json', 'Authorization': userAccess})
    );
    if(response.statusCode == 200){
      return (response.data as List).map((e) => TodoData.fromJson(e)).toList();
    } else {
      throw 'Failed Get Data From Server';
    }
  }


  Future<TodoData> addTodoService(TodoData todoData, String userAccess) async {
    _dioClient.interceptors.add(LogInterceptor(
        responseBody: true, responseHeader: false,
        requestHeader: false, request: false
    ));
    Response response = await _dioClient.post('$baseUrl/$addTodo', data: todoData.toJson(),
        options: Options(headers: {'Content-Type': 'application/json', 'Authorization': userAccess})
    );
    if(response.statusCode == 201){
      return TodoData.fromJson(response.data);
    } else {
      throw 'Failed Get Data From Server';
    }
  }

  Future<TodoData> updateTodoService(TodoData todoData, int completed, userAccess) async {
    _dioClient.interceptors.add(LogInterceptor(
        responseBody: true, responseHeader: false,
        requestHeader: true, request: false
    ));
    Response response = await _dioClient.put('$baseUrl/$listTodo/${todoData.id}', data: {'completed': completed},
        options: Options(headers: {'Content-Type': 'application/json', 'Authorization': userAccess})
    );
    if(response.statusCode == 200){
      return TodoData.fromJson(response.data);
    } else {
      throw 'Failed Get Data From Server';
    }
  }

}




