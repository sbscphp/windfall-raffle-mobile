import 'dart:async';
import 'dart:convert';

import 'package:windfall/core/data/models/game.dart';
import 'package:windfall/core/data/models/responses/api_response.dart';
import 'package:windfall/core/data/models/responses/response_data/pagination_data.dart';

import '../../constants/api_routes.dart';
import '../enum/request_type.dart';
import '../network_manager/network_manager.dart';





class GameDataProvider{

  //fetch all games
  Future<ApiResponse<PaginationData<Game>>> fetchAllGames({required int? pageNumber}) async {
    var completer = Completer<ApiResponse<PaginationData<Game>>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(RequestType.post, ApiRoutes.fetchGames(pageNumber: pageNumber),
          useAuth: false,
          body: jsonEncode({
            "paginate": true,
            "limit": 10
          })
      );
      var result = ApiResponse<PaginationData<Game>>.fromJson(
        response,
            (data) => PaginationData<Game>.fromJson(
          data as Map<String, dynamic>,
              (gameJson) => Game.fromJson(gameJson),
        ),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

  //fetch single game
  // Future<SingleGameResponse> fetchSingleGame({required String? gameId}) async {
  //   var completer = Completer<SingleGameResponse>();
  //   try {
  //     Map<String, dynamic> response = await NetworkManager()
  //         .networkRequestManager(RequestType.get, ApiRoutes.fetchSingleGame(gameId: gameId),
  //         useAuth: false,
  //     );
  //     var result = SingleGameResponse.fromJson(response);
  //     completer.complete(result);
  //   } catch (e) {
  //     completer.completeError(e);
  //   }
  //   return completer.future;
  // }
  //
  // //fetch order tickets
  // Future<OrderTicketResponse> fetchOrderTickets({required String? orderId}) async {
  //   var completer = Completer<OrderTicketResponse>();
  //   try {
  //     Map<String, dynamic> response = await NetworkManager()
  //         .networkRequestManager(RequestType.get, ApiRoutes.getTicketsByOrderId(orderId: orderId),
  //       useAuth: true,
  //     );
  //     var result = OrderTicketResponse.fromJson(response);
  //     completer.complete(result);
  //   } catch (e) {
  //     completer.completeError(e);
  //   }
  //   return completer.future;
  // }
  //
  // //fetch my games
  // Future<MyGamesResponse> fetchMyGames({required int? pageNumber, required Map<String, dynamic> details}) async {
  //   var completer = Completer<MyGamesResponse>();
  //   try {
  //     Map<String, dynamic> response = await NetworkManager()
  //         .networkRequestManager(RequestType.post, ApiRoutes.fetchMyGames(pageNumber: pageNumber),
  //         useAuth: true,
  //         body: jsonEncode(details)
  //     );
  //     var result = MyGamesResponse.fromJson(response);
  //     completer.complete(result);
  //   } catch (e) {
  //     completer.completeError(e);
  //   }
  //   return completer.future;
  // }
  //
  // //fetch ticket status for a game(active and concluded games)
  // Future<GameTicketStatusResponse> fetchGameResult({required int? pageNumber, required String? id}) async {
  //   var completer = Completer<GameTicketStatusResponse>();
  //   try {
  //     Map<String, dynamic> response = await NetworkManager()
  //         .networkRequestManager(RequestType.post, ApiRoutes.fetchGameTicketStatus(id: id, pageNumber: pageNumber),
  //         useAuth: true,
  //         body: jsonEncode({
  //           "limit": 20
  //         })
  //     );
  //     var result = GameTicketStatusResponse.fromJson(response);
  //     completer.complete(result);
  //   } catch (e) {
  //     completer.completeError(e);
  //   }
  //   return completer.future;
  // }








}