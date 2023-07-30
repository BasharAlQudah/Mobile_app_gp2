import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? _image;
  final picker = ImagePicker();
  final TextEditingController _textEditingController = TextEditingController();

  Future getImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadImageToFirebase() async {
    if (_image == null) return;

    try {
      String fileName =
          DateTime.now().millisecondsSinceEpoch.toString() + ".jpg";
      firebase_storage.Reference ref =
          firebase_storage.FirebaseStorage.instance.ref().child(fileName);

      firebase_storage.UploadTask uploadTask = ref.putFile(_image!);
      firebase_storage.TaskSnapshot taskSnapshot =
          await uploadTask.whenComplete(() => null);

      String imageUrl = await taskSnapshot.ref.getDownloadURL();
      String description = _textEditingController.text;

      await saveImageToFirestore(imageUrl, description);

      _textEditingController.clear();
      setState(() {
        _image = null;
      });

      print("Image uploaded. URL: $imageUrl");
      print("Description: $description");
    } catch (e) {
      print("Error uploading image: $e");
    }
  }

  Future<void> saveImageToFirestore(String imageUrl, String description) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      await firestore.collection('images').add({
        'imageUrl': imageUrl,
        'description': description,
        'timestamp': FieldValue.serverTimestamp(),
      });

      print("Image URL and description saved to Firestore.");
    } catch (e) {
      print("Error saving image URL and description: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('images/login.png'), fit: BoxFit.cover),
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.all(50.0),
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _image != null
                        ? CircleAvatar(
                            radius:
                                100, // Change the radius to adjust the size of the circle
                            backgroundImage: FileImage(_image!),
                          )
                        : const SizedBox(
                            height: 200,
                            width: 200,
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                            ),
                          ),
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text("Choose an option"),
                            actions: <Widget>[
                              TextButton(
                                child: const Text("Upload from gallery"),
                                onPressed: () {
                                  getImage(ImageSource.gallery);
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: const Text("Take a photo"),
                                onPressed: () {
                                  getImage(ImageSource.camera);
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          ),
                        );
                      },
                      child: const Expanded(child: Text("Select Image")),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          TextField(
                            focusNode: null,
                            autofocus: false,
                            controller: _textEditingController,
                            decoration: const InputDecoration(
                              labelText: "Disease Description ",
                              border: OutlineInputBorder(),
                            ),
                          ),
                          Expanded(
                            child: TextFormField(
                              enabled: false,
                              decoration: const InputDecoration(
                                labelText: "Disease Name ",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        Navigator.of(context).pop();
                        await _uploadImageToFirebase();
                        setState(() {
                          _image = null;
                        });
                      },
                      child: const Expanded(
                        child: Text('Upload image'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
