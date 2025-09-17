import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:windfall/core/data/models/ticket.dart';
import '../../../../locator.dart';
import '../../../constants/app_constants.dart';
import '../../../utilities/utilities.dart';
import '../../data_provider/game_data_provider.dart';
import '../../enum/view_state.dart';
import '../../models/game.dart';
import '../../states/base_state.dart';



class GameTicketsVm extends BaseState{

  //game data provider
  final GameDataProvider _gameDp = locator<GameDataProvider>();

  //message
  String _message = '';
  String get message => _message;


  //page number
  int pageNumber = 1;

  //total records
  int totalRecords = 0;

  //all tickets(for a single game)
  List<Ticket> _tickets = [];
  List<Ticket> get tickets => _tickets;


  //selected game
  Game? game;

  String get name => game?.name ?? 'N/A';
 // int get ticketCount => game?.
  bool get isInstantGame => game?.instantGame?.toLowerCase() == 'true';



  //fetch game tickets
  fetchGameTickets({bool firstCall = true, bool refreshUi = true, required String? id}) async {
    if(firstCall){
      pageNumber = 1;
      if(refreshUi)setState(ViewState.busy);
    }
    else{
      setPaginatedState(ViewState.busy);
    }

    await _gameDp.fetchGameTickets(
      pageNumber: pageNumber,
      id: id
    ).then((response) async{
      _message = response.message ?? defaultSuccessMessage;
      totalRecords = response.data?.tickets?.total ?? 0;
      game = response.data?.game;
      if(firstCall){
        //populate list
        _tickets = response.data?.tickets?.data ?? [];
        setState(ViewState.retrieved);
      }
      else{
        //add to list
        _tickets.addAll(response.data?.tickets?.data ?? []);
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

final gameTicketsViewModel = ChangeNotifierProvider.autoDispose<GameTicketsVm>((ref){
  return GameTicketsVm();
});