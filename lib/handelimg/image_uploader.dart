import 'dart:convert';
import 'dart:io';
import 'package:identify_plants/api/api.dart';
import 'package:identify_plants/model/plant.dart';
import 'package:image_picker/image_picker.dart';

class ImageUploader {
  final PlantIdService plantIdService;

  ImageUploader(this.plantIdService);

  Future<File?> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return File(pickedFile.path);
    } else {
      print('No image selected.');
      return null;
    }
  }

  Future<String?> getImageBase64(File? image) async {
    if (image != null) {
      final bytes = await image.readAsBytes();
      return base64Encode(bytes);
    }
    return null;
  }

  Future<String?> uploadImage(File? imageFile) async {
    final base64Image = await getImageBase64(imageFile);
    if (base64Image != null) {
      PlantIdentificationResponse response =
          await plantIdService.identifyPlantJson([base64Image]);
      return response.result?.classification?.suggestions?.first.name;
    } else {
      print("Image conversion failed or no image selected");
      return null;
    }
  }
}
