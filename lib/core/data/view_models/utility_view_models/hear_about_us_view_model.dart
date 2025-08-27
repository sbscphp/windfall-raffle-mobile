// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:winit/core/constants/app_constants.dart';
// import 'package:winit/core/data/data_provider/utility_data_provider/utility_data_provider.dart';
// import 'package:winit/core/data/enum/view_state.dart';
// import 'package:winit/core/data/states/base_state.dart';
// import 'package:winit/core/utilities/utilities.dart';
// import 'package:winit/locator.dart';
//
// class HearAboutUsViewModel extends BaseState{
//
//   //utility data provider
//   final UtilityDataProvider _utilityDp = locator<UtilityDataProvider>();
//
//   //message
//   String _message = '';
//   String get message => _message;
//
//   List<String> _options = [];
//   List<String> get options => _options;
//
//   String? _selectedOption;
//   String? get selectedOption => _selectedOption;
//   set selectedOption(String? val){
//     _selectedOption = val;
//     notifyListeners();
//   }
//
//   bool get showField => _selectedOption?.toLowerCase() == _options.last.toLowerCase();
//
//
//
//   //fetch 'hear about us' options
//   fetchHearAboutUs() async {
//     setState(ViewState.busy);
//     await _utilityDp.fetchHearAboutUs().then((response) async{
//       _message = response.message ?? defaultSuccessMessage;
//       _options = response.data  ?? [];
//       print('length::::${_options.length}>>>>');
//       setState(ViewState.retrieved);
//     }, onError: (e) {
//       _message = Utilities.formatMessage(e.toString(), isSuccess: false);
//       setState(ViewState.error);
//     });
//   }
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
// }
//
// final hearAboutUsViewModel = ChangeNotifierProvider<HearAboutUsViewModel>((ref){
//   return HearAboutUsViewModel();
// });