import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class UploadImageAPI extends StatefulWidget {
  const UploadImageAPI({super.key});

  @override
  UploadImageAPIState createState() => UploadImageAPIState();
}

class UploadImageAPIState extends State<UploadImageAPI> {
  File? _image;
  String? _downloadUrl;

  Future<void> pickImage() async {
    final pickedFile = await FilePicker.platform.pickFiles(
      // allowMultiple: false,
      // withData: false,
    );

    if (pickedFile != null) {
      setState(() => _image = File(pickedFile.files.first.path!));
    }
  }

  Future<void> uploadImageToFirebase() async {
    if (_image == null) return;

    try {
      // الحصول على FirebaseApp الخاص بالمشروع الثاني
      FirebaseApp secondaryApp = Firebase.app('StorageBucket');
      FirebaseStorage storage = FirebaseStorage.instanceFor(app: secondaryApp);

      String fileName = _image!.path.split('/').last;
      String filePath = "TStore/images/$fileName";

      Reference ref = storage.ref().child(filePath);
      UploadTask uploadTask = ref.putFile(_image!);

      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();

      setState(() {
        _downloadUrl = downloadUrl;
      });

      debugPrint("✅ تم رفع الصورة بنجاح: $_downloadUrl");
    } catch (e) {
      debugPrint("❌ خطأ أثناء رفع الصورة: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("رفع صورة على Firebase Storage لمشروع آخر"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _image != null
                  ? Image.file(_image!, height: 200)
                  : const Icon(Icons.image, size: 100),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: pickImage,
                  child: const Text("اختر صورة"),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: uploadImageToFirebase,
                  child: const Text("رفع الصورة"),
                ),
              ),
              if (_downloadUrl != null) ...[
                const SizedBox(height: 20),
                const Text("رابط الصورة:"),
                SelectableText(
                  _downloadUrl!,
                  style: const TextStyle(color: Colors.blue),
                ),
                Image.network(_downloadUrl!, height: 200),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
