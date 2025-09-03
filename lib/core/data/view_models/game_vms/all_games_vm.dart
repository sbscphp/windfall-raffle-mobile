import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../locator.dart';
import '../../../constants/app_constants.dart';
import '../../../utilities/utilities.dart';
import '../../data_provider/game_data_provider.dart';
import '../../enum/view_state.dart';
import '../../models/game.dart';
import '../../states/base_state.dart';



class AllGamesVm extends BaseState{

  //game data provider
  final GameDataProvider _gameDp = locator<GameDataProvider>();

  //message
  String _message = '';
  String get message => _message;


  //page number
  int pageNumber = 1;

  //total records
  int totalRecords = 0;

  //all games
  List<Game> _allGames = [];
  List<Game> get allGames => _allGames;

  //live games
  List<Game> _liveGames = [];
  List<Game> get liveGames => _liveGames;


  //selected game
  Game? selectedGame;


  //fetch all games
  fetchAllGames({bool firstCall = true, bool refreshUi = true}) async {
    if(firstCall){
      pageNumber = 1;
      if(refreshUi)setState(ViewState.busy);
    }
    else{
      setPaginatedState(ViewState.busy);
    }

    await _gameDp.fetchAllGames(
      pageNumber: pageNumber,
    ).then((response) async{
      _message = response.message ?? defaultSuccessMessage;
      totalRecords = response.data?.total ?? 0;
      if(firstCall){
        //populate list
        _allGames = response.data?.data ?? [];
        setState(ViewState.retrieved);
      }
      else{
        //add to list
        _allGames.addAll(response.data?.data ?? []);
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

  //fetch live games
  fetchLiveGames() async {
    setSecondState(ViewState.busy);
    await _gameDp
        .fetchLiveGames(
      pageNumber: 1,
      filterParams: {'type': 'live'}
    )
        .then((response) {
      //_message = response.message ?? defaultSuccessMessage;
      _liveGames = response.data ?? [];
      setSecondState(ViewState.retrieved);
    }, onError: (e) {
      //_message = Utilities.formatMessage(e.toString(), isSuccess: false);
      setSecondState(ViewState.error);
    });
  }









}

final allGamesViewModel = ChangeNotifierProvider.autoDispose<AllGamesVm>((ref){
  return AllGamesVm();
});