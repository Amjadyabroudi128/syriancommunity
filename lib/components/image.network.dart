import 'package:flutter/cupertino.dart';

class myImage extends StatelessWidget {
 final String? src;
 final double? height;
 final double? width;
 final BoxFit? fit;
 final VoidCallback? onPressed;
  const myImage({super.key,  this.src, this.height, this.width, this.fit, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Image.network(
        src!,
        width: width,
        height: height,
        fit: fit,
      ),
      onTap: onPressed,
    );
  }
}
