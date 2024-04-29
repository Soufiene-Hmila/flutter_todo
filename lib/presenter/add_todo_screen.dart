import 'package:flutter/material.dart';
import 'package:flutter_todo/model/todo_data.dart';
import 'package:flutter_todo/presenter/bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddTodoScreen extends StatefulWidget {
  const AddTodoScreen({super.key});

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add Todo",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          iconTheme: IconTheme.of(context).copyWith(color: Colors.white),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: Column(
          children: [

            Padding(
              padding: const EdgeInsets.only(
                top: 24, left: 12, right: 12
              ),
              child: TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: 5, minLines: 5,
                controller: controller,
                decoration: InputDecoration(
                  hintText: 'Description',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),

            const Spacer(),

            Container(
              margin: const EdgeInsets.only(
                  top: 12, left: 12, right: 12, bottom: 24
              ),
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  onPressed: () {
                    SharedPreferences.getInstance().then((value) {
                      bloc.addTodoDate(
                        TodoData(
                            userId: 1,
                            completed: 0,
                            todo: controller.text
                        ),
                          "${value.getString('token')}"
                      ).then((value) {
                        if(value.id != null){
                          Navigator.of(context).pop([
                            SharedPreferences.getInstance().then((value) {
                              bloc.fetchDate("${value.getString('token')}");
                            })
                          ]);
                        }
                      });
                    });
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    child: Text("SUBMIT",
                      style: TextStyle(fontSize: 18, color: Colors.white),),
                  )
              ),
            )
          ],
        )
    );
  }
}
