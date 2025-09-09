import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../locator.dart';
import '../../../constants/app_constants.dart';
import '../../../utilities/utilities.dart';
import '../../data_provider/game_data_provider.dart';
import '../../enum/view_state.dart';
import '../../models/game.dart';
import '../../states/base_state.dart';



class RelatedGamesVm extends BaseState{

  //game data provider
  final GameDataProvider _gameDp = locator<GameDataProvider>();

  //message
  String _message = '';
  String get message => _message;


  //all games
  List<Game> _relatedGames = [];
  List<Game> get relatedGames => _relatedGames;


  //fetch related games
  fetchRelatedGames({required String? gameId}) async {
    setState(ViewState.busy);
    await _gameDp
        .fetchRelatedGames(
        gameId: gameId
    )
        .then((response) {
      _message = response.message ?? defaultSuccessMessage;
      _relatedGames = response.data ?? [];
      setState(ViewState.retrieved);
    }, onError: (e) {
      _message = Utilities.formatMessage(e.toString(), isSuccess: false);
      setState(ViewState.error);
    });
  }
}

final relatedGamesViewModel = ChangeNotifierProvider.family<RelatedGamesVm, String?>(
      (ref, gameId) => RelatedGamesVm(),
);