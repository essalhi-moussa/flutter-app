import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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



// --------------- Item ListView  --------------
Widget buildTasksItem(Map model, context) =>  Dismissible(
  background: Container(
    color: Colors.redAccent,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Icon(Icons.delete, color: Colors.white),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: Icon(Icons.delete, color: Colors.white),
        ),
      ],
    ),
  ),
  key: Key(model['id'].toString()),
  child:   Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      decoration: BoxDecoration(
        color: Color(0xFFD2EBE5),
        borderRadius: BorderRadius.circular(8.0), // Adjust the radius as per your requirement
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            // CircleAvatar(
            //   radius: 40.0,
            //   child: Text(
            //     '${model['time']}',
            //   ),
            // ),
            Checkbox(
              value: model['status'] == 'done' ? true : false, // The initial value of the checkbox
              onChanged: (bool? newValue) {
                print("##### $newValue");
                if (newValue != null && newValue == true) {
                  AppCubit.get(context)
                      .updateData(status: 'done', id: model['id']);
                }else{
                  AppCubit.get(context)
                      .updateData(status: 'new', id: model['id']);
                }
              },
            ),

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
    ),
  ),
  onDismissed: (direction){
AppCubit.get(context).deleteData(id: model['id']);
  },
);

// --------------- Secande scrolable Item ListView  --------------
// Widget buildTasksItem(Map model, context) {
//   return Slidable(
//     // Specify a key if the Slidable is dismissible.
//     key: Key(model['id'].toString()),
//
//     // The start action pane is the one at the left or the top side.
//     startActionPane: ActionPane(
//       // A motion is a widget used to control how the pane animates.
//       motion: const ScrollMotion(),
//
//       // A pane can dismiss the Slidable.
//       dismissible: DismissiblePane(onDismissed: () {}),
//
//       // All actions are defined in the children parameter.
//       children: [
//         // A SlidableAction can have an icon and/or a label.
//         SlidableAction(
//           onPressed: (context){
//             AppCubit.get(context).deleteData(id: model['id']);
//             },
//           backgroundColor: Color(0xFFFE4A49),
//           foregroundColor: Colors.white,
//           icon: Icons.delete,
//           label: 'Delete',
//         ),
//
//       ],
//     ),
//
//     // The end action pane is the one at the right or the bottom side.
//     endActionPane:  ActionPane(
//       motion: ScrollMotion(),
//       children: [
//         SlidableAction(
//           // An action can be bigger than the others.
//           flex: 2,
//           onPressed: (context){
//             AppCubit.get(context).updateData(status: 'archive', id: model['id']);
//           },
//           backgroundColor: Color(0xFF7BC043),
//           foregroundColor: Colors.white,
//           icon: Icons.archive,
//           label: 'Archive',
//         ),
//         SlidableAction(
//           onPressed: (context){
//             AppCubit.get(context).updateData(status: 'done', id: model['id']);
//           },
//           backgroundColor: Color(0xFF21B7CA),
//           foregroundColor: Colors.white,
//           icon: Icons.done,
//           label: 'Done',
//         ),
//       ],
//     ),
//
//     // The child of the Slidable is what the user sees when the
//     // component is not dragged.
//     child:  ListTile(title:  Text(
//       '${model['title']}',
//       style: TextStyle(
//         fontSize: 16.0,
//         fontWeight: FontWeight.bold,
//       ),
//     ),),
//   );
// }


// --------------- tasksBuilder  --------------


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
        // Icon(
        //   Icons.menu,
        //   size: 80.0,
        //   color: Colors.grey,
        // ),

        // Text(
        //   'No Tasks Yet, Please Add Some Tesks',
        //   style: TextStyle(
        //     fontSize: 16.0,
        //     fontWeight: FontWeight.bold,
        //     color: Colors.grey,
        //   ),
        // ),
        Image(
          image: AssetImage('assets/images/to_do_app.png'),
          height: 300.0,
          width: 600.0,
        ),
      ],
    ),
  ),
);

