import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyAppImage extends StatelessWidget {
  
  final String url;
  final double? width;
  final double? height;
  final BoxFit fit;
  const MyAppImage( {super.key, required this.url, this.width, this.height,  this.fit=BoxFit.scaleDown});

  @override
  Widget build(BuildContext context) {
    if(url.endsWith('svg'))
    return SvgPicture.asset("assets/svg/$url",width: width,height: height,fit: fit,);
    else if(url.startsWith("http"))
      return Image.network(url,width: width,height: height,fit: fit,errorBuilder: (context, error, stackTrace) {
        return Icon(Icons.error,color: Theme.of(context).primaryColor,size: 64,);
      },);
    else
      return Image.asset("assets/images/$url",width: width,height: height,fit: fit,errorBuilder: (context, error, stackTrace) {
        return Center(child: Text("No image found",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 24),));
      },);
  }
}
