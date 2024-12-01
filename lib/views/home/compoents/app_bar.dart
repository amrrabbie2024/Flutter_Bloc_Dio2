part of '../home_page.dart';


class MyAppBar extends StatelessWidget implements PreferredSizeWidget  {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.grey.withOpacity(.5),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Custom App Bar"),
          SizedBox(width: 4.w,),
          Padding(
            padding:  EdgeInsets.all(8.r),
            child: CircleAvatar(radius: 12.r,backgroundImage: AssetImage("assets/images/img1.jpg"),),
          ),
        ],
      ),
      titleTextStyle: TextStyle(color: Colors.blue,fontWeight: FontWeight.w500,fontSize: 22),
      centerTitle: true,
      /*leading: Padding(
        padding:  EdgeInsets.all(8.r),
        child: CircleAvatar(radius: 12.r,backgroundImage: AssetImage("assets/images/img1.jpg"),),
      ),*/
      actions: [
        IconButton(onPressed: () {
          print("Search");
        }, icon: Icon(Icons.search,color: Colors.green,)),
        SizedBox(width: 4.w,),
        IconButton(onPressed: () {
          print("Settings");
        }, icon: Icon(Icons.settings,color: Colors.blue,)),
        SizedBox(width: 4.w,),
      ],
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(Icons.add_alert),
            Icon(Icons.access_time),
            Icon(Icons.ac_unit_outlined)
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}
