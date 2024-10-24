import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DisplayPictureScreen extends StatefulWidget {
  final String imagePath;

  const DisplayPictureScreen({Key? key, required this.imagePath})
      : super(key: key);

  @override
  _DisplayPictureScreenState createState() => _DisplayPictureScreenState();
}

class _DisplayPictureScreenState extends State<DisplayPictureScreen> {
  late final ValueNotifier<String> _imagePathNotifier;
  late final ValueNotifier<bool> _isLoadingNotifier;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _imagePathNotifier = ValueNotifier(widget.imagePath);
    _isLoadingNotifier = ValueNotifier(false);
  }

  Future<void> _pickImage(ImageSource source) async {
    Navigator.pop(context);

    _isLoadingNotifier.value = true;

    XFile? newImage = await _picker.pickImage(source: source);

    _isLoadingNotifier.value = false;
    if (newImage != null) {
      _imagePathNotifier.value = newImage.path;
    }
  }

  void _showEditOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_enhance_outlined),
                title: const Text('Camera'),
                onTap: () {
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera),
                title: const Text('Gallery'),
                onTap: () {
                  _pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder<bool>(
        valueListenable: _isLoadingNotifier,
        builder: (context, isLoading, child) {
          if (isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 40.0, horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 40.0,
                    height: 40.0,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10.0, left: 16),
                    child: Text(
                      'Take a photo of document',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 16, top: 5),
                    child: Text(
                      'Please ensure photos are clear and visible',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ValueListenableBuilder<String>(
                    valueListenable: _imagePathNotifier,
                    builder: (context, imagePath, child) {
                      return Center(
                        child: Container(
                          width: 200,
                          height: 270,
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.blueAccent, width: 3),
                          ),
                          child: Image.file(
                            File(imagePath),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 40.0,
                        height: 40.0,
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            _showEditOptions();
                          },
                        ),
                      ),
                      Container(
                        width: 40.0,
                        height: 40.0,
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.check, color: Colors.white),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
