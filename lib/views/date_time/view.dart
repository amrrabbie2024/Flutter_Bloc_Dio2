import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyDateTime extends StatefulWidget {
  const MyDateTime({super.key});

  @override
  State<MyDateTime> createState() => _MyDateTimeState();
}

DateTime? date;
TimeOfDay? time;

final dateController=TextEditingController(text: "");
final timeController=TextEditingController(text: "");

class _MyDateTimeState extends State<MyDateTime> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Date and Time"),
      ),
      body: Padding(
        padding:  EdgeInsetsDirectional.symmetric(horizontal: 16.w,vertical: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Spacer(),
            TextFormField(
              onTap: () async {
                date=await showDatePicker(context: context, firstDate: DateTime.now().add(Duration(days: -10)), lastDate: DateTime.now().add(Duration(days: 10)),
                    initialDate: date!=null?date:DateTime.now() );
                dateController.text=date.toString().split(" ").first;
                //if(date!=null)dateController.text=DateFormat.yMd().format(date!);
                //if(date!=null)dateController.text=DateFormat.yMMMd().format(date!);
              },
              controller: dateController,
              validator: (value) {
                if(value!.isEmpty)
                  return "Must select date";
                else return null;
              },
              decoration: InputDecoration(
                suffix: Icon(Icons.date_range),
                labelText: "Date",
                hintText: "Select Date",
                alignLabelWithHint: true,
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
            Spacer(),
            TextFormField(
              onTap: () async {
                time=await showTimePicker(context: context, initialTime: time!=null?time!:TimeOfDay.now());
                timeController.text="${(time!.hour>12?time!.hour-12:time!.hour).toString().padLeft(2,"0")}:${time!.minute.toString().padLeft(2,"0")} ${time!.period.name.toUpperCase()}";
              },
              controller: timeController,
              validator: (value) {
                if(value!.isEmpty)
                  return "Must select time";
                else return null;
              },
              decoration: InputDecoration(
                suffix: Icon(Icons.access_alarm),
                labelText: "Time",
                hintText: "Select Time",
                alignLabelWithHint: true,
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
            Spacer()
          ],
        ),
      ),
    );
  }
}
