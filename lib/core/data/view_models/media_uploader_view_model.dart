import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:windfall/core/utilities/image_and_doc_utils.dart';

enum MediaState { idle, loading, loaded, error }

class MediaUploaderViewModel extends ChangeNotifier {
  File? _uploadedImage;
  File? get uploadedImage => _uploadedImage;

  MediaState _mediaState = MediaState.idle;
  MediaState get mediaState => _mediaState;
  void setMediaState(MediaState state) {
    _mediaState = state;
    notifyListeners();
  }

  Future<void> uploadImage(BuildContext context) async {
    try {
      setMediaState(MediaState.loading);
      _uploadedImage = await ImageAndDocUtils.pickImage(context: context);
      setMediaState(MediaState.loaded);
      notifyListeners();
    } catch (e) {
      setMediaState(MediaState.error);
      notifyListeners();
    }
  }
}

final mediaUploaderViewModel =
    ChangeNotifierProvider.autoDispose<MediaUploaderViewModel>((ref) {
      return MediaUploaderViewModel();
    });
