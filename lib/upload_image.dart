import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class UploadImage extends StatefulWidget {
  const UploadImage({Key? key}) : super(key: key);

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  File? image;
  final _picker = ImagePicker();
  bool showSpinner = false;

  Future getImage() async {
    final pickedFile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);

    if (pickedFile != null) {
      image = File(pickedFile.path);
      setState(() {});
    } else {
      print('No image selec');
    }
  }

  Future<void> uploadImage() async {
    setState(()
    {
      showSpinner =true;
    });
    
    var stream = new http.ByteStream(image!.openRead());
    stream.cast();
    
    var length = await image!.length();
    
    var uri = Uri.parse('https://fakestoreapi.com/products');

    var request = new http.MultipartRequest('Post', uri);

    request.fields['title'] = 'Static title';

    var multiport = new http.MultipartFile(
    'image', stream, length);

    request.files.add(multiport);
    var response = await request.send();
    if(response.statusCode == 200){
      setState(()
      {
        showSpinner =false;
      });
      print('Image Uplaoded');
    }else{
      print('Failed');
      setState(()
      {
        showSpinner =false;
      });

    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
          title: Text("uplaod image"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                child: image == null
                    ? Center(
                        child: Text('Pick Image'),
                      )
                    : Container(
                        child: Center(
                          child: Image.file(
                            File(image!.path).absolute,
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )),
            SizedBox(
              height: 150,
            ),

            GestureDetector(
              onTap: () {
                uploadImage();
              },
              child: Container(
                height: 50,
                color: Colors.green,
                child: Text('Upload'),
              ),
            )

          ],
        ),
      ),
    );
  }
}
