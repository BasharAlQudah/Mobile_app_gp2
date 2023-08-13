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
  String latestDetectionValue = '';
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

  Future<void> fetchLatestDetection() async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      QuerySnapshot querySnapshot = await firestore
          .collection('images')
          .orderBy('timestamp', descending: true)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot latestDocument = querySnapshot.docs.first;
        // String latestDescription = latestDocument['description'];
        String latestDetection = latestDocument['detaction'];

        // Update the UI with the latest detection data
        // _textEditingController.text = latestDescription;
        // Since TextFormField is disabled, we'll use another text widget to display the detection
        setState(() {
          latestDetectionValue = latestDetection;
        });
        print(latestDetectionValue);
      } else {
        print("No detections found.");
      }
    } catch (e) {
      print("Error fetching latest detection: $e");
    }
  }

  // @override
  // void initState() {
  //   super.initState();
  //   fetchLatestDetection();
  // }

  Stream<DocumentSnapshot> getLatestDetectionStream() {
    return FirebaseFirestore.instance
        .collection('images')
        .orderBy('timestamp', descending: true)
        .limit(1)
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs.first);
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
        'detaction': ''
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
          resizeToAvoidBottomInset: false, // Add this line

          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.all(50.0),
            child: StreamBuilder<DocumentSnapshot>(
              stream: getLatestDetectionStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                } else if (!snapshot.hasData || !snapshot.data!.exists) {
                  return Text("No detections found.");
                }

                DocumentSnapshot latestDocument = snapshot.data!;
                Map<String, dynamic>? documentData =
                    latestDocument.data() as Map<String, dynamic>?;
                if (documentData != null &&
                    documentData.containsKey('detaction')) {
                  String latestDetection = documentData['detaction'];
                  // Rest of your code...
                } else {
                  String defaultDetection = "Detection not available";
                }
                String? latestDetection = latestDocument['detaction'];
                return Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                          child: const Text("Select Image"),
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
                              TextFormField(
                                enabled: false,
                                decoration: InputDecoration(
                                  labelText:
                                      "Disease Name: ${latestDetection ?? ''}",
                                ),
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            //Navigator.of(context).pop();
                            await _uploadImageToFirebase();
                            // setState(() {
                            //   _image = null;
                            // });
                          },
                          child: const Text('Upload image'),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
