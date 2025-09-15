import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:windfall/core/constants/app_constants.dart';
import 'package:windfall/core/data/data_provider/payment_data_provider.dart';
import 'package:windfall/core/data/enum/view_state.dart';
import 'package:windfall/core/data/models/checkout_credentials.dart';
import 'package:windfall/core/data/models/payment_breakdown.dart';
import 'package:windfall/core/data/models/payment_method.dart';
import 'package:windfall/core/data/services/geolocator_service.dart';
import 'package:windfall/core/data/states/base_state.dart';
import 'package:windfall/core/utilities/utilities.dart';
import 'package:windfall/locator.dart';

class PaymentVm extends BaseState {
  //payment data provider
  final PaymentDataProvider _paymentDp = locator<PaymentDataProvider>();

  //message
  String _message = '';
  String get message => _message;

  //payment method message
  String _paymentMethodMessage = '';
  String get paymentMethodMessage => _paymentMethodMessage;


  //payment breakdown
  PaymentBreakdown? paymentBreakdown;

  //promo code used
  String? promoCodeApplied;

  //referral amount used
  double? refAmountUsed;


  //list of payment methods
  List<PaymentMethod> _paymentMethods = [];
  List<PaymentMethod> get paymentMethods => _paymentMethods;

  //payment method
  PaymentMethod? _selectedPaymentMethod;
  PaymentMethod? get selectedPaymentMethod => _selectedPaymentMethod;
  set selectedPaymentMethod(PaymentMethod? val){
    _selectedPaymentMethod = val;
    notifyListeners();
  }

  //selected payment channel
  String? _selectedPaymentType;
  String? get selectedPaymentType => _selectedPaymentType;
  set selectedPaymentType(String? val){
    _selectedPaymentType = val;
    notifyListeners();
  }


  //list of payment types
  List<String> get paymentTypes => Utilities.parseStringToList(_selectedPaymentMethod?.paymentChannels ?? '');


  //checkout data(for paystack and flutterwave)
  CheckoutCredentials? checkoutData;

  //checkout values
  String get authUrl => checkoutData?.authorizationUrl ?? '';
  String get reference => checkoutData?.reference ?? '';
  String get successRedirectUrl => checkoutData?.successRedirect ?? '';
  String get failureRedirectUrl => checkoutData?.failureRedirect ?? '';
  String get callbackUrl => checkoutData?.callback ?? '';
  String get orderId => checkoutData?.orderId ?? '';


  //payment breakdown values
  //int get quantity => paymentBreakdown?.quantity ?? 1;
  double get totalAmount => double.tryParse(paymentBreakdown?.totalAmount?.toString() ?? '0') ?? 0;
  //double get gameTicketDiscount => double.tryParse(paymentBreakdown?.gameTicketDiscount?.toString() ?? '0') ?? 0;
  double get promoAmount => double.tryParse(paymentBreakdown?.promoAmount?.toString() ?? '0') ?? 0;
  double get referralAmount => double.tryParse(paymentBreakdown?.referralAmountUsed?.toString() ?? '0') ?? 0;
  double get amountToPay => double.tryParse(paymentBreakdown?.amountToPay?.toString() ?? '0') ?? 0;


  //fetch payment methods
  // fetchPaymentMethods() async {
  //
  //   setThirdState(ViewState.busy);
  //
  //   await _paymentDp.fetchPaymentMethods().then(
  //           (response) async {
  //         _paymentMethodMessage = response.message ?? defaultSuccessMessage;
  //         _paymentMethods = response.data ?? [];
  //         reset();
  //         setThirdState(ViewState.retrieved);
  //       }, onError: (e) {
  //     _message = Utilities.formatMessage(e.toString(), isSuccess: false);
  //     setThirdState(ViewState.error);
  //   });
  // }


  //fetch payment breakdown
  fetchPaymentBreakdown(
      {required String gameId,
      required int quantity,
      required double amount,
      required double refBonus,
      required String promoCode,
      required bool useReferral,
        required bool referralApplied,
      required bool usePromoCode}) async {

    setState(ViewState.busy);

    final details = {
      "game_id": gameId,
      "quantity": quantity,
      "amount": amount,
    };

    if(useReferral && refBonus != 0 && referralApplied){
      details["referral_balance_amount"] = refBonus;
    }

    if(usePromoCode && promoCode.isNotEmpty){
      details["promo_code"] = promoCode;
    }

    await _paymentDp.fetchPaymentBreakdown(details: details).then(
        (response) async {
      _message = response.message ?? defaultSuccessMessage;
      paymentBreakdown = response.data;

      if(details.containsKey('referral_balance_amount')){
        refAmountUsed = refBonus;
      }
      else{
        refAmountUsed = null;
      }

      if(details.containsKey('promo_code')){
        promoCodeApplied = promoCode;
      }
      else{
        promoCodeApplied = null;
      }


      setState(ViewState.retrieved);
    }, onError: (e) {
      _message = Utilities.formatMessage(e.toString(), isSuccess: false);
      setState(ViewState.error);
    });
  }

  //initiate checkout
  // initiateCheckout(
  //     {required String gameId}) async {
  //
  //   setSecondState(ViewState.busy);
  //
  //   final pos = await locator<GeoLocatorService>().getCurrentLocation();
  //
  //   final details = {
  //     "game_id": gameId,
  //     "platform": "mobile",
  //     "payment_method": selectedPaymentMethod?.slug?.toLowerCase(), //flutterwave, paystack
  //     "payment_channel": selectedPaymentType?.toLowerCase(), //ussd, card, bank transfer
  //     "quantity": quantity,
  //     "amount": amountToPay,
  //   };
  //
  //   if(promoCodeApplied != null){
  //     details['promo_code'] = promoCodeApplied;
  //   }
  //
  //   if(refAmountUsed != null){
  //     details['referral_balance_amount'] = refAmountUsed;
  //   }
  //
  //   if(pos != null){
  //     details['geolocation'] = {
  //       "lat": pos.latitude,
  //       "lng": pos.longitude
  //     };
  //   }
  //
  //
  //   await _paymentDp.initiateCheckout(details: details).then(
  //           (response) async {
  //         _message = response.message ?? defaultSuccessMessage;
  //         checkoutData = response.data;
  //         setSecondState(ViewState.retrieved);
  //       }, onError: (e) {
  //     _message = Utilities.formatMessage(e.toString(), isSuccess: false);
  //     setSecondState(ViewState.error);
  //   });
  // }


  resetPaymentVariables(){
    _selectedPaymentMethod = null;
    _selectedPaymentType = null;
  }


  reset(){
    _selectedPaymentMethod = null;
    _selectedPaymentType = null;
    promoCodeApplied = null;
    refAmountUsed = null;
    checkoutData = null;
  }
}

final paymentViewModel = ChangeNotifierProvider<PaymentVm>((ref) {
  return PaymentVm();
});
