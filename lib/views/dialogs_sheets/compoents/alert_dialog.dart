part of'../view.dart';

class MyAlertDialog extends StatefulWidget {
  const MyAlertDialog({super.key});

  @override
  State<MyAlertDialog> createState() => _MyAlertDialogState();
}

final nameController=TextEditingController(text: "");

class _MyAlertDialogState extends State<MyAlertDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(child: Text("Alert Dialog",)),
      titleTextStyle: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 21),
      actions: [
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
        Center(
          child: SizedBox(
            height: 38.h,
            child: FilledButton.icon(onPressed: () {
              Navigator.pop(context,nameController.text);
            }, icon: Icon(Icons.close), label: Text("Confirm")),
          ),
        )
      ],
      backgroundColor: Colors.grey.withOpacity(.3),
      shadowColor: Colors.orange,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.only(topStart: Radius.circular(45),bottomEnd: Radius.circular(25)),
        side: BorderSide(color: Theme.of(context).primaryColor)
      ),
    );
  }
}
