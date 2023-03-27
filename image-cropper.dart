
import 'package:docscanner/roughf-screen.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'dart:io';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'choose-pdf-file.dart';

class DemoImagePicker extends StatefulWidget {
  const DemoImagePicker({Key? key}) : super(key: key);

  @override
  State<DemoImagePicker> createState() => _DemoImagePickerState();
}

class _DemoImagePickerState extends State<DemoImagePicker> {
  // This is the file that will be used to store the image
  File? _image;

  // This is the image picker
  final _picker = ImagePicker();

  List<File> imagesList = [];
  XFile? _pickedFile;

  // Implementing the image picker to pick image from gallery
  Future<void> _openImagePickerFromCamera() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
        compressImage(pickedImage.path);
      });
    }
  }

  compressImage(String file) async {
    ImageProperties properties =
        await FlutterNativeImage.getImageProperties(file);
    File compressedFile = await FlutterNativeImage.compressImage(file,
        quality: 80, targetWidth: 600, targetHeight: 600);
    setState(() {
      cropImage(compressedFile.path);
    });
  }

  var cropimage_path;
  List<String> listof_cropimage_path = [];
  CroppedFile? _croppedFile;
  bool visible = false;
  var image_current_count;

  cropImage(String imageFile) async {
    if (imageFile != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: imageFile,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Color(0XFF033860),
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Cropper',
          ),
          WebUiSettings(
            context: context,
            presentStyle: CropperPresentStyle.dialog,
            boundary: const CroppieBoundary(
              width: 520,
              height: 520,
            ),
            viewPort:
                const CroppieViewPort(width: 600, height: 600, type: 'circle'),
            enableExif: true,
            enableZoom: true,
            showZoomer: true,
          ),
        ],
      );
      if (croppedFile != null) {
        setState(() {
          _croppedFile = croppedFile;
          visible = true;
          cropimage_path = croppedFile.path;
          print("PATH of cropped file is---");
          print("${cropimage_path}");
          listof_cropimage_path.insert(0, cropimage_path);

          print("List of image is---");
          print(listof_cropimage_path);
          // imagesList.insert(0,"${croppedFile.path}" as File);//
          // debugPrint("List of image is as  ----:${imagesList}");
        });
      }
    }
    setState(() {});
  }


  final pdf = pw.Document();

  // converToPdf(String path)async{
  //
  //   debugPrint("Convert to pdf method is called");
  //   debugPrint(listof_cropimage_path.first);
  //
  //   //For single image
  //   final image = pw.MemoryImage(
  //     File(path).readAsBytesSync(),
  //   );
  //   pdf.addPage(pw.Page(build: (pw.Context context) {
  //     return pw.Center(
  //       child: pw.Image(image),
  //     ); // Center
  //   }));
  //
  // }

  multiImagePdfCon(List _image)async{
    debugPrint("multi Image Pdf Converter is called");

    for (var img in _image) {
      // final image = pw.MemoryImage(img.readAsBytesSync());
      final image = pw.MemoryImage(
        File(img).readAsBytesSync(),

      );

      pdf.addPage(pw.Page(

          pageFormat: PdfPageFormat.a4,
          build: (pw.Context contex) {
            return pw.Center(child: pw.Image(image));
          }));
    }
  }
  savePDF() async {
    try {

      var tempDir = await getExternalStorageDirectory();
      var filePath = "${tempDir!.path}.pdf";
      var file = File(filePath);

      debugPrint('Saved pdf path is---------$filePath');
      //Saved pdf path is---------/storage/emulated/0/Android/data/com.docscanner.docscanner/files.pdf
      await file.writeAsBytes(await pdf.save());
      showPrintedMessage('success', 'saved to documents');
      filePath !=null?
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => ChoosePdfFile(pdf_address: filePath,)))
          :debugPrint("PDF File Is Not Selected");
    } catch (e) {
      showPrintedMessage('error', e.toString());
    }


  }
  showPrintedMessage(String title, String msg) {
    Flushbar(

      title: title,
      message: msg,
      backgroundColor:Color(0XFF033860) ,
      duration: Duration(seconds: 3),
      icon: Icon(
        Icons.info,
        color: Colors.blue,
      ),
    )..show(context);
  }



@override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0XFF033860),
          centerTitle: true,
          title: Text("ScanDocuments"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, size: 18),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            TextButton(
                onPressed: () {},
                child: Text(
                  "Done",
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Column(

                        children: [


                      listof_cropimage_path.isNotEmpty
                          ? Container(
                        color: Colors.black12,
                              padding: EdgeInsets.symmetric(),
                              height: MediaQuery.of(context).size.height * 0.35,
                         width: MediaQuery.of(context).size.width,
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: listof_cropimage_path.length,
                                itemBuilder: (context, index) {
                                  return Stack(
                                    alignment: Alignment.bottomRight,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: FittedBox(
                                            fit: BoxFit.fill,
                                            child: Image.file(
                                              height: MediaQuery.of(context).size.height * 0.35,
                                              width: MediaQuery.of(context).size.width * 0.75,
                                              File(
                                                  listof_cropimage_path[index]),
                                            )),
                                      ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                debugPrint(
                                                    "Deleted index of image is-${listof_cropimage_path[index]}");

                                                if (listof_cropimage_path
                                                    .isEmpty) {
                                                 Navigator.pop(context);
                                                } else {
                                                  listof_cropimage_path.remove(
                                                      listof_cropimage_path[
                                                          index]);
                                                }
                                              });
                                            },
                                            icon: Icon(
                                              Icons.cancel_rounded,
                                            )),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Align(
                                          alignment:
                                              AlignmentDirectional.bottomEnd,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadiusDirectional.all(
                                                Radius.circular(20),
                                              ),
                                              color: Colors.black38,
                                            ),
                                            width: 50,
                                            height: 30,
                                            child: Center(
                                                child: Text("${index + 1}",
                                                    style: TextStyle(
                                                        color: Colors.white))),
                                          ),
                                        ),
                                      )
                                    ],
                                  );
                                },
                              ),
                            )
                          : Container(),
                      listof_cropimage_path.isEmpty
                          ? Center(
                              // this button is used to open the image picker
                              child: ElevatedButton(
                                style: const ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                        Color(0XFF033860))),
                                onPressed: _openImagePickerFromCamera,
                                child: const Text('Scan Image'),
                              ),
                            )
                          :
                      Column(
                        children: [
                          Center(
                                  // this button is used to open the image picker
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor: MaterialStatePropertyAll(
                                            Color(0XFF033860))),
                                    onPressed: _openImagePickerFromCamera,
                                    child: const Text('Add More'),
                                  ),
                                ),
                          Center(
                            // this button is used to open the image picker
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      Color(0XFF033860))),
                              onPressed: ()async {
                                // createPDF();
                                // savePDF();
                               print("List of crop image is $listof_cropimage_path");
                               // converToPdf(listof_cropimage_path.first);
                               multiImagePdfCon(listof_cropimage_path);
                               savePDF();
                              },
                              child: const Text('Convert To Pdf'),
                            ),
                          )
                        ],
                      ),

                    ]),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

}
