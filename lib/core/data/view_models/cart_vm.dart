import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:windfall/core/constants/secure_storage_constants.dart';
import 'package:windfall/core/data/models/cart_product.dart';
import 'package:windfall/core/data/models/cart_summary.dart';
import 'package:windfall/core/utilities/secure_storage/secure_storage_utils.dart';
import '../../../../locator.dart';
import '../../constants/app_constants.dart';
import '../../utilities/utilities.dart';
import '../data_provider/cart_data_provider.dart';
import '../enum/view_state.dart';
import '../states/base_state.dart';



class CartVm extends BaseState{

  //game data provider
  final CartDataProvider _cartDp = locator<CartDataProvider>();

  //message
  String _message = '';
  String get message => _message;

  //cart items
  List<CartProduct> _cartItems = [];
  List<CartProduct> get cartItems => _cartItems;

  //cart summary
  CartSummary? _cartSummary;

  int get cartCount => _cartSummary?.totalQuantity ?? 0;
  bool get showCartBadge => cartCount > 0;
  double get totalNumberOfTickets => double.tryParse(_cartSummary?.totalQuantity?.toString() ?? '0') ?? 0;
  double get totalCheckoutAmount => double.tryParse(_cartSummary?.totalDiscountedAmount?.toString() ?? '0') ?? 0;



  //fetch cart
  fetchCart() async {
    setState(ViewState.busy);
    await _cartDp
        .fetchCart()
        .then((response) {
      _message = response.message ?? defaultSuccessMessage;
      _cartItems = response.data?.cart?.items ?? [];
      _cartSummary = response.data?.cart?.summary;
      setState(ViewState.retrieved);
    }, onError: (e) {
      _message = Utilities.formatMessage(e.toString(), isSuccess: false);
      setState(ViewState.error);
    });
  }

  //delete item from cart
  deleteItem({required String? gameId}) async {
    setSecondState(ViewState.busy);
    await _cartDp
        .deleteItem(gameId: gameId)
        .then((response) {
      _message = response.message ?? defaultSuccessMessage;
      _cartItems = response.data?.cart?.items ?? [];
      _cartSummary = response.data?.cart?.summary;
      setSecondState(ViewState.retrieved);
    }, onError: (e) {
      _message = Utilities.formatMessage(e.toString(), isSuccess: false);
      setSecondState(ViewState.error);
    });
  }

  //add/update cart
  addToCart({required String? gameId, required int? quantity, bool isUpdatingCart = false}) async {
    setSecondState(ViewState.busy);
    final details = {
      "quantity": quantity
    };
    await _cartDp
        .addToCart(gameId: gameId, details: details)
        .then((response) {
      _message = isUpdatingCart ? 'Cart updated successfully':response.message ?? defaultSuccessMessage;
      _cartItems = response.data?.cart?.items ?? [];
      _cartSummary = response.data?.cart?.summary;
      setSecondState(ViewState.retrieved);
    }, onError: (e) {
      _message = Utilities.formatMessage(e.toString(), isSuccess: false);
      setSecondState(ViewState.error);
    });
  }

  //transfer cart
  transferCart() async {
    //check if user has a guest token
    final hasGuestToken = await _hasGuestToken();
    if(!hasGuestToken){
      fetchCart();
      return;
    }

    setThirdState(ViewState.busy);
    await _cartDp
        .transferCart()
        .then((response) async{
      _message = response.message ?? defaultSuccessMessage;
      _cartItems = response.data?.cart?.items ?? [];
      _cartSummary = response.data?.cart?.summary;
      await SecureStorageUtils.deleteKey(key: SecuredStorageConstants.guestToken);
      print('cart transfereed and guest token deleted successfully>>>>');
      setThirdState(ViewState.retrieved);
    }, onError: (e) {
      _message = Utilities.formatMessage(e.toString(), isSuccess: false);
      setThirdState(ViewState.error);
    });
  }


  generateGuestToken()async{

    final hasGuestToken = await _hasGuestToken();

    if(hasGuestToken){
      fetchCart();
      return; //user already has a guest token... don't generate
    }


    try{
      final id = Uuid().v4();
      print('guest token generated>>>>>>$id');
      //save guest token to secure storage
      await SecureStorageUtils.saveGuestToken(value: id);
      //fetch cart
      fetchCart();
    }catch(e){
      print('error occurred while generating guest id:::$e>>>');
    }

  }

  Future<bool> _hasGuestToken()async{
    final guestToken = await SecureStorageUtils.retrieveGuestToken();
    if(guestToken == null)return false;
    return true;
  }




}

final cartViewModel = ChangeNotifierProvider<CartVm>((ref){
  return CartVm();
});