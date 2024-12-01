import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_apis_pagination/core/design/app_failed.dart';
import 'package:flutter_apis_pagination/core/design/app_loading.dart';
import 'package:flutter_apis_pagination/features/movies/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';

class MoviesCarouselSlider extends StatefulWidget {
  const MoviesCarouselSlider({super.key});

  @override
  State<MoviesCarouselSlider> createState() => _MoviesCarouselSliderState();
}

final kbloc=KiwiContainer().resolve<MoviesBloc>()..add(getMoviesDataEvent());
int currentIndex=0;

class _MoviesCarouselSliderState extends State<MoviesCarouselSlider> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movies Carousel Slider"),
      ),
      body: Padding(
        padding:  EdgeInsetsDirectional.symmetric(horizontal: 16.w,vertical: 24.h),
        child: BlocBuilder(
          bloc: kbloc,
          builder: (context, state) {
            if(state is MoviesFailedState)
              return MyAppFailed(msg: state.msg);
            else if(state is MoviesSucessState)
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CarouselSlider(
                    items: List.generate(state.movieModel.length, (index) =>
                    Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        ClipRRect(
                        borderRadius: BorderRadiusDirectional.only(topStart: Radius.circular(25),bottomEnd: Radius.circular(16))
                        ,child: Image.network("http://image.tmdb.org/t/p/w500/${state.movieModel[index].posterPath}",width: MediaQuery.of(context).size.width,height: 550.h,fit: BoxFit.fill,)),
                        Positioned(
                          bottom: 10,
                            child: Text(state.movieModel[index].title,style: TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.w900,fontSize: 22),))
                      ],
                    )
                    ),
                    options: CarouselOptions(
                      onPageChanged: (index, reason) {
                        setState(() {
                          currentIndex=index;
                        });
                      },
                      height: 550.h,
                      autoPlayInterval: Duration(seconds: 2),
                      autoPlayAnimationDuration: Duration(milliseconds: 300),
                      autoPlay: true,
                      enlargeCenterPage: true,
                      scrollDirection: Axis.vertical,
                      reverse: false
                    ),
                  ),
                  SizedBox(height: 16.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(state.movieModel.length, (index) =>
                    CircleAvatar(radius: 10,backgroundColor: currentIndex==index?Colors.orange:Colors.transparent,
                        child: CircleAvatar(radius: 8,backgroundColor: currentIndex==index?Theme.of(context).primaryColor:Colors.grey,))
                    ),
                  )
                ],
              );
            else
              return MyAppLoading();
          },
        )
      ),
    );
  }
}
