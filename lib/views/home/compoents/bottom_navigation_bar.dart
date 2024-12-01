part of '../home_page.dart';

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({super.key});

  @override
  State<MyBottomNavigationBar> createState() => _MyBottomNavigationBarState();
}

int currentIndex=1;

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadiusDirectional.only(topStart: Radius.circular(45),topEnd: Radius.circular(25)),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.yellow,
          elevation: 16,
          selectedItemColor: Colors.orange,
          unselectedItemColor: Colors.grey,
          selectedFontSize: 21,
          unselectedFontSize: 16,
          onTap: (value) {
          currentIndex=value;
          setState(() {});
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.add_a_photo),label: "Camera"),
            BottomNavigationBarItem(icon: Icon(Icons.ac_unit),label: "Settings"),
            BottomNavigationBarItem(icon: Icon(Icons.access_alarm),label: "Timer"),
            BottomNavigationBarItem(icon: Icon(Icons.calendar_today_outlined),label: "Calender"),
          ]),
    );
  }
}
