import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class PageAccessCamera extends StatefulWidget {
  const PageAccessCamera({super.key});

  @override
  State<PageAccessCamera> createState() => _PageAccessCameraState();
}

class _PageAccessCameraState extends State<PageAccessCamera> {

  XFile? image;
  Future<void> imageCamera() async{
    var res = await ImagePicker().pickImage(source: ImageSource.camera);
    if(res != null){
      setState(() {
        image = res;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Access Camera'),
        backgroundColor: Colors.cyan,
      ),

      body: Center(
        child: GestureDetector(
          onTap: () async{
            await imageCamera();
          },
          child: image != null ? Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 5, color: Colors.green)
            ),
            child: Image.file(File(image!.path)),
          ) : Icon(
            Icons.camera_alt_outlined,
            size: 50,
            color: Colors.green,
        ),
      )),
    );
  }
}
