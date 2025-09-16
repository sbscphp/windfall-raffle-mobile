import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../locator.dart';
import '../../constants/app_constants.dart';
import '../../utilities/utilities.dart';
import '../data_provider/referral_data_provider.dart';
import '../enum/view_state.dart';
import '../models/referral.dart';
import '../states/base_state.dart';



class ReferralVm extends BaseState{

  //referral data provider
  final ReferralDataProvider _referralDp = locator<ReferralDataProvider>();

  //message
  String _earnedMessage = '';
  String get earnedMessage => _earnedMessage;

  String _usedMessage = '';
  String get usedMessage => _usedMessage;

  //page number
  int earnedPageNumber = 1;
  int usedPageNumber = 1;

  //total records
  int earnedTotalRecords = 0;
  int usedTotalRecords = 0;

  //referral history(used)
  List<Referral> _usedHistory = [];
  List<Referral> get usedHistory => _usedHistory;

  //referral history(earned)
  List<Referral> _earnedHistory = [];
  List<Referral> get earnedHistory => _earnedHistory;

  double _referralBalance = 0;
  double get referralBalance => _referralBalance;
  set referralBalance(dynamic value){
    _referralBalance = double.tryParse(value?.toString() ?? '0') ?? 0;
    notifyListeners();
  }

  String _referralCode = '';
  String get referralCode => _referralCode;
  set referralCode(String val){
    _referralCode = val;
  }


  bool get hasReferralBonus => _referralBalance > 0;




  //fetch referral history(earned)
  fetchEarnedHistory({bool firstCall = true, bool refreshUi = true}) async {
    if(firstCall){
      earnedPageNumber = 1;
      if(refreshUi)setState(ViewState.busy);
    }
    else{
      setPaginatedState(ViewState.busy);
    }

    await _referralDp.fetchReferralHistory(
      pageNumber: earnedPageNumber,
      filterOption: 'awarded'
    ).then((response) async{
      _earnedMessage = response.message ?? defaultSuccessMessage;
      earnedTotalRecords = response.data?.transactions?.total ?? 0;
      _referralBalance = double.tryParse(response.data?.totalBalance?.toString() ?? '0') ?? 0;
      if(firstCall){
        //populate list
        _earnedHistory = response.data?.transactions?.data ?? [];
        setState(ViewState.retrieved);
      }
      else{
        //add to list
        _earnedHistory.addAll(response.data?.transactions?.data ?? []);
        setPaginatedState(ViewState.retrieved);
      }
      earnedPageNumber++;
    }, onError: (e) {
      _earnedMessage = Utilities.formatMessage(e.toString(), isSuccess: false);
      if(firstCall){
        setState(ViewState.error);
      }else{
        setPaginatedState(ViewState.error);
      }
    });
  }


  //fetch referral history(used)
  fetchUsedHistory({bool firstCall = true, bool refreshUi = true}) async {
    if(firstCall){
      usedPageNumber = 1;
      if(refreshUi)setSecondState(ViewState.busy);
    }
    else{
      setSecondPaginatedState(ViewState.busy);
    }

    await _referralDp.fetchReferralHistory(
        pageNumber: usedPageNumber,
        filterOption: 'redeemed'
    ).then((response) async{
      _usedMessage = response.message ?? defaultSuccessMessage;
      usedTotalRecords = response.data?.transactions?.total ?? 0;
      _referralBalance = double.tryParse(response.data?.totalBalance?.toString() ?? '0') ?? 0;
      if(firstCall){
        //populate list
        _usedHistory = response.data?.transactions?.data ?? [];
        setSecondState(ViewState.retrieved);
      }
      else{
        //add to list
        _usedHistory.addAll(response.data?.transactions?.data ?? []);
        setSecondPaginatedState(ViewState.retrieved);
      }
     usedPageNumber++;
    }, onError: (e) {
      _usedMessage = Utilities.formatMessage(e.toString(), isSuccess: false);
      if(firstCall){
        setSecondState(ViewState.error);
      }else{
        setSecondPaginatedState(ViewState.error);
      }
    });
  }










  String shareMessage({required String referralCode, required String referralLink}){
    return '''
Hey! 👋 I just signed up to WinIt – a new Raffle platform where you Play to Own a property in Lagos State.  It’s simple, exciting, and you stand a chance to win your own home.

Use my referral code $referralCode to sign up and get N500 reward after you have played your first game. 
$referralLink

WinIt - Play to own
''';
  }



}

final referralViewModel = ChangeNotifierProvider<ReferralVm>((ref){
  return ReferralVm();
});