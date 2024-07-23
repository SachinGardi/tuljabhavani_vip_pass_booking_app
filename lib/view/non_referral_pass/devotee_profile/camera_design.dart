import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:get/get.dart';
import '../../common_widget/progress_indicator.dart';
import 'image_uploading_file.dart';



File? devoteeProfileImagePath;

class DevoteeProfileCameraPage extends StatefulWidget {
  const DevoteeProfileCameraPage({super.key});

  @override
  DevoteeProfileCameraPageState createState() => DevoteeProfileCameraPageState();
}

class DevoteeProfileCameraPageState extends State<DevoteeProfileCameraPage> {
  CameraController? _controller;
  late List<CameraDescription> _cameras;
  int _currentCameraIndex = 0;
  late bool _isFlashOn;
  var isLoading = true.obs;

  XFile? profileImage;

  Future<void> _initializeCamera() async {
    _cameras = await availableCameras();

    _controller = CameraController(
      _cameras[_currentCameraIndex],
      ResolutionPreset.medium,
      enableAudio: false,
    );
    await _controller?.initialize();
    isLoading.value = false;
    if (!mounted) {
      return;
    }
    setState(() {});
  }

  void _switchCamera() {
    _currentCameraIndex = (_currentCameraIndex + 1) % _cameras.length;
    _controller?.dispose();
    _initializeCamera();
  }

  @override
  void initState() {
    super.initState();
    _isFlashOn = false;
    _initializeCamera();
    devoteeProfileImagePath = null;
    // fileName = '';
  }

  void _toggleFlash() {
    setState(() {
      _isFlashOn = !_isFlashOn;
      _controller!.setFlashMode(_isFlashOn ? FlashMode.torch : FlashMode.off);
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: WillPopScope(
          onWillPop: () async {
            Get.back();
            Get.back();
            return false;
          },
          child: Obx(
                () => isLoading.value == true
                ? progressIndicator()
                : Column(
              children: [
                devoteeProfileImagePath == null
                    ? SizedBox(
                    height: MediaQuery.of(context).size.height / 1.28,
                    child: CameraPreview(_controller!))
                    : SizedBox(
                  height: MediaQuery.of(context).size.height / 1.28,
                  child: Image.file(devoteeProfileImagePath!,fit: BoxFit.fill),
                ),
                devoteeProfileImagePath == null
                    ? SizedBox(
                  height: MediaQuery.of(context).size.height / 6,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: _toggleFlash,
                        icon: Icon(
                          _isFlashOn
                              ? Icons.flash_on
                              : Icons.flash_off,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        alignment: Alignment.centerRight,
                        onPressed: () async {

                          profileImage =
                          await _controller?.takePicture();
                          setState(() {
                            devoteeProfileImagePath = File(profileImage!.path);
                          });
                        },
                        icon: CircleAvatar(
                          radius:
                          MediaQuery.of(context).size.height /
                              24,
                          backgroundColor: Colors.grey.shade700,
                          child: CircleAvatar(
                            radius:
                            MediaQuery.of(context).size.height /
                                33,
                            backgroundColor: Colors.white,
                          ),
                        ),
                        iconSize:
                        MediaQuery.of(context).size.height / 10,
                      ),
                      IconButton(
                        alignment: Alignment.centerLeft,
                        onPressed: _switchCamera,
                        icon: const Icon(
                          Icons.cameraswitch,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                )
                    : SizedBox(
                  height: MediaQuery.of(context).size.height / 6,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            _initializeCamera();
                            devoteeProfileImagePath = null;
                          });
                        },
                        child: CircleAvatar(
                            radius:
                            MediaQuery.of(context).size.height /
                                35,
                            backgroundColor: Colors.grey.shade700,
                            child: const Icon(
                              Icons.cancel,
                              color: Colors.white,
                            )),
                      ),
                      TextButton(
                        onPressed: () async {
                          if (devoteeProfileImagePath != null) {
                            await uploadDevoteeFileOrDocs(context);
                            Get.back();
                            Get.back();
                          }
                          if (devoteeProfileImagePath == null) {
                            Get.back();
                            Get.back();
                          }

                          // Handle the captured image, e.g., display it or save it
                        },
                        child: CircleAvatar(
                            radius:
                            MediaQuery.of(context).size.height /
                                35,
                            backgroundColor: Colors.grey.shade700,
                            child: const Icon(
                              Icons.check,
                              color: Colors.white,
                            )),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
