import 'package:flutter/cupertino.dart';

class myImage extends StatelessWidget {
 final String? src;
 final double? height;
 final double? width;
 final BoxFit? fit;
  const myImage({super.key,  this.src, this.height, this.width, this.fit});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      src!,
      width: width,
      height: height,
      fit: fit,
    );
  }
}
