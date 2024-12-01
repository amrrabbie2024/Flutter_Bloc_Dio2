part of '../view.dart';

class MyBottomSheet extends StatefulWidget {
  const MyBottomSheet({super.key});

  @override
  State<MyBottomSheet> createState() => _MyBottomSheetState();
}

class _MyBottomSheetState extends State<MyBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.yellow,
        borderRadius: BorderRadiusDirectional.only(topStart: Radius.circular(45),topEnd: Radius.circular(25))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize:MainAxisSize.min ,
        children: [
          Text("Bootom Sheet",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 21),),
          SizedBox(height: 24.h,),
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
          IconButton(onPressed: () {
            Navigator.pop(context,nameController.text);
          }, icon: Icon(Icons.arrow_forward,color: Colors.blue,))
        ],
      ),
    );
  }
}
