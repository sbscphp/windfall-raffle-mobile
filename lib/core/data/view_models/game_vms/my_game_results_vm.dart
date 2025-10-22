import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../locator.dart';
import '../../../constants/app_constants.dart';
import '../../../utilities/utilities.dart';
import '../../data_provider/game_data_provider.dart';
import '../../enum/view_state.dart';
import '../../models/my_game.dart';
import '../../states/base_state.dart';



class MyGameResultsVm extends BaseState{

  //game data provider
  final GameDataProvider _gameDp = locator<GameDataProvider>();

  //message
  String _message = '';
  String get message => _message;

  //page number
  int pageNumber = 1;


  //total records
  int totalRecords = 0;


  //my game results
  List<MyGame> _myGameResults = [];
  List<MyGame> get myGameResults => _myGameResults;



  //fetch game results
  fetchMyGameResults({bool firstCall = true, bool refreshUi = true}) async {
    if(firstCall){
      pageNumber = 1;
      if(refreshUi)setState(ViewState.busy);
    }
    else{
      setPaginatedState(ViewState.busy);
    }

    await _gameDp.fetchMyGameResults(
      pageNumber: pageNumber,
    ).then((response) async{
      _message = response.message ?? defaultSuccessMessage;
      totalRecords = response.data?.total ?? 0;
      if(firstCall){
        //populate list
        _myGameResults = response.data?.data ?? [];
        setState(ViewState.retrieved);
      }
      else{
        //add to list
        _myGameResults.addAll(response.data?.data ?? []);
        setPaginatedState(ViewState.retrieved);
      }
      pageNumber++;
    }, onError: (e) {
      _message = Utilities.formatMessage(e.toString(), isSuccess: false);
      if(firstCall){
        setState(ViewState.error);
      }else{
        setPaginatedState(ViewState.error);
      }
    });
  }





}

final myGameResultsViewModel = ChangeNotifierProvider<MyGameResultsVm>((ref){
  return MyGameResultsVm();
});