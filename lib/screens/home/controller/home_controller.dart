import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class HomeController {
  File? image;
  pickImageFromGallery() async {
    PickedFile? pickedFile = await ImagePicker.platform.pickImage(
      source: ImageSource.gallery,
    );

    image = File(pickedFile!.path);
    print(" image: $image");
    return image;
  }

  pickImageFromCamera() async {
    PickedFile? pickedFile = await ImagePicker.platform.pickImage(
      source: ImageSource.camera,
    );
    image = File(pickedFile!.path);
    print(" image: $image");
    return image;
  }

  Future<String> imageUpload(imageFile) async {
    FirebaseStorage storage = FirebaseStorage.instance;

    Reference ref = storage.ref().child("images");
    UploadTask uploadTask = ref.putFile(imageFile);
    await Future.value(uploadTask);
    var link = await ref.getDownloadURL();
    return link;
  }
}
