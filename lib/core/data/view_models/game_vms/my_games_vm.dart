import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../locator.dart';
import '../../../constants/app_constants.dart';
import '../../../utilities/utilities.dart';
import '../../data_provider/game_data_provider.dart';
import '../../enum/view_state.dart';
import '../../models/my_game.dart';
import '../../states/base_state.dart';



class MyGamesVm extends BaseState{

  //game data provider
  final GameDataProvider _gameDp = locator<GameDataProvider>();

  //message
  String _message = '';
  String get message => _message;

  //page number
  int pageNumber = 1;


  //total records
  int totalRecords = 0;


  //my games
  List<MyGame> _myGames = [];
  List<MyGame> get myGames => _myGames;






  //fetch active games
  fetchMyGames({bool firstCall = true, bool refreshUi = true}) async {
    if(firstCall){
      pageNumber = 1;
      if(refreshUi)setState(ViewState.busy);
    }
    else{
      setPaginatedState(ViewState.busy);
    }

    await _gameDp.fetchMyGames(
      pageNumber: pageNumber,
      filterParams: {},
    ).then((response) async{
      _message = response.message ?? defaultSuccessMessage;
      totalRecords = response.data?.total ?? 0;
      if(firstCall){
        //populate list
        _myGames = response.data?.data ?? [];
        setState(ViewState.retrieved);
      }
      else{
        //add to list
        _myGames.addAll(response.data?.data ?? []);
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

final myGamesViewModel = ChangeNotifierProvider.autoDispose<MyGamesVm>((ref){
  return MyGamesVm();
});