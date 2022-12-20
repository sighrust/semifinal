import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'home_page.dart';

class EditTodo extends StatefulWidget {
  final Map unit;
  const EditTodo({super.key, required this.unit});

  @override
  State<EditTodo> createState() => _EditTodoState();
}

class _EditTodoState extends State<EditTodo> {
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  bool toEdit = false;

  var formKey = GlobalKey<FormState>();
  @override

  void initState(){
    super.initState();
    final unit = widget.unit;
    if (unit != null){
      toEdit = true;
      final title = unit['title'];
      final body = unit['body'];
      titleController.text = title;
      bodyController.text = body;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black12,
        title: const Text('Edit Context'),
        centerTitle: true,
      ),
      body: Form(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextFormField(
              controller: titleController,
              decoration: const InputDecoration(
                  label: Text('Title')
              ),
              keyboardType: TextInputType.multiline,
              minLines: 2,
              maxLines: 10,
            ),
            const SizedBox( height:  20,),
            TextFormField(
              controller: bodyController,
              decoration: const InputDecoration(
                  label: Text('body')
              ),
              keyboardType: TextInputType.multiline,
              minLines: 2,
              maxLines: 50,
            ),
            const SizedBox(height: 20,),
            ElevatedButton(onPressed: () async {
              edit();
              final route = await Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomePage()));
            },
                child: const Text('Save Changes'))
          ],),
      ),
    );
  }
  Future<void> edit() async {
    final unit = widget.unit;
    if(unit == null){
      return;
    }
    final id = unit['_id'];
    final title = titleController.text;
    final body = bodyController.text;
    final description = {
      'title' : title,
      'body' : body
    };
    final url = 'https://jsonplaceholder.typicode.com/posts/$id';
    final uri = Uri.parse(url);
    final response = await http.put(
        uri, body: jsonEncode(description),
        headers: {"content-type": "application/json"});
  }
}
