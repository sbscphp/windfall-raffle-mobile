import 'dart:async';
import 'package:windfall/core/data/models/game.dart';
import 'package:windfall/core/data/models/my_game.dart';
import 'package:windfall/core/data/models/responses/api_response.dart';
import 'package:windfall/core/data/models/responses/response_data/game_tickets_data.dart';
import 'package:windfall/core/data/models/responses/response_data/pagination_data.dart';

import '../../constants/api_routes.dart';
import '../../utilities/utilities.dart';
import '../enum/request_type.dart';
import '../network_manager/network_manager.dart';





class GameDataProvider{

  //fetch all games(paginated)
  Future<ApiResponse<PaginationData<Game>>> fetchAllGames({required int? pageNumber, Map<String, dynamic>? filterParams, Set<String>? omitKeys, bool enablePagination = true}) async {
    var completer = Completer<ApiResponse<PaginationData<Game>>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(RequestType.get, ApiRoutes.fetchGames(pageNumber: pageNumber, filterParams: Utilities.returnQueryString(params: filterParams, omitKeys: omitKeys), enablePagination: enablePagination),
          useAuth: false
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

  Future<ApiResponse<List<Game>>> fetchLiveGames({required int? pageNumber, required Map<String, dynamic> filterParams}) async {
    var completer = Completer<ApiResponse<List<Game>>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(RequestType.get, ApiRoutes.fetchGames(pageNumber: pageNumber, enablePagination: false),
          useAuth: false
      );
      var result = ApiResponse<List<Game>>.fromJson(
        response,
            (data) => (data as List<dynamic>)
            .map((e) => Game.fromJson(
          e as Map<String, dynamic>,
        ))
            .toList(),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

  Future<ApiResponse<PaginationData<MyGame>>> fetchMyGames({required int? pageNumber, Map<String, dynamic>? filterParams, Set<String>? omitKeys}) async {
    var completer = Completer<ApiResponse<PaginationData<MyGame>>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(RequestType.get, ApiRoutes.fetchMyGames(pageNumber: pageNumber, filterParams: Utilities.returnQueryString(params: filterParams, omitKeys: omitKeys)),
          useAuth: true
      );
      var result = ApiResponse<PaginationData<MyGame>>.fromJson(
        response,
            (data) => PaginationData<MyGame>.fromJson(
          data as Map<String, dynamic>,
              (gameJson) => MyGame.fromJson(gameJson),
        ),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

  //fetch single game
  Future<ApiResponse<Game>> fetchSingleGame({required String? gameId}) async {
    var completer = Completer<ApiResponse<Game>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(RequestType.get, ApiRoutes.fetchSingleGame(gameId: gameId),
        useAuth: true
      );
      var result = ApiResponse<Game>.fromJson(
        response,
            (data) => Game.fromJson(data as Map<String, dynamic>),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

  //fetch related games
  Future<ApiResponse<List<Game>>> fetchRelatedGames({required String? gameId}) async {
    var completer = Completer<ApiResponse<List<Game>>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(RequestType.get, ApiRoutes.fetchRelatedGames(gameId: gameId),
          useAuth: true
      );
      var result = ApiResponse<List<Game>>.fromJson(
        response,
            (data) => (data as List<dynamic>)
            .map((e) => Game.fromJson(
          e as Map<String, dynamic>,
        ))
            .toList(),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

  //fetch game tickets
  Future<ApiResponse<GameTicketsData>> fetchGameTickets({required String? id, required int? pageNumber}) async {
    var completer = Completer<ApiResponse<GameTicketsData>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(RequestType.get, ApiRoutes.fetchGameTickets(id: id, pageNumber: pageNumber),
          useAuth: true
      );
      var result = ApiResponse<GameTicketsData>.fromJson(
        response,
            (data) => GameTicketsData.fromJson(data as Map<String, dynamic>),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

  //fetch my game results
  Future<ApiResponse<PaginationData<MyGame>>> fetchMyGameResults({required int? pageNumber}) async {
    var completer = Completer<ApiResponse<PaginationData<MyGame>>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(RequestType.get, ApiRoutes.fetchMyGameResults(pageNumber: pageNumber),
          useAuth: true
      );
      var result = ApiResponse<PaginationData<MyGame>>.fromJson(
        response,
            (data) => PaginationData<MyGame>.fromJson(
          data as Map<String, dynamic>,
              (gameJson) => MyGame.fromJson(gameJson),
        ),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

}