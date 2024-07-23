import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tulajapur/view/non_referral_pass/devotee_profile/camera_design.dart';
import '../../../baseUrl/base_url.dart';
var imgLink = ''.obs;
var uploadPhotoLoaderPofile = false.obs;
Future uploadDevoteeFileOrDocs(BuildContext context)async {
  uploadPhotoLoaderPofile.value = true;
  var request = http.MultipartRequest(
      'POST', Uri.parse(
      'http://$uatBaseUrl/api/TuljapurEpass/Document/UplodFile')
  );

  request.fields['FolderName'] = 'Tuljapur';
  request.fields['DocumentType'] = 'jpg';
  request.files.add(await http.MultipartFile.fromPath(
      'UploadDocPath',
      devoteeProfileImagePath!.path
  ),
  );
  var response = await request.send();
  if(response.statusCode== 200){
    uploadPhotoLoaderPofile.value = false;
  }
  else{
    Timer(Duration(seconds: 1), () {
      uploadPhotoLoaderPofile.value = false;
    });
  }
  print(response.stream);
  print(response.statusCode);
  final res = await http.Response.fromStream(response);
  print(res.body);
  Map temp = json.decode(res.body);

  if(temp["statusMessage"] == "File Posted Successfully"){
    imgLink.value = temp["responseData"];
    print("imgggggggg$imgLink");

  }


}