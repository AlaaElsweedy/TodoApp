import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/shared/cubit/cubit.dart';
import 'package:todo_app/shared/cubit/states.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDataBase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);

          return Scaffold(
            backgroundColor: Colors.grey[200],
            appBar: AppBar(
              title: Text(cubit.appBarTitle[cubit.selectedIndex]),
            ),
            bottomNavigationBar: CurvedNavigationBar(
              items: [
                Icon(
                  Icons.check_circle_outline,
                  size: 30,
                  color: Colors.white,
                ),
                Icon(
                  Icons.menu,
                  size: 30,
                  color: Colors.white,
                ),
                Icon(
                  Icons.archive_outlined,
                  size: 30,
                  color: Colors.white,
                ),
              ],
              index: cubit.selectedIndex,
              onTap: (value) => cubit.changeIndex(value),
              color: Theme.of(context).primaryColor,
              backgroundColor: Colors.grey[200],
            ),
            body: cubit.pages[cubit.selectedIndex],
          );
        },
      ),
    );
  }
}
