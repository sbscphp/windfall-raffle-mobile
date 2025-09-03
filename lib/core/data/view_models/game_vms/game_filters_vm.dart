import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../locator.dart';
import '../../../constants/app_constants.dart';
import '../../../utilities/utilities.dart';
import '../../data_provider/game_data_provider.dart';
import '../../enum/view_state.dart';
import '../../models/game.dart';
import '../../states/base_state.dart';


class GameFiltersVm extends BaseState{

  //poll data provider
  final GameDataProvider _gameDp = locator<GameDataProvider>();

  //message
  String _message = '';
  String get message => _message;

  //list of filtered results(polls)
  List<Game> _filteredResults = [];
  List<Game> get filteredResults => _filteredResults;

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

  final List<String> categories = ['All', 'Live', 'Upcoming', 'Instant'];

  final List<String> drawDates = ['7 days', '3 days', 'Next 24 hours'];

  //fetch filtered results(games)
  fetchFilteredResults({bool firstCall = true, bool refreshUi = true}) async {
    if(firstCall){
      pageNumber = 1;
      if(refreshUi)setState(ViewState.busy);
    }
    else{
      setPaginatedState(ViewState.busy);
    }

    await _gameDp.fetchAllGames(
        pageNumber: pageNumber,
        filterParams: filterOptions,
        omitKeys: {'time_preset_real'} //filter out this key so its not sent to backend to filter games
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

  setFilterOptions({String? selectedCategory, String? startDate, String? endDate, String? selectedDrawDate}){

    print('selected category:::$selectedCategory>>>');

    if(selectedCategory != null){
      print('should enter here>>>');
      filterOptions["type"] = selectedCategory.toLowerCase();
      print('should enter here 2>>>${filterOptions["type"]}');
    }

    if(selectedDrawDate != null){
      final index = drawDates.indexOf(selectedDrawDate);
      filterOptions["time_preset"] = index > 1 ? selectedDrawDate.toLowerCase().replaceAll(' ', '_')
          : "Next ${selectedDrawDate}".toLowerCase().replaceAll(" ", "_");
      //used for initialization on the UI(not sent to backend as filter param)
      filterOptions['time_preset_real'] = selectedDrawDate;
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

final gameFiltersViewModel = ChangeNotifierProvider.autoDispose<GameFiltersVm>((ref){
  return GameFiltersVm();
});