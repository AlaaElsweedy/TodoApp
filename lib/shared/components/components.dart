import 'package:flutter/material.dart';
import 'package:todo_app/shared/cubit/cubit.dart';

Widget defaultButton({
  @required Widget child,
  @required Function onPressed,
  Color backgroundColor,
  Color textColor,
  ShapeBorder shape,
}) =>
    MaterialButton(
      child: child,
      color: backgroundColor,
      textColor: textColor,
      shape: shape,
      onPressed: onPressed,
    );

Widget buildTask({
  @required BuildContext context,
  @required Map model,
}) =>
    Dismissible(
      key: Key(model['id'].toString()),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        AppCubit.get(context).deleteData(id: model['id']);
      },
      background: Container(
        alignment: Alignment.centerRight,
        child: Icon(
          Icons.delete,
          color: Colors.red,
          size: 35,
        ),
      ),
      child: Row(
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
                SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${model['date']}'),
                    SizedBox(height: 10),
                    Text('${model['time']}'),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            flex: 2,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        child: Text(
                          '${model['title']}',
                          textAlign: TextAlign.start,
                          softWrap: true,
                        ),
                        width: 100,
                        margin: EdgeInsets.only(
                          left: 10.0,
                          top: 10,
                          bottom: 10,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.check_circle,
                          color: Colors.green,
                        ),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.archive,
                          color: Colors.black45,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
