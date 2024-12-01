import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget({super.key});

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

double currentVolume=20;

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {

  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(
        'https://ia902203.us.archive.org/25/items/mohmeed77_hotmail_1_201509/%D8%A7%D9%84%D8%B4%D9%8A%D8%AE%20%D8%A7%D9%84%D8%B4%D8%B9%D8%B1%D8%A7%D9%88%D9%89%20%D9%85%D9%82%D8%AF%D9%85%D8%A9%20%D8%A7%D9%84%D8%AA%D9%81%D8%B3%D9%8A%D8%B1%20%D8%A7%D9%84%D8%AD%D9%84%D9%82%D8%A9%201.mp4'))
      ..initialize().then((_) {
        setState(() {});

        _controller.addListener(() {
          if (_controller.value.isCompleted)
            _controller.seekTo(Duration.zero);
          setState(() {

          });
        });

      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: Stack(children: [
            VideoPlayer(_controller),
            Positioned(
                bottom: 15,
                right: 10,
                left: 10,
                child:
                Slider(
                  value: _controller.value.position.inSeconds
                    .toDouble(), min: 0, max: _controller.value.duration
                    .inSeconds.toDouble(), onChanged: (value) {
                  _controller.seekTo(Duration(seconds: value.toInt()));
                  setState(() {

                  });
                },)
            ),
            Positioned(
                top: 10,
                right: 10,
                child: Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          if (_controller.value.playbackSpeed == 3)
                            _controller.setPlaybackSpeed(1);
                          else
                            _controller.setPlaybackSpeed(
                                _controller.value.playbackSpeed + .5);
                        },
                        child: CircleAvatar(radius: 10,
                          child: Text(
                            _controller.value.playbackSpeed.toString(),
                            style: TextStyle(fontSize: 10),),)),
                    IconButton(onPressed: () {
                      _controller.setLooping(!_controller.value.isLooping);
                    },
                        icon: Icon(Icons.repeat,
                          color: _controller.value.isLooping ? Theme
                              .of(context)
                              .primaryColor : null,)),
                  ],
                )
            ),
            Positioned(
              right: 10,
                top: 50,
                bottom: 50,
                child: RotatedBox(
                  quarterTurns: 3,
                  child: Slider(
                     value: currentVolume,min: 0,max: 100,divisions: 10,onChanged: (value) {
                       currentVolume=value;
                       _controller.setVolume(currentVolume);
                       setState(() {

                       });
                     },
                  ),
                ),
            ),
            Positioned(
                bottom: 5,
                left: 25,
                right: 25,
                child: Row(
                  children: [
                    Text(getTime(_controller.value.position.inSeconds),style: TextStyle(color: Theme.of(context).primaryColor),),
                    Spacer(),
                    Text(getTime(_controller.value.duration.inSeconds),style: TextStyle(color: Theme.of(context).primaryColor),)
                  ],
                ))
          ]
          ),
        )
            : Center(child: CircularProgressIndicator()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
  
  String getTime(int value){
    int mins=value~/60;
    int seds=value%60;
    return mins.toString().padLeft(2,"0") +":" + seds.toString().padLeft(2,"0");
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

}
