import 'package:flutter/material.dart';
import 'package:flutter_todo/model/todo_data.dart';
import 'package:flutter_todo/presenter/bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ItemTodoWidget extends StatefulWidget {
  final TodoData? todoData;
  const ItemTodoWidget({super.key, this.todoData});

  @override
  State<ItemTodoWidget> createState() => _ItemTodoWidgetState();
}

class _ItemTodoWidgetState extends State<ItemTodoWidget> {

  TodoData? todoData;

  @override
  void initState() {
    super.initState();
    todoData = widget.todoData;
  }

  @override
  void didUpdateWidget(covariant ItemTodoWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if(widget.todoData != oldWidget.todoData){
      todoData = widget.todoData;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          showDialog(context: context, builder: (BuildContext context) {
            return AlertDialog(
              title: Icon(Icons.check_circle,
                size: 45, color: Theme.of(context).primaryColor,
              ),
              content: const Text("Are you sure you want to complete this task?"),
              contentPadding: const EdgeInsets.only(
                  top: 24, left: 14, right: 14
              ),
              actionsPadding: EdgeInsets.zero,
              actions: <Widget>[
                TextButton(
                  child: const Text("No",
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                TextButton(
                  child: const Text("Yes",
                    style: TextStyle(color: Colors.red),
                  ),
                  onPressed: () => Navigator.of(context).pop([
                    SharedPreferences.getInstance().then((value) {
                      bloc.updateTodoService(todoData!, 1,"${value.getString('token')}");
                      bloc.fetchDate("${value.getString('token')}");
                    })
                  ]),
                ),
              ],
            );
          });
        } else {

        }
      },
      child: Column(
        children: [
      
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
      
                CircleAvatar(
                  backgroundColor: !(todoData?.completed == 1) ? Colors.black12 : null,
                  child: Icon((todoData?.completed == 1)
                      ? Icons.check :  Icons.close,
                    color: !(todoData?.completed == 1) ? Colors.white : null,
                  ),
                ),
      
                const SizedBox(width: 12,),
      
                Expanded(child: Text('${todoData?.todo}', style: const TextStyle(fontSize: 12),)),
      
              ],
            ),
          ),
          const Divider()
        ],
      ),
    );
  }


}
