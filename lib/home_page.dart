import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'edit_todo.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List task = [];
  @override
  void initState() {
    super.initState();
    getTask();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black12,
        title: const Text('Semi - Final ToDos'),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: task.length,
          itemBuilder: (context, index){
            final unit = task[index] as Map;
            return Card(
                child: ListTile(
                  leading: SizedBox(height: 20,
                    child: Text('${index +1}'),),
                  title: Text(unit['title']),
                  subtitle: Text(unit['body']),
                  trailing: PopupMenuButton(
                    onSelected: (value){
                      editTask(unit);
                      if(value == 'edit'){
                      }
                      else if (value == 'delete') {}
                    },
                    itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                      const PopupMenuItem(
                          value: 'edit',
                          child: Text('Edit'))
                    ],
                  ),
                )
            );
          }),
    );
  }
  Future<void> getTask() async{
    final url = 'https://jsonplaceholder.typicode.com/posts';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final json = convert.jsonDecode(response.body) as List;

    setState(() {
      task = json;
    });
  }
  Future<void> editTask(Map unit) async{
    final route = MaterialPageRoute(builder: (context) => EditTodo(unit: unit));
    await Navigator.push(context, route);
    getTask();
  }
}
