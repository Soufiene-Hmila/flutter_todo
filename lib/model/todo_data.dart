import 'package:equatable/equatable.dart';

class TodoData extends Equatable {

  final int? id;
  final int? userId;
  final String? todo;
  final int? completed;

  const TodoData({
      this.id, 
      this.userId,
      this.todo,
      this.completed,
  });

  factory TodoData.fromJson(dynamic json) {
    return TodoData(
      id: json['id'],
      userId: json['userId'],
      todo: json['todo'],
      completed: json['completed'],
    );
  }


  Map<String, dynamic> toJson() => {
    "userId": userId,
    "todo": todo,
    "completed": completed,
  };

  @override
  List<Object?> get props => [
    id,
    userId,
    todo,
    completed,
  ];

}