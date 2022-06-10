import 'package:flutter/material.dart';
import 'package:listadetarefas/widgets/todo_list_item.dart';
import 'package:listadetarefas/models/todo.dart';


class TodoListPage extends StatefulWidget {
  TodoListPage({Key? key}) : super(key: key);

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  List <Todo> todos  = [];

  Todo? deletedTodo;
  int? deletedTodoPos;


  final TextEditingController todocontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: todocontroller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Adicione uma Tarefa",
                        hintText: "Ex. Estudar Flutter",
                      ),
                    ),
                  ),
                  SizedBox(width: 16,),
                  ElevatedButton(
                    onPressed: (){
                      String text = todocontroller.text;
                      setState((){
                        Todo newTodo = Todo(
                          title: text,
                          dateTime: DateTime.now(),
                        );
                        todos.add(newTodo);
                      });

                      todocontroller.clear();

                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.deepOrange,
                      padding: EdgeInsets.all(16),
                    ),
                    child: Icon(
                      Icons.add,
                      size: 30,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
                SizedBox(height: 16,),
                  Flexible(
                    child: ListView(
                    shrinkWrap: true,
                    children: [
                      for(Todo todo in todos)
                      TodoListItem(
                        todo: todo,
                        onDelete:onDelete,

                      ),
                    ],
                ),
                  ),
                SizedBox(height: 16,),
                Row(
                  children: [
                    Expanded(
                        child: Text("Voce possui ${todos.length} tarefas pendentes")
                    ),
                    SizedBox(width: 16,),
                    ElevatedButton(onPressed: DeleteAll,
                      style: ElevatedButton.styleFrom(
                        primary: Colors.deepOrange,
                        padding: EdgeInsets.all(16),
                      ),child: Text("Limpar Tudo"),)
                  ],
                ),
              ],
            ),
          ),
          ),
          ),
    );



  }
  void onDelete(Todo todo){
    deletedTodo = todo;
    deletedTodoPos = todos.indexOf(todo);

    setState((){
      todos.remove(todo);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("A Tarefa ${todo.title} foi removida com sucesso!",
        style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,
        action: SnackBarAction(
          label: "Desfazer",
          textColor: Colors.blue,
          onPressed: (){
            setState((){
              todos.insert(deletedTodoPos!, deletedTodo!);

            });
          },
        ),),
    );

  }

  void DeleteAll(){
      setState((){
        todos.clear();
      });
    }
  }



