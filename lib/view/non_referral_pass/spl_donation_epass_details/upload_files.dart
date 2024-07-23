import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../baseUrl/base_url.dart';
import 'camera_design.dart';
var imgLinkForDevotees = ''.obs;
var uploadPhotoLoader = true.obs;
Future uploadAllDevoteeFileOrDocs(BuildContext context)async {
  uploadPhotoLoader.value = true;
  var request = http.MultipartRequest(
      'POST', Uri.parse(
      'http://$uatBaseUrl/api/TuljapurEpass/Document/UplodFile')
  );

  request.fields['FolderName'] = 'Tuljapur';
  request.fields['DocumentType'] = 'jpg';
  request.files.add(await http.MultipartFile.fromPath(
      'UploadDocPath',
      uploadedDevoteeImagePath!.path
  ),
  );
  var response = await request.send();
  if(response.statusCode== 200){
    uploadPhotoLoader.value = false;
  }
  else{
    Timer(Duration(seconds: 1), () {
      uploadPhotoLoader.value = false;
    });
  }

  print(response.stream);
  print(response.statusCode);
  final res = await http.Response.fromStream(response);
  print(res.body);
  Map temp = json.decode(res.body);

  if(temp["statusMessage"] == "File Posted Successfully"){
    imgLinkForDevotees.value = temp["responseData"];
    print("imgggggggg$imgLinkForDevotees");

  }


}