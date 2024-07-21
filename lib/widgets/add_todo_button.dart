import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/todo_bloc.dart';
import '../data/toto.dart';
import 'custom_textfield.dart';

class AddButton extends StatefulWidget {
  const AddButton({super.key});

  @override
  State<AddButton> createState() => _AddButtonState();
}

class _AddButtonState extends State<AddButton> {

  addTodo(Todo todo) {
    context.read<TodoBloc>().add(
      AddTodo(todo),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              barrierColor: Colors.black.withOpacity(0.5),
              builder: (context) {

                TextEditingController controller1 = TextEditingController();
                TextEditingController controller2 = TextEditingController();

                return AlertDialog(
                  surfaceTintColor: const Color(0xFFF1F2F5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)
                  ),

                  insetPadding: EdgeInsets.zero,
                  contentPadding: EdgeInsets.zero,
                  clipBehavior: Clip.antiAliasWithSaveLayer,

                  content: SizedBox(
                      width: screenWidth / 1.1,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomTextField(
                              controller: controller1,
                              hintText: 'Add Title'),
                          const SizedBox(height: 10),
                          CustomTextField(
                              controller: controller2,
                              hintText: 'Description...',
                              maxLines: 5,
                          ),
                        ],
                      ),
                    ),

                  actions: [
                    TextButton(
                          onPressed: () {
                            if(controller1.text.isNotEmpty){
                              addTodo(
                                Todo(
                                    title: controller1.text,
                                    subtitle: controller2.text
                                ),
                              );
                              controller1.text = '';
                              controller2.text = '';
                              Navigator.pop(context);
                            }
                          },
                          child: const Text('save',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 20
                            ),)
                      ),
                  ],
                  actionsAlignment: MainAxisAlignment.end,
                  actionsPadding: const EdgeInsets.fromLTRB(0, 3, 12, 5),
                );
              }
          );
        },

        //FloatingActionButton style
        backgroundColor: Theme.of(context).colorScheme.primary,
        shape: const CircleBorder(),
        child: Icon(
          Icons.add,
          size: 30,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
    );
  }
}
