import 'package:flutter/material.dart';

// --------------- Button --------------
Widget defaultButton({
  double width = double.infinity,// par detault kayakhdo had 9yam
  Color background = Colors.blue,
  double radius = 6.0,
  required VoidCallback function,
  required String text,
  bool isUpperCAse = true,
}) =>  Container(
  width: width,
  height: 40.0,
  child: MaterialButton(
    onPressed: function,
    child: Text(
      isUpperCAse ? text.toUpperCase() : text,
      style: TextStyle(
        color: Colors.white,
      ),
    ),
  ),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(radius),
    color: background,
  ),
);



//------------------TextFormField------------------------------
Widget defaultFormField({
  void Function(String)? onSubmit,
  void Function(String)? onChange,
  void Function()? onTap,
  required TextEditingController controller,
  required TextInputType type,
  required String? Function(String?)? validate,
  required String label,
  required IconData prefix,
  IconData? suffix = null,
  bool isPassword = false,
  Function()? suffixPressd,
  bool isClickable = true,
}) =>  TextFormField(
  controller: controller,
  keyboardType: type,
  obscureText: isPassword,
  enabled: isClickable,
  onFieldSubmitted: onSubmit,
  onChanged: onChange,
  onTap: onTap,
  validator: validate,
  decoration: InputDecoration(
    labelText: label,
    prefixIcon: Icon(
      prefix,
    ),
      suffixIcon: suffix != null ? IconButton(
        onPressed: suffixPressd,
        icon: Icon(
          suffix,
    ),
      ) : null,
  border: OutlineInputBorder(),
  ),
);


Widget buildTasksItem(Map model
    // {
    //   Object  task,
    //   void Function(bool?)? onChange
    // }
) =>  Padding(
  padding: const EdgeInsets.all(20.0),
  child: Row(
    children: [
      CircleAvatar(
        radius: 40.0,
        child: Text(
          '${model['time']}',
        ),
      ),
      // Checkbox(
      //   value: task.completed,
      //   onChanged: onChange,
      //   //     (bool? value) {
      //   //   Update the completion status of the task in the database
      //   //   You may want to call a function to update the database here
      //   //   setState(() {
      //   //     task.completed = value ?? false;
      //   //   });
      //   // },
      // ),
      SizedBox(
        width: 20.0,
      ),
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${model['title']}',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '${model['date']}',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    ],
  ),
);

