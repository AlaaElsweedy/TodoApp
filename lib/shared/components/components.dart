import 'package:flutter/material.dart';

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
  BuildContext context,
  Map model,
}) =>
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
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
                Text(model['date']),
                SizedBox(height: 10),
                Text(model['time']),
              ],
            ),
          ],
        ),
        Row(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Container(
                padding: EdgeInsets.all(10),
                width: 220,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                child: Text(
                  model['title'],
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
