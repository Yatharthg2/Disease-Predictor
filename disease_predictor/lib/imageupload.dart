import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:disease_predictor/diagnosis.dart';

// IMAGE UPLOADING PAGE

class ImageUploadPage extends StatefulWidget {
  const ImageUploadPage({Key? key});

  @override
  _ImageUploadPageState createState() => _ImageUploadPageState();
}

class _ImageUploadPageState extends State<ImageUploadPage> {
  final picker = ImagePicker();
  File? _image;

  Future<void> getImage(ImageSource source, BuildContext context) async {
    try {
      final pickedFile = await picker.pickImage(source: source);

      // IMAGE NAVIGATOR AFTER SELECTION

      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ImageDiagnosisPage(image: _image!)),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('No image selected.')));
        }
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error selecting image.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Image'),
      ),
      body: Center(
        child: _image == null
            ? const Text('No image selected.')
            : Image.file(_image!),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => getImage(ImageSource.camera, context),
            tooltip: 'Take Photo',
            child: const Icon(Icons.camera_alt),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            onPressed: () => getImage(ImageSource.gallery, context),
            tooltip: 'Pick from Gallery',
            child: const Icon(Icons.photo_library),
          ),
        ],
      ),
    );
  }
}