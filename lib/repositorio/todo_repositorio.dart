import 'dart:convert';

import 'package:listadetarefas/models/todo.dart';
import 'package:listadetarefas/repositorio/todo_repositorio.dart';
import 'package:shared_preferences/shared_preferences.dart';

const todolistKey ="todo_list";

class TodoRepositorio{


  late SharedPreferences sharedPreferences ;


  Future<List<Todo>> getTodoList()async {
    sharedPreferences = await SharedPreferences.getInstance();
    final String jsonString = sharedPreferences.getString(todolistKey) ?? "[]";
    final List jsonDecoded = json.decode(jsonString) as List;
    return jsonDecoded.map((e) => Todo.fromJson(e)).toList();
  }

  void saveTodoList(List<Todo>todos){
   final jsonString = json.encode(todos);
   sharedPreferences.setString("todo_list", jsonString);
  }




}

