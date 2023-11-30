import 'dart:io';
import 'package:flutter/material.dart';
import 'package:identify_plants/api/api.dart';
import 'package:identify_plants/handelimg/image_uploader.dart';
import 'package:identify_plants/model/plant.dart';
import 'package:identify_plants/screens/post.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? _pickedImage;
  PlantIdentificationResponse? _identificationResponse;
  final ImageUploader _imageUploader = ImageUploader(
      PlantIdService('rQhxSnQCDm3F75ifhNySYxUevdu2sCdBdkMAwIjpFBo73zeCe6'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 20, 23, 26),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 20, 23, 26),
        title: const Center(
          child: Text(
            'Plant Identifier',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Image.asset("assets/fallback_image.png"),
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: _pickAndUploadImage,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color.fromARGB(255, 103, 134, 74),
                ),
                child: const Text(
                  'Pick and Identify Image',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _pickAndUploadImage() async {
    final imageFile = await _imageUploader.pickImage();
    if (imageFile != null) {
      setState(() => _pickedImage = imageFile);

      final response = await _imageUploader.uploadImage(imageFile);
      setState(() => _identificationResponse = response);

      if (_identificationResponse != null) {
        _navigateToPlantDetailPage(
            _identificationResponse!); // Navigate to detail page
      }
    }
  }

  void _navigateToPlantDetailPage(PlantIdentificationResponse response) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlantDetailPage(response: response),
      ),
    );
  }
}
