import 'dart:io';
import 'package:windfall/core/constants/app_constants.dart';
import 'package:windfall/ui/widgets/show_flush_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class ReceiptUtils{

  static Future<Uint8List> capturePng({required GlobalKey key}) async {
    try {
      RenderRepaintBoundary boundary = key.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 5);
      ByteData? byteData =
      await image.toByteData(format: ui.ImageByteFormat.png);

      return byteData!.buffer.asUint8List();
    } catch (e) {
      throw Exception('Error capturing image: $e');
    }
  }

  //saves image(receipt) to gallery
  static saveImageToGallery({required GlobalKey key, required BuildContext context}) async {
    try{
      Uint8List bytes = await capturePng(key: key);
      final result = await ImageGallerySaverPlus.saveImage(bytes);
      if(result['isSuccess'] == true){
        //show success message
        showFlushBar(
          context: context,
          success: true,
          message: 'Receipt saved to your device',
        );
      }
      else{
        //show error message
        showFlushBar(
          context: context,
          message: defaultErrorMessage,
        );
      }
    }catch(e){
      //show error message
      showFlushBar(
        context: context,
        message: e.toString(),
      );
    }
  }

  //share image(receipt)
  static shareImage({required GlobalKey key, required BuildContext context}) async {
    try{
      Uint8List bytes = await capturePng(key: key);
      final tempDir = await getTemporaryDirectory();
      final file = await File('${tempDir.path}/receipt.png').create();
      file.writeAsBytesSync(bytes);
      final xFile = XFile(file.path);
      //Share.shareXFiles([xFile], text: 'Here is your receipt');
      final params = ShareParams(
        text: 'Here is your receipt',
        files: [xFile],
        // optionally:
        // subject: 'Your Receipt',
        // title: 'Share Receipt',
        // sharePositionOrigin: ... if needed for positioning (e.g. iPad)
      );

      // Perform the share
      final result = await SharePlus.instance.share(params);

      // Optionally check result
      if (result.status == ShareResultStatus.success) {
        //Shared successfully
        showFlushBar(
          context: context,
          success: true,
          message: 'Receipt saved to your device',
        );
      } else if (result.status == ShareResultStatus.dismissed) {
        // User dismissed the share dialog
      } else {
        //Something went wrong or not available
        showFlushBar(
          context: context,
          message: defaultErrorMessage,
        );
      }
    }catch(e){
      //show error message
      showFlushBar(
        context: context,
        message: e.toString(),
      );
    }
  }

}