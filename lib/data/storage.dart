import 'dart:io';

import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class Storage {
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future<firebase_storage.ListResult> listFiles() async {
    firebase_storage.ListResult results = await storage.ref('test').listAll();
    return results;
  }

  Future<String> downloadURL(String imageName) async {
    String downloadURL = await storage.ref('test/$imageName').getDownloadURL();

    return downloadURL;
  }

  Future<void> uploadFile(String filePath, String fileName) async {
    File file = File(filePath);
    try{
      await storage.ref('test/$fileName').putFile(file);
    } on firebase_core.FirebaseException catch (e){
      print(e);
    }
  }
}
