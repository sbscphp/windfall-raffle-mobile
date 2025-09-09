import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:windfall/core/data/enum/checkout_type.dart';
import 'package:windfall/core/data/models/cart_product.dart';
import '../../../../locator.dart';
import '../data_provider/cart_data_provider.dart';
import '../states/base_state.dart';



class CheckoutVm extends BaseState{

  //game data provider
  final CartDataProvider _cartDp = locator<CartDataProvider>();

  //message
  String _message = '';
  String get message => _message;

  //list of checkout items
  List<CartProduct> _checkoutItems = [];
  List<CartProduct> get checkoutItems => _checkoutItems;

  CheckoutType? _checkoutType;
  CheckoutType? get checkoutType => _checkoutType;
  set checkoutType(CheckoutType? val){
    _checkoutType = val;
  }

  int get checkoutCount => _checkoutItems.length;
  int get totalTicketCount => _totalTicketNumber();
  double get totalPrice => _totalPrice();




  initCheckoutItems({required dynamic input}){
    _checkoutItems.clear();
    if(checkoutType == CheckoutType.buyNow){
      //add instance of cart item to checkout list
      _checkoutItems.add(input);
    }else{
      //create a list off the cart list
      _checkoutItems = List.of(input);
    }
  }

  int _totalTicketNumber(){
    int result = 0;
    for(CartProduct a in _checkoutItems){
      result += a.quantity ?? 1;
    }
    return result;
  }

  double _totalPrice(){
    double result = 0;
    for(CartProduct a in _checkoutItems){
      result += double.tryParse(a.totalPrice?.toString() ?? '0') ?? 0;
    }
    return result;
  }


}

final checkoutViewModel = ChangeNotifierProvider<CheckoutVm>((ref){
  return CheckoutVm();
});