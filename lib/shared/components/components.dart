import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:udemy_flutter/shared/cubit/cubit.dart';

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


Widget buildTasksItem(Map model, context
    // {
    //   Object  task,
    //   void Function(bool?)? onChange
    // }
) =>  Dismissible(
  key: Key(model['id'].toString()),
  child:   Padding(
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
        Expanded(
          child: Column(
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
        ),
        SizedBox(
          width: 20.0,
        ),
        IconButton(
            onPressed: (){
              AppCubit.get(context).updateData(status: 'done', id: model['id']);
            },
            icon: Icon(
              Icons.check_box,
              color: Colors.green,
            )
        ),
        IconButton(
            onPressed: (){
              AppCubit.get(context).updateData(status: 'archive', id: model['id']);
            },
            icon: Icon(
                Icons.archive,
              color: Colors.black45,
            )
        )
      ],
    ),
  ),
  onDismissed: (direction){
AppCubit.get(context).deleteData(id: model['id']);
  },
);

Widget tasksBuilder({
  required List<Map> tasks,
}) => ConditionalBuilder(
  condition: tasks.length > 0,
  builder: (context) => ListView.separated(
    itemBuilder: (context, index) => buildTasksItem(tasks[index], context),
    separatorBuilder: (context, index) => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 20.0,
      ),
      child: Container(
        width: double.infinity ,
        height: 1.0,
        color: Colors.grey[300],
      ),
    ),
    itemCount: tasks.length,
  ),
  fallback: (context) => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.menu,
          size: 80.0,
          color: Colors.grey,
        ),
        Text(
          'No Tasks Yet, Please Add Some Tesks',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
      ],
    ),
  ),
);

