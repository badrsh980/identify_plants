import 'dart:io';
import 'package:flutter/material.dart';
import 'package:identify_plants/api/api.dart';
import 'package:identify_plants/handelimg/image_uploader.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? _pickedImage;
  String? _identificationResult;
  final ImageUploader _imageUploader = ImageUploader(
      PlantIdService('rQhxSnQCDm3F75ifhNySYxUevdu2sCdBdkMAwIjpFBo73zeCe6'));

  void _pickAndUploadImage() async {
    final imageFile = await _imageUploader.pickImage();
    if (imageFile != null) {
      setState(() => _pickedImage = imageFile);

      final result = await _imageUploader.uploadImage(imageFile);
      setState(() => _identificationResult = result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plant Identifier'),
      ),
      body: SingleChildScrollView(
        // Added SingleChildScrollView for better scrolling
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (_pickedImage != null) Image.file(_pickedImage!),
            if (_identificationResult != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Identification Result:\n$_identificationResult',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.green[800], // Styling the text
                  ),
                ),
              ),
            ElevatedButton(
              onPressed: _pickAndUploadImage,
              child: const Text('Pick and Identify Image'),
            ),
          ],
        ),
      ),
    );
  }
}
