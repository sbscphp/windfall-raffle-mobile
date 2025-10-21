import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:windfall/core/data/models/discount_tier.dart';
import 'package:windfall/core/data/models/ticket_tier.dart';
import '../../../../locator.dart';
import '../../../constants/app_constants.dart';
import '../../../utilities/utilities.dart';
import '../../data_provider/game_data_provider.dart';
import '../../enum/view_state.dart';
import '../../models/cart_product.dart';
import '../../models/game.dart';
import '../../models/prize.dart';
import '../../states/base_state.dart';


class SingleGameVm extends BaseState{

  //game data provider
  final GameDataProvider _gameDp = locator<GameDataProvider>();

  //message
  String _message = '';
  String get message => _message;

  //game
  Game? game;

  //selected ticket
  //TicketTier? selectedTicket;

  double _unitPrice = 0;
  double get unitPrice => _unitPrice;

  double _discountUnitPrice = 0;
  double get discountUnitPrice => _discountUnitPrice;

  double _totalPrice = 0;
  double get totalPrice => _totalPrice;


  double _quantity = 1;
  double get quantity => _quantity;
  set quantity(double val){
    _quantity = val;
    notifyListeners();
  }



  String get name => game?.name ?? 'N/A';
  String get gameId => game?.uuid ?? '';
  String get ctaText => game?.ctaText ?? 'Play Now';
  List<TicketTier> get tickets => game?.ticketTiers ?? [];
  String get discountType => game?.discount?.type ?? '';
  double get maxPurchaseAmount => double.tryParse(game?.maximumTicketAmountPurchase?.toString() ?? '0') ?? 0;
  bool get usePromoCode => game?.allowPromoCodeUsage?.toLowerCase() == 'true';
  bool get useReferralBonus => game?.allowReferralBalanceUsage?.toLowerCase() == 'true';
  List<DiscountTier> get discountTiers => game?.discount?.tiers ?? [];
  String get competitionDetails => game?.competitionDetails ?? 'N/A';
  String get sponsorShipDetails => game?.sponsorshipDetails ?? 'N/A';
  List<String> get images => Utilities.parseStringToList(game?.galleryImages ?? '');
  String get description => game?.description ?? 'N/A';
  String get status => game?.mainActiveStatus ?? '';
  bool get isInstantGame => game?.instantGame?.toLowerCase() == 'true';
  bool get isUpComing => status.toLowerCase() == 'upcoming';
  bool get isLive => status.toLowerCase() == 'live';
  bool get isEnded => status.toLowerCase() == 'ended';
  DateTime get drawDate => game?.drawDate ?? DateTime.now();
  bool get hasDiscount => _discountUnitPrice != _unitPrice;
  int get availableTickets => game?.maximumTicketNumberPurchase ?? 1;
  int get minQuantity => game?.minimumTicketNumberPurchase ?? 1;
  double get minEntryPrice => double.tryParse(game?.ticketPrice?.toString() ?? '0') ?? 0;
  double get maxPerson => double.tryParse(game?.maximumTicketNumberPurchase?.toString() ?? '0') ?? 0;
  List<Prize> get instantPrizes => game?.prizes ?? [];




  //fetch game details
  fetchSingleGame(
      {required String? gameId, bool refreshUi = true}) async {

    if(refreshUi)setState(ViewState.busy);

    await _gameDp.fetchSingleGame(gameId: gameId).then((response) async{
      _message = response.message ?? defaultSuccessMessage;
      game = response.data;
      _unitPrice = double.tryParse(game?.ticketPrice?.toString() ?? '0') ?? 0;
      _quantity = minQuantity.toDouble();
      calculatePrice(isUnitPriceCalculation: true);
      print('price:::$_unitPrice .... discount:$_discountUnitPrice>>>>');
      setState(ViewState.retrieved);
    }, onError: (e) {
      _message = Utilities.formatMessage(e.toString(), isSuccess: false);
      setState(ViewState.error);
    });
  }

  //calculates price based on quantity selected by user
  calculatePrice({bool isUnitPriceCalculation = false}){

    double price = 0;
    double unitPrice = double.tryParse(game?.ticketPrice?.toString() ?? '0') ?? 0;

    //check discount type
    if(discountType.toLowerCase() == 'straight_line' || discountType.isEmpty){
      double value = double.tryParse(game?.discount?.value?.toString() ?? '0') ?? 0;
      price = _returnNewAmount(
          value: value,
          quantity: _quantity.toInt(),
           unitPrice: unitPrice,
        isUnitPriceCalculation: isUnitPriceCalculation
      );
    }
    else if(discountType.toLowerCase() == 'band'){
      final selectedTier = _returnSelectedTier(quantity: _quantity.toInt());
      price = _returnNewAmount(
          value:double.tryParse(selectedTier?.value?.toString() ?? '0') ?? 0,
          quantity: _quantity.toInt(),
          unitPrice: unitPrice,
         isUnitPriceCalculation: isUnitPriceCalculation
      );
    }

    _discountUnitPrice = price;
    notifyListeners();
  }

  //returns the tier whose min–max range includes the given quantity.
  DiscountTier? _returnSelectedTier({required int quantity}) {
    for (final tier in discountTiers) {
      if (tier.min != null && tier.max != null) {
        if (quantity >= tier.min! && quantity <= tier.max!) {
          return tier;
        }
      }
    }
    return null;
  }

  //returns new amount based on discount percentage(value), quantity and unit price.
  double _returnNewAmount({required double value, required int quantity, required double unitPrice, bool isUnitPriceCalculation = false}) {

    double amount = 0;

    if(value == 0){
      //discount value is zero, return quantity selected * unit price
      amount = isUnitPriceCalculation ? unitPrice : quantity * unitPrice;
    }else{
      final multiplier = unitPrice - ((value/100) * unitPrice);
      amount = isUnitPriceCalculation ? multiplier : multiplier * quantity;
    }
    return amount;
  }

  //checks when a user crosses the purchase amount threshold for a game
  bool purchaseAmountLimitExceed({required double amount}){
    return amount > maxPurchaseAmount;
  }


  //returns an instance of a cart item for checkout
  CartProduct generateCheckout(){
    return CartProduct(
      gameId: gameId,
      cardImage: game?.cardImage,
      gameName: name,
      description: description,
      discountedUnitPrice: _discountUnitPrice.toString(),
      unitPrice: _unitPrice.toString(),
      quantity: _quantity.toInt(),
      totalPrice: (_discountUnitPrice * _quantity).toString(),
      instantGame: game?.instantGame,
    );
  }

  //Checks if main draw has ended


  // Future<bool> isMainDrawEnded()async{
  //   final endDate = mainDraw.endDate ?? DateTime.now();
  //   //final endDate = sampleEndDate ?? DateTime.now(); //todo: update later ... VERY IMPORTANT
  //   final diff = endDate.difference(DateTime.now());
  //   RemainingTime t =  diff.isNegative
  //       ? RemainingTime.zero
  //       : RemainingTime.fromDuration(diff);
  //   return _isZero(t);
  // }

  //checks if time remains
  // bool _isZero(RemainingTime t) =>
  //     t.days == 0 && t.hours == 0 && t.minutes == 0 && t.seconds == 0;

}

final singleGameViewModel = ChangeNotifierProvider.family.autoDispose<SingleGameVm, String?>(
      (ref, gameId) => SingleGameVm(),
);

final gameIdProvider = Provider<String>((ref) {
  throw UnimplementedError('Must override gameId provider');
});