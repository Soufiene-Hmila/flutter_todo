import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo/presenter/add_todo_screen.dart';
import 'package:flutter_todo/presenter/bloc/bloc.dart';
import 'package:flutter_todo/presenter/item_user_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    SharedPreferences.getInstance().then((value) {
      bloc.fetchDate("${value.getString('token')}");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo List",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const AddTodoScreen(),
            ),
          );
        },
      ),
      body: StreamBuilder(
        stream: bloc.streamer,
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            if((snapshot.data?.isNotEmpty ?? false)){
              return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index){
                    return ItemTodoWidget(todoData: snapshot.data?.elementAt(index),);
              });
            }
            return const SizedBox();
          } else if(snapshot.hasError){
            return const Text('Failed GET Data From Server');
          } else {
            return const Center(child: CircularProgressIndicator(strokeWidth: 2,));
          }
        }
      ),
    );
  }


}
