part of '../home_page.dart';

class MyFloatingButton extends StatelessWidget {
  const MyFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
       backgroundColor: Colors.yellow,
      child: Icon(Icons.add_a_photo,),
      foregroundColor: Colors.orange,
      elevation: 12,
      shape: CircleBorder(
        side: BorderSide(color: Colors.blue)
      ),
      onPressed: () {
         print("Floating button");
    },);
  }
}
