import 'dart:io';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ImageViewScreen extends StatefulWidget {
  const ImageViewScreen({Key? key, this.fileImage, this.networkImage})
      : super(key: key);

  final File? fileImage;
  final String? networkImage;

  @override
  _ImageViewScreenState createState() => _ImageViewScreenState();
}

class _ImageViewScreenState extends State<ImageViewScreen> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff252525),
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Hero(
            tag: widget.fileImage == null
                ? widget.networkImage!
                : widget.fileImage!,
            child: PhotoViewGallery.builder(
              scrollPhysics: const BouncingScrollPhysics(),
              builder: (BuildContext context, int index) {
                return PhotoViewGalleryPageOptions(
                  imageProvider: widget.fileImage == null
                      ? NetworkImage(widget.networkImage!)
                      : FileImage(widget.fileImage!) as ImageProvider,
                );
              },
              itemCount: 1,
              loadingBuilder: (context, event) => Center(
                child: SizedBox(
                  width: 20.0,
                  height: 20.0,
                  child: CircularProgressIndicator(
                    value: event == null
                        ? 0
                        : event.cumulativeBytesLoaded /
                            event.expectedTotalBytes!,
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
