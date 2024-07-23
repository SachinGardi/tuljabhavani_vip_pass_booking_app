import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tulajapur/view/common_widget/common_appBar.dart';

class ImageViewer extends StatefulWidget {
  const ImageViewer({Key? key}) : super(key: key);

  @override
  State<ImageViewer> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageViewer> {
  String imageUrl = '';
  Map data = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar("uploadedImage".tr),
      body:Hero(
        tag: 'imageHero',
        child: InteractiveViewer(
            panEnabled: false,
            child: Align(
              alignment: Alignment.center,
              child:Image.network(
                Get.arguments,
                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                            : null,
                      ),
                    );
                  }
                },
                errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                  return Icon(Icons.error);
                },
              ),
            )),
      ),
    );
  }
}