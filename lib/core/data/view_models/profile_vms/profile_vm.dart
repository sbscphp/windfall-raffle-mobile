import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:windfall/core/data/states/base_state.dart';

class ProfileVm extends BaseState {


  //message
  String _message = '';
  String get message => _message;

}

final profileViewModel =
    ChangeNotifierProvider.autoDispose<ProfileVm>((ref) {
  return ProfileVm();
});
