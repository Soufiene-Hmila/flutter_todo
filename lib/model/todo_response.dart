import 'package:flutter_todo/model/todo_data.dart';

class TodoResponse {
  final List<TodoData>? todos;

  TodoResponse({
      this.todos,
  });

  factory TodoResponse.fromJson(dynamic json) {
    return TodoResponse(
      todos: json['todos'] != null ? (json['todos']
      as List).map((e) => TodoData.fromJson(e)).toList() : null
    );
  }

}