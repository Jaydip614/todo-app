import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../bloc/todo_bloc.dart';
import '../data/toto.dart';

class ToDoScreen extends StatefulWidget {
  const ToDoScreen({super.key});

  @override
  State<ToDoScreen> createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {

  removeTodo(Todo todo) {
    context.read<TodoBloc>().add(
      RemoveTodo(todo),
    );
  }

  alertTodo(int index) {
    context.read<TodoBloc>().add(
        AlterTodo(index)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if(state.status == TodoStatus.success) {

            return SizedBox(
                child: ListView.builder(
                    itemCount: state.todos.length,
                    itemBuilder: (context, int i) {
                      return Card(
                        color: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)
                        ),
                        child: Slidable(
                            key: ValueKey(i),
                            endActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                 SlidableAction(
                                    onPressed: (_) {
                                      removeTodo(state.todos[i]);
                                    },
                                    backgroundColor: const Color(0xFFFE4A49),
                                    foregroundColor: Colors.white,
                                    icon: Icons.delete,
                                    // label: 'Delete',
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                              ],
                            ),
                            child: ListTile(
                                title: Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: Text(
                                      state.todos[i].title ,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      decoration: state.todos[i].isDone ? TextDecoration.lineThrough : TextDecoration.none,
                                    ),
                                  ),
                                ),
                                minVerticalPadding: 15,
                                textColor: const Color(0xFF000000),
                                subtitle: Text(
                                    state.todos[i].subtitle,
                                    style: TextStyle(
                                      color: Colors.black87,
                                      decoration: state.todos[i].isDone ? TextDecoration.lineThrough : TextDecoration.none,
                                    ),
                                ),
                                trailing: Transform.scale(
                                        scale: 1.1,
                                        child: Checkbox(
                                            value: state.todos[i].isDone,
                                            // shape: const CircleBorder(),
                                            splashRadius: 15,
                                            side: const BorderSide(
                                              color: Colors.black45,
                                            ),
                                            activeColor: Theme.of(context).colorScheme.secondary,
                                            onChanged: (value) {
                                              alertTodo(i);
                                            }
                                        ),
                                      ),
                            )
                        ),
                      );
                    }
                )
            );
          } else if (state.status == TodoStatus.initial){
            return const Center(child: CircularProgressIndicator());
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
