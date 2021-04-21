import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/modules/archived_tasks/archived_tasks_screen.dart';
import 'package:todo_app/modules/done_tasks/done_tasks_screen.dart';
import 'package:todo_app/modules/new_tasks/new_tasks_screen.dart';
import 'package:todo_app/shared/cubit/states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  Database database;
  int selectedIndex = 1;
  List<Map> tasks = [];

  List<Widget> pages = [
    DoneTasks(),
    NewTasksScreen(),
    ArchivedTasks(),
  ];

  List<String> appBarTitle = [
    'Done Tasks',
    'New Tasks',
    'Archived Tasks',
  ];

  void changeIndex(int index) {
    selectedIndex = index;
    emit(AppBottomNavBarChangeIndexState());
  }

  void createDataBase() {
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (db, version) {
        print('database created');
        db
            .execute(
                'CREATE TABLE TASKS (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time Text, status TEXT)')
            .then((value) => print('table Created'));
      },
      onOpen: (db) {
        getDataFromDataBase(db).then((value) {
          tasks = value;
          print(tasks);
          emit(AppGetDataFromDataBseState());
        });
        print('database opened');
      },
    ).then((value) {
      database = value;
      emit(AppCreateDataBseState());
    });
  }

  Future insertIntoDataBase({
    @required String title,
    @required String time,
    @required String date,
  }) async {
    await database.transaction(
      (txn) => txn
          .rawInsert(
        'INSERT INTO TASKS(title, date, time, status) VALUES("$title", "$date", "$time", "new")',
      )
          .then((value) {
        print('$value Raw Inserted');
        emit(AppInsertIntoDataBseState());

        getDataFromDataBase(database).then((value) {
          tasks = value;
          print(tasks);
          emit(AppGetDataFromDataBseState());
        });
      }),
    );
  }

  Future<List<Map>> getDataFromDataBase(database) async {
    tasks = [];
    return await database.rawQuery("SELECT * FROM TASKS");
  }

  void deleteData({
    @required int id,
  }) {
    database.rawDelete('DELETE FROM TASKS WHERE id = ?', [id]).then((value) {
      getDataFromDataBase(database).then((value) {
        tasks = value;
        print(tasks);
        emit(AppGetDataFromDataBseState());
      });
      emit(AppDeleteDatabaseState());
    });
  }
}
