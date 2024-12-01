import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyCarouselSlider extends StatefulWidget {
  const MyCarouselSlider({super.key});

  @override
  State<MyCarouselSlider> createState() => _MyCarouselSliderState();
}

final images=["img1.jpg","img2.jpg","img3.jpg","img4.jpg","img5.jpg"];
int currentIndex=0;

class _MyCarouselSliderState extends State<MyCarouselSlider> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Carousel Slider"),
      ),
      body: Padding(
        padding: EdgeInsetsDirectional.only(start: 16.w,end: 16.w,top: 24.h),
        child: Column(
          children: [
            CarouselSlider(
              items: List.generate(images.length, (index) =>
              ClipRRect(borderRadius: BorderRadius.circular(25.r),child: Image.asset("assets/images/${images[index]}",width: double.infinity,height: 350.h,fit: BoxFit.fill,))
              ),
              options: CarouselOptions(
                height: 350.h,
                enlargeCenterPage: true,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 2),
                onPageChanged: (index, reason) {
                  setState(() {
                    currentIndex=index;
                  });
                },
              ),
            ),
            SizedBox(height: 16.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(images.length, (index) =>
              CircleAvatar(radius: 12,backgroundColor: currentIndex==index?Colors.orange:Colors.transparent,child: CircleAvatar(radius: 10,backgroundColor: currentIndex==index?Theme.of(context).primaryColor:Colors.grey,))
              ),
            )
          ],
        ),
      ),
    );
  }
}
