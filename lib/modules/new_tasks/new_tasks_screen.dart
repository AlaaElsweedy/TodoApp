import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/shared/components/components.dart';
import 'package:todo_app/shared/cubit/cubit.dart';
import 'package:todo_app/shared/cubit/states.dart';

class NewTasksScreen extends StatelessWidget {
  var _formKey = GlobalKey<FormState>();
  TextEditingController _textController = TextEditingController();
  String selectedDate = 'Pick Date';
  String selectedTime = 'Pick Time';

  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppInsertIntoDataBseState) {
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);

        return Scaffold(
          backgroundColor: Colors.grey[200],
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) => Dialog(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'Add New Task',
                            style: TextStyle(fontSize: 22),
                          ),
                          const SizedBox(height: 15),
                          TextFormField(
                            controller: _textController,
                            keyboardType: TextInputType.text,
                            validator: (String value) {
                              if (value.isEmpty) {
                                return 'Values can\'t be empty';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: 'Enter task name',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          defaultButton(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.date_range,
                                  color: Theme.of(context).primaryColor,
                                ),
                                const SizedBox(width: 10),
                                Text(selectedDate),
                              ],
                            ),
                            onPressed: () => showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate:
                                  DateTime.now().add(Duration(days: -365)),
                              lastDate: DateTime.now().add(Duration(days: 365)),
                            ).then((value) {
                              selectedDate = DateFormat()
                                  .add_yMMMd()
                                  .format(value)
                                  .toString();
                            }),
                          ),
                          const SizedBox(height: 15),
                          defaultButton(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.access_time_rounded,
                                  color: Theme.of(context).primaryColor,
                                ),
                                const SizedBox(width: 10),
                                Text(selectedTime),
                              ],
                            ),
                            onPressed: () => showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            ).then((value) {
                              selectedTime = value.format(context).toString();
                            }),
                          ),
                          const SizedBox(height: 25),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Close'),
                              ),
                              defaultButton(
                                child: Text('Save'),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                backgroundColor: Theme.of(context).primaryColor,
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    cubit.insertIntoDataBase(
                                      title: _textController.text,
                                      time: selectedTime,
                                      date: selectedDate,
                                    );
                                  }
                                },
                                textColor: Colors.white,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
            },
            child: Icon(Icons.add),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView.separated(
              itemBuilder: (context, index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          Container(
                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(cubit.tasks[index]['date']),
                              SizedBox(height: 10),
                              Text(cubit.tasks[index]['time']),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Container(
                              padding: EdgeInsets.all(10),
                              width: 190,
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white,
                              ),
                              child: Text(cubit.tasks[index]['title']),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
              separatorBuilder: (context, index) => SizedBox(height: 50),
              itemCount: cubit.tasks.length,
            ),
          ),
        );
      },
    );
  }
}
