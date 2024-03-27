import 'package:flutter/cupertino.dart';

class myImage extends StatelessWidget {
 final String? src;
 final double? height;
 final double? weight;
  const myImage({super.key,  this.src, this.height, this.weight});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      src!,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.40,

    );
  }
}
