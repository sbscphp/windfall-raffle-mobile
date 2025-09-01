
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:windfall/ui/widgets/show_flush_bar.dart';
import '../../ui/widgets/alert_dialogs/base_dialog.dart';
import '../../ui/widgets/alert_dialogs/error_dialog.dart';
import 'navigator.dart';



class ImageAndDocUtils{

  //File picker function
  static Future<String> pickDocument({List<String>? allowedExtensions}) async {

    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: allowedExtensions ?? ['pdf', 'png', 'jpg', 'jpeg', 'doc', 'docx'],
        allowCompression: true,
    );

    if (result != null) {
      final String? files = result.files.single.path;
      debugPrint('extension type:::::${result.files.single.extension}>>>>');
      return files ?? '';
    } else {
      // User canceled the picker
      // print("File Picked canceled");
      return '';
    }
  }

  //returns multiple docs/files
  static Future<List<File>> pickMultipleFiles({List<String>? allowedExtensions}) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowedExtensions: allowedExtensions ?? ['pdf', 'png', 'jpg', 'jpeg', 'doc', 'docx'],
      allowMultiple: true,
      type: FileType.custom,
      allowCompression: true,
    );

    if (result != null) {
      return result.paths.map((path) => File(path ?? '')).toList();
    }
    return [];
  }

  //image cropper function
  static Future<File?> cropImage({required File? image}) async {
    if (image != null) {
      try{
        CroppedFile? croppedFile = await ImageCropper().cropImage(
          sourcePath: image.path,
          uiSettings: [
            AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.black, //todo: set background color
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false,
              aspectRatioPresets: [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9
              ],
            ),
            IOSUiSettings(
              title: 'Cropper',
              aspectRatioPresets: [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9
              ],
            ),
          ],
        );
        final path = croppedFile!.path;
        return File(path);
      }catch(e){
        return null;
      }

    }
    return null;
  }

  //image picker
  static Future<File?> pickImage({ImageSource? imageSource, required BuildContext context})async{

    File? selectedImage;

    try{
      // Request photo library permission
      PermissionStatus status = await Permission.photos.request();

      if(status.isGranted){
        selectedImage = await getImage(imageSource: imageSource);
      }
      else if(status.isDenied){
        PermissionStatus status = await Permission.storage.request();
        if(status.isGranted){
          selectedImage = await getImage(imageSource: imageSource);
        }
      }
      else if(status.isPermanentlyDenied){
        baseDialog(
          isDismissible: true,
          context: context,
          content: ErrorDialog(
              title: "Permission Required",
              subtitle: "${Platform.isIOS ? 'Photos':'Gallery'} access is needed to select images. Please enable it in settings.",
              buttonText: 'Open Settings',
              onPressed: ()async{
                popNavigation(context: context);
                await openAppSettings();
              }
          ),
        );
      }
      else{
        baseDialog(
          isDismissible: true,
          context: context,
          content: ErrorDialog(
              title: "Permission Required",
              subtitle: "${Platform.isIOS ? 'Photos':'Gallery'} access is needed to select images. Please enable it in settings.",
              buttonText: 'Open Settings',
              onPressed: ()async{
                popNavigation(context: context);
                await openAppSettings();
              }
          ),
        );
      }
    }catch(e){
      if (e is PlatformException && e.code == "photo_access_denied") {
        baseDialog(
          isDismissible: true,
          context: context,
          content: ErrorDialog(
              title: "Permission Required",
              subtitle: "${Platform.isIOS ? 'Photos':'Gallery'} access is needed to select images. Please enable it in settings.",
              buttonText: 'Open Settings',
              onPressed: ()async{
                popNavigation(context: context);
                await openAppSettings();
              }
          ),
        );
      }
      else {
        // Display general error message
        showFlushBar(
          context: context,
          success: false,
          message: e.toString(),
        );
      }
    }
    return selectedImage;

  }

  static Future<File?> getImage({ImageSource? imageSource})async{
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: imageSource ?? ImageSource.gallery,
    );
    if(pickedFile != null){
      return File(pickedFile.path);
    }

    return null;
  }


  static Future<String?> pickAndCropImage({required BuildContext context})async{

    String? base64String;

    File? file = await pickImage(context: context);
    if(file != null){
      File? croppedFile = await cropImage(image: file);
      if(croppedFile != null){
        file = croppedFile;
        base64String = await fileToBase64ImageString(file: file);
        return base64String;
      }
      return null;
    }

    return null;
  }

  //converts image file to base64 image string
  static Future<String> fileToBase64ImageString({required File? file})async{
    String base64String = '';
    if(file == null){
      return base64String;
    }

    List<int> imageBytes = await file.readAsBytes();
    base64String = base64Encode(imageBytes);
    return base64String;
  }

  // //converts media assets to a list of base64 strings
  // static Future<List<String>> convertAssetsToBase64String(List<AssetEntity> selectedMedias) async {
  //   List<String> base64List = [];
  //
  //   for (AssetEntity asset in selectedMedias) {
  //     Uint8List? byteData = await asset.originBytes;
  //     if (byteData != null) {
  //       String base64String = base64Encode(byteData);
  //       base64List.add(base64String);
  //     }
  //   }
  //
  //   return base64List;
  // }

  //convert media asset to a base64 string
  // static Future<String> convertAssetToBase64String(AssetEntity media) async {
  //
  //   String returningString = '';
  //
  //     Uint8List? byteData = await media.originBytes;
  //     if (byteData != null) {
  //       returningString = base64Encode(byteData);
  //     }
  //
  //   return returningString;
  // }

  // static Future<List<Base64Details>> convertAssetsToBase64({required List<AssetEntity> medias}) async {
  //   List<Base64Details> base64List = [];
  //
  //   for (AssetEntity asset in medias) {
  //     File? file = await asset.file;
  //     Uint8List? byteData = await asset.originBytes;
  //
  //     if (file != null && byteData != null) {
  //       String base64String = base64Encode(byteData);
  //       base64List.add(Base64Details(base64String: base64String, path: file.path));
  //     }
  //   }
  //
  //   return base64List;
  // }

  //convert files to base64(string and path)
  // static Future<List<Base64Details>> convertFilesToBase64({required List<File> files}) async {
  //   List<Base64Details> base64List = [];
  //
  //   for (File file in files) {
  //     Uint8List byteData = await file.readAsBytes();
  //     String base64String = base64Encode(byteData);
  //
  //     base64List.add(Base64Details(base64String: base64String, path: file.path));
  //   }
  //
  //   return base64List;
  // }

  //converts base 64 to Uint8
  static Uint8List base64ToUint8List(String base64String) {
    return base64Decode(base64String);
  }

  //converts base64 string to file
  static Future<File> base64ToFile(String base64String, {bool isVideo = false}) async {
    Uint8List bytes = base64Decode(base64String);
    String tempPath = (await getTemporaryDirectory()).path;
    File file = isVideo ? File('$tempPath/video.mp4'): File('$tempPath/image.png');
    await file.writeAsBytes(bytes);
    return file;
  }

  //returns mime type
  static String getExtensionType({required String? mimeType}){
    if(mimeType == null || mimeType.isEmpty)return '';
    List<String> split = mimeType.split('/');
    return split.last;
  }

  //returns base64 string size(in mb or kb)
  static String getBase64Size({required String base64String}) {
    int padding = base64String.endsWith("==") ? 2 : base64String.endsWith("=") ? 1 : 0;
    double sizeInBytes = ((base64String.length * 3) / 4 - padding);
    double sizeInKB = sizeInBytes / 1024;

    if (sizeInKB >= 1024) {
      double sizeInMB = sizeInKB / 1024;
      return sizeInMB % 1 == 0
          ? "${sizeInMB.toInt()} MB"
          : "${sizeInMB.toStringAsFixed(1)} MB";
    } else {
      return sizeInKB % 1 == 0
          ? "${sizeInKB.toInt()} KB"
          : "${sizeInKB.toStringAsFixed(1)} KB";
    }
  }

  //returns file size
  static Future<String> getFileSize(File file) async {
    int bytes = await file.length();

    if (bytes < 1024) {
      return "$bytes B"; // Bytes
    } else if (bytes < 1024 * 1024) {
      return "${(bytes / 1024).toStringAsFixed(2)} KB"; // KB
    } else {
      return "${(bytes / (1024 * 1024)).toStringAsFixed(2)} MB"; // MB
    }
  }

  //returns file sizes for files
  static Future<List<String>> getFileSizes({required List<File> files}) async {

    List<String> result = [];

    try{
      for(File a in files){
        int bytes = await a.length();
        String value = '';
        if (bytes < 1024) {
          value = "$bytes B"; // Bytes
        } else if (bytes < 1024 * 1024) {
          value =  "${(bytes / 1024).toStringAsFixed(2)} KB"; // KB
        } else {
          value =  "${(bytes / (1024 * 1024)).toStringAsFixed(2)} MB"; // MB
        }
        result.add(value);
      }

      return result;
    }catch(e){
      return [];
    }
  }

  //downloads and save file(docs)
  static Future<String> downloadAndSaveFile({required String url, required String fileName}) async {

    if(url.isEmpty)return '';
    try {
      late String filePath;

      // if (Platform.isAndroid) {
      //   // Get the Downloads directory on Android
      //   String? downloadsDir = await AndroidPathProvider.downloadsPath;
      //   filePath = '$downloadsDir/$fileName';
      // } else if (Platform.isIOS) {
      //   // Use the Documents directory on iOS
      //   Directory dir = await getApplicationDocumentsDirectory();
      //   filePath = '${dir.path}/$fileName';
      // } else {
      //   throw UnsupportedError("Unsupported platform");
      // }

      // Get temporary directory
      Directory tempDir = await getTemporaryDirectory();
      filePath = '${tempDir.path}/$fileName';

      // Download the file
      Dio dio = Dio();
      await dio.download(url, filePath);

      return filePath;

      // // Open the file
      // OpenFilex.open(filePath);
    } catch (e) {
      print("Download Error: $e");
      return '';
    }
  }
}