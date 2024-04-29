import 'dart:async';

import 'package:flutter_todo/model/login_data.dart';
import 'package:flutter_todo/model/todo_data.dart';
import 'package:flutter_todo/model/todo_response.dart';
import 'package:flutter_todo/model/user_data.dart';
import 'package:flutter_todo/view_model/repository.dart';

final Bloc bloc = Bloc();
class Bloc {

  final Repository _repository = Repository();

  final StreamController<List<TodoData>> _streamController = StreamController<List<TodoData>>();
  Stream<List<TodoData>> get streamer => _streamController.stream;

  void fetchDate(String userAccess) {
    _repository.getListUser(userAccess).then((value) =>
        _streamController.sink.add(value));
  }

  Future<TodoData> addTodoDate(TodoData todoData, String userAccess){
    return _repository.addTodoService(todoData, userAccess);
  }

  Future<TodoData> updateTodoService(TodoData todoData, int completed, String userAccess){
    return _repository.updateTodoService(todoData, completed, userAccess);
  }

  Future<UserData> loginDate(LoginData loginData){
    return _repository.loginService(loginData);
  }

}
