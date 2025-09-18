import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:windfall/core/data/models/my_game.dart';

import '../../../../locator.dart';
import '../../../constants/app_constants.dart';
import '../../../utilities/utilities.dart';
import '../../data_provider/game_data_provider.dart';
import '../../enum/view_state.dart';
import '../../states/base_state.dart';


class MyGameFiltersVm extends BaseState{

  //poll data provider
  final GameDataProvider _gameDp = locator<GameDataProvider>();

  //message
  String _message = '';
  String get message => _message;

  //list of filtered results(polls)
  List<MyGame> _filteredResults = [];
  List<MyGame> get filteredResults => _filteredResults;

  //page number
  int pageNumber = 1;

  //total records
  int totalRecords = 0;

  //filter options
  Map<String, dynamic> filterOptions = {};

  bool _showFilteredList = false;
  bool get showFilteredList => _showFilteredList;
  set showFilteredList(bool val){
    _showFilteredList = val;
    notifyListeners();
  }

  final List<String> categories = ['Show All', 'Draw in View', 'Draw Completed'];

  //fetch filtered results(games)
  fetchFilteredResults({bool firstCall = true, bool refreshUi = true}) async {
    if(firstCall){
      pageNumber = 1;
      if(refreshUi)setState(ViewState.busy);
    }
    else{
      setPaginatedState(ViewState.busy);
    }

    await _gameDp.fetchMyGames(
        pageNumber: pageNumber,
        filterParams: filterOptions,
        omitKeys: {'filter_by_real'} //filter out this key so its not sent to backend to filter games
    ).then((response) async{
      _message = response.message ?? defaultSuccessMessage;
      totalRecords = response.data?.total ?? 0;
      if(firstCall){
        //populate list
        _filteredResults = response.data?.data ?? [];
        _showFilteredList = true;
        setState(ViewState.retrieved);
      }
      else{
        //add to list
        _filteredResults.addAll(response.data?.data ?? []);
        setPaginatedState(ViewState.retrieved);
      }
      pageNumber++;
      debugPrint("length of filtered games::::${_filteredResults.length}>>>");
    }, onError: (e) {
      _message = Utilities.formatMessage(e.toString(), isSuccess: false);
      if(firstCall){
        setState(ViewState.error);
      }else{
        setPaginatedState(ViewState.error);
      }
    });
  }

  setFilterOptions({String? selectedCategory, String? startDate, String? endDate}){

    if(selectedCategory != null){
      filterOptions["filter_by_real"] = selectedCategory;
      if(selectedCategory.toLowerCase() == 'show all'){
        filterOptions.remove('filter_by');
      }else{
        filterOptions["filter_by"] = selectedCategory.toLowerCase() == 'draw in view' ? 'upcoming':'ended';
      }

    }

    if(startDate != null){
      filterOptions["start_date"] = startDate;
    }

    if(endDate != null){
      filterOptions["end_date"] = endDate;
    }

  }

  clearFilters(){
    _showFilteredList = false;
    filterOptions = {};
    notifyListeners();
  }
}

final myGameFiltersViewModel = ChangeNotifierProvider.autoDispose<MyGameFiltersVm>((ref){
  return MyGameFiltersVm();
});