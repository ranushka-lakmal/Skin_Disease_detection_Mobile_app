import 'dart:io';

import 'package:camera/camera.dart';
import 'package:deceasefinder/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ticket/flutter_ticket.dart';

import '../service/dio_upload_service.dart';

class TakePhoto extends StatefulWidget {
  final CameraDescription? camera;

  const TakePhoto({super.key, this.camera});

  @override
  _TakePhotoState createState() => _TakePhotoState();
}

class _TakePhotoState extends State<TakePhoto> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  final DioUploadService _dioUploadService = DioUploadService();
  XFile? file;

  @override
  void initState() {
    super.initState();

    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera as CameraDescription,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  Future<XFile?> takePicture() async {
    if (_controller.value.isTakingPicture) {
      return null;
    }

    try {
      XFile file = await _controller.takePicture();
      return file;
    } on CameraException catch (e) {
      print(e);
      return null;
    }
  }

  void presentLoader(BuildContext context,
      {String text = 'Kindly Wait..',
      bool barrierDismissible = false,
      bool willPop = true}) {
    showDialog(
        barrierDismissible: barrierDismissible,
        context: context,
        builder: (c) {
          return WillPopScope(
            onWillPop: () async {
              return willPop;
            },
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  image:
                      DecorationImage(image: AssetImage("assets/splash.png"))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const CircularProgressIndicator(
                    color: Colors.white,
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Card(
                    elevation: 0,
                    color: Colors.transparent,
                    child: Text(
                      text,
                      style:
                          const TextStyle(fontSize: 25.0, color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  Future<void> presentAlert(
    BuildContext context, {
    String title = '',
    String message = '',
  }) {
    String DTitle = message.split("Atopic_Dermatitis_stage_1")[1].split("}")[0];
    String _solution = "";
    String _title = "";

    switch (DTitle) {
      case "Atopic_Dermatitis_stage_1":
        {
          _title="Atopic_Dermatitis_stage_1";
          _solution="ACROBAT FUNGICIDE";
        }
        break;
      case "Atopic_Dermatitis_stage_2":
        {
          _title="Atopic_Dermatitis_stage_2";
          _solution="ANTRACOL 500GMS";
        }
        break;
      case "Atopic_Dermatitis_stage_3":
        {
          _title="Atopic_Dermatitis_stage_3";
          _solution="Daconil® Fungicide Concentrate";
        }
        break;
      case "healthy":
        {
          _title="Healthy";
          _solution="Not Needed";
        }
        break;
    }



    return showDialog(
        context: context,
        builder: (c) {
          return Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                image:
                DecorationImage(image: AssetImage("assets/splash.png"))),
            child: Center(
              child: Card(
                color: Colors.transparent,
                elevation: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(
                          height: 30.0,
                        ),
                        Ticket(
                          innerRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10.0),
                              bottomRight: Radius.circular(10.0)),
                          outerRadius: BorderRadius.all(Radius.circular(10.0)),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 4.0),
                              blurRadius: 2.0,
                              spreadRadius: 2.0,
                              color: Color.fromRGBO(196, 196, 196, .76),
                            )
                          ],
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: 80,
                            color: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Decease Details",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: MyApp.primaryColor,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ),
                        Ticket(
                          innerRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              topRight: Radius.circular(10.0)),
                          outerRadius: BorderRadius.all(Radius.circular(10.0)),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 4),
                              blurRadius: 2.0,
                              spreadRadius: 2.0,
                              color: Color.fromRGBO(196, 196, 196, .76),
                            )
                          ],
                          child: Container(
                            color: Colors.white,
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        _title,
                                        style: TextStyle(fontSize: 18.0),
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(height: 0.0),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    children: <Widget>[
                                     Text("Solution "),
                                     Expanded(child: Text(_solution)),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Center(child: DTitle != "healthy"? Image.asset("assets/$DTitle.png"):Container()),
                                ),
                                GestureDetector(
                                  onTap: (){
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    color: Colors.lightBlue,
                                    padding: EdgeInsets.symmetric(vertical: 8.0),
                                    child: Center(
                                      child: Text(
                                        'Dismiss',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16.0),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ]),
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyApp.primaryColor,
        title: const Text('Take picture'),
      ),
      floatingActionButton: file == null
          ? FloatingActionButton(
              backgroundColor: MyApp.primaryColor,
              onPressed: () async {
                file = await takePicture();
                setState(() {});
                //Navigator.of(context).pop(file != null ? file.path : null);
              },
              child: Image.asset(
                "assets/capture-icon.png",
                fit: BoxFit.cover,
                width: 200,
                height: 200,
              ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: const BorderSide(color: Colors.grey)))),
                  onPressed: () {
                    file = null;
                    setState(() {});
                    //Navigator.of(context).pop(file != null ? file?.path : null);
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(left: 8, right: 8),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                          color: MyApp.primaryColor,
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(MyApp.accentColor),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: const BorderSide(color: Colors.grey)))),
                  onPressed: () async {
                    // show loader
                    presentLoader(context);
                    // calling with dio
                    var responseDataDio =
                        await _dioUploadService.uploadPhotos(file!.path);

                    // hide loader
                    Navigator.of(context).pop();

                    // showing alert dialogs
                    await presentAlert(context,
                        title: 'Success Dio',
                        message: responseDataDio.toString());
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Confirm',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            return file != null
                ? Image.file(File(file!.path))
                : CameraPreview(_controller);
          } else {
            // Otherwise, display a loading indicator.
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
