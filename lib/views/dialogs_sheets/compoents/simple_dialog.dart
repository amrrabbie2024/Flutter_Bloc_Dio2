
part of '../view.dart';
class MySimpleDialog extends StatefulWidget {
  const MySimpleDialog({super.key});

  @override
  State<MySimpleDialog> createState() => _MySimpleDialogState();
}

class _MySimpleDialogState extends State<MySimpleDialog> {
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      backgroundColor: Colors.blue.withOpacity(.5),
      shadowColor: Colors.orange,
      elevation: 32,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.only(topStart: Radius.circular(45),topEnd: Radius.circular(25)),
        side: BorderSide(color:Colors.blue)
      ),
      title: Text("Simple Dialog"),
      titleTextStyle: TextStyle(color: Colors.green,fontWeight: FontWeight.bold,fontSize: 22),
      children: [
        TextFormField(
          controller: nameController,
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(color: Theme.of(context).primaryColor)
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(color: Theme.of(context).primaryColor)
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(color: Theme.of(context).primaryColor)
            ),
          ),
        ),
        SizedBox(height: 16.h,),
        CloseButton(color: Colors.orange,onPressed: () {
          Navigator.pop(context,nameController.text);
        },)
      ],
    );
  }
}
