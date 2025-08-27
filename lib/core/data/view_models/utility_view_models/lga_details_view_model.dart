import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../locator.dart';
import '../../../constants/app_constants.dart';
import '../../../utilities/utilities.dart';
import '../../data_provider/utility_data_provider/utility_data_provider.dart';
import '../../enum/view_state.dart';
import '../../models/lga_details.dart';
import '../../states/base_state.dart';


class LgaDetailsViewModel extends BaseState{

  //utility data provider
  final UtilityDataProvider _utilityDp = locator<UtilityDataProvider>();

  //message
  String _message = '';
  String get message => _message;

  List<LgaDetails> _lgas = [];
  List<LgaDetails> get lgas => _lgas;

  List<String> areas = [];

  List<String> get lgaNames => _lgas.map((lga) => lga.lga ?? '').toList();




  //fetch lga details
  fetchLgaDetails() async {
    setState(ViewState.busy);
    await _utilityDp.fetchLgaDetails().then((response) async{
      _message = response.message ?? defaultSuccessMessage;
      _lgas = response.data ?? [];
      setState(ViewState.retrieved);
    }, onError: (e) {
      _message = Utilities.formatMessage(e.toString(), isSuccess: false);
      setState(ViewState.error);
    });
  }


  populateAreas({required String selectedLga, bool refreshUi = true}){
    try{
      areas = _lgas.firstWhere((lga) => lga.lga?.toLowerCase() == selectedLga.toLowerCase()).wards ?? [];
    }catch(e){
      areas = [];
    }
    if(refreshUi)notifyListeners();
  }
















}

final lgaDetailsViewModel = ChangeNotifierProvider<LgaDetailsViewModel>((ref){
  return LgaDetailsViewModel();
});