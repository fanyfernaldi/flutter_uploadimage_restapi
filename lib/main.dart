import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Image Upload'),
        ),
        body: Center(
          child: TextButton(
            onPressed: () {
              uploadImage('image', File('assets/testimage.jpg'));
            },
            child: const Text('Upload'),
          ),
        ),
      ),
    );
  }
}

uploadImage(String title, File file) async {
  var request =
      http.MultipartRequest("POST", Uri.parse("https://api.imgur.com/3/image"));

  request.fields['title'] = 'dummyImage';
  request.headers['Authorization'] = '';

  var picture = http.MultipartFile.fromBytes(
    'image',
    (await rootBundle.load('assets/testimage.jpg')).buffer.asUint8List(),
    filename: 'testimage.jpg',
  );

  request.files.add(picture);

  var response = await request.send();

  var responseData = await response.stream.toBytes();

  var result = String.fromCharCodes(responseData);

  print(result);
}
