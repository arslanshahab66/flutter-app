import 'package:flutter/material.dart';
import 'package:shared_prefernces/screens/home/controller/home_controller.dart';

class MyHome extends StatefulWidget {
  MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  HomeController controller = HomeController();

  var image;
  var cameraIamge;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          image == null
              ? IconButton(
                  onPressed: () async {
                    var img = await controller.pickImageFromGallery();
                    setState(() {
                      image = img;
                    });
                  },
                  icon: Icon(Icons.perm_media_sharp))
              : Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: FileImage(image),
                    ),
                  ),
                ),
          cameraIamge == null
              ? IconButton(
                  onPressed: () async {
                    var img = await controller.pickImageFromCamera();
                    setState(() {
                      cameraIamge = img;
                    });
                  },
                  icon: Icon(Icons.camera))
              : Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      image: DecorationImage(image: FileImage(cameraIamge))),
                ),
          ElevatedButton(
              onPressed: () {
                var imageLink = controller.imageUpload(cameraIamge);
                debugPrint('imageLink: $imageLink');
              },
              child: Text("Upload Image")),
        ],
      ),
    );
  }
}
 