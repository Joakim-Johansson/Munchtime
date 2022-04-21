import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
class Storage{

    firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future<firebase_storage.ListResult> listFiles() async {
    firebase_storage.ListResult results =
        await storage.ref('test').listAll();
    return results;
  }

  Future<String> downloadURL(String imageName) async {
    String downloadURL =
        await storage.ref('test/$imageName').getDownloadURL();

    return downloadURL;
  }


}