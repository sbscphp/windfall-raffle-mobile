import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:windfall/core/constants/app_constants.dart';

class ApiRoutes {
  //auth
  static var sendOtpVerifyEmail =
  "${dotenv.env['AUTH']}/send-otp-email";
  static var sendOtpVerifyPhone =
      "${dotenv.env['AUTH']}/send-otp-phone";
  static var sendForgotPasswordOtp =
      "${dotenv.env['AUTH']}/forgot-password/send-code";
  static var sendResetPasswordOtp =
      "${dotenv.env['AUTH']}/reset-password/send-code";
  static resendForgotPasswordOtp({required String? userId}) =>
      "${dotenv.env['AUTH']}/forgot-password/resend-code/$userId";
  static var resendResetPasswordOtp =
      "${dotenv.env['AUTH']}/reset-password/resend-code";
  static var verifyOtpPhone =
      "${dotenv.env['AUTH']}/confirm-otp-phone";
  static var verifyOtpEmail =
      "${dotenv.env['AUTH']}/confirm-otp-email";
  static verifyForgotPasswordOtp({required String? userId}) =>
      "${dotenv.env['AUTH']}/forgot-password/confirm-code/$userId";
  static var verifyResetPasswordOtp =
      "${dotenv.env['AUTH']}/reset-password/confirm-code";
  static var register =
      "${dotenv.env['AUTH']}/signup_only";
  static createPassword({required String? userId}) =>
      "${dotenv.env['AUTH']}/forgot-password/create-password/$userId";
  static var login =
      "${dotenv.env['AUTH']}/login";
  static var logout =
      "${dotenv.env['AUTH']}/logout";

  //profile/settings
  static var fetchProfile =
      "${dotenv.env['SETTINGS']}/profile/check_profile";
  static var updateProfile =
      "${dotenv.env['SETTINGS']}/profile/update_profile";
  static var updatePassword =
      "${dotenv.env['AUTH']}/reset-password/create-password";
  static var updateSpendLimit =
      "${dotenv.env['SETTINGS']}/spend_limit/update";
  static var updateSelfExclusion =
      "${dotenv.env['SETTINGS']}/self_exclusion/update";

  //Game
  static fetchGames({required int? pageNumber, String? filterParams, bool enablePagination = true}) =>
      filterParams == null ?
      "${dotenv.env['GUEST']}/games/all-games?paginate=${enablePagination ? '1':'0'}&limit=$paginationLimit&page=$pageNumber"
  :"${dotenv.env['GUEST']}/games/all-games?paginate=${enablePagination ? '1':'0'}&limit=$paginationLimit&page=$pageNumber&$filterParams";
  static fetchSingleGame({required String? gameId}) =>
      "${dotenv.env['GUEST']}/games/$gameId";
  static fetchRelatedGames({required String? gameId}) =>
      "${dotenv.env['GUEST']}/games/related/$gameId";
  // static getTicketsByOrderId({required String? orderId}) =>
  //     "${dotenv.env['GAMES']}/order/$orderId/tickets";
  static fetchMyGames({required int? pageNumber, String? filterParams}) =>
  filterParams == null ?
      "${dotenv.env['GAMES']}/order-games?paginate=1&limit=$paginationLimit&page=$pageNumber"
  :"${dotenv.env['GAMES']}/order-games?paginate=1&limit=$paginationLimit&page=$pageNumber&$filterParams";
  static fetchGameTickets({required String? id, required int? pageNumber}) =>
      "${dotenv.env['GAMES']}/order/details/$id/tickets?page=$pageNumber";
  static fetchMyGameResults({required int? pageNumber}) =>
      "${dotenv.env['GAMES']}/game-details-results?paginate=1&limit=$paginationLimit&page=$pageNumber";

  //payment
  static var fetchPaymentBreakdown =
      "${dotenv.env['GAMES']}/checkout/summary";
  static var initiateCheckout =
      "${dotenv.env['GAMES']}/checkout";
  static fetchOrderDetails({required String? orderId}) =>
      "${dotenv.env['GAMES']}/order/$orderId/games";




  //referral
  static fetchReferralHistory({required int? pageNumber, required String? filterOption}) =>
      "${dotenv.env['REFERRAL']}/transactions?paginate=1&limit=$paginationLimit&filter_by=$filterOption";

  //notification
  static var updateNotificationSettings =
      "${dotenv.env['NOTIFICATION']}/update";
  static fetchNotifications({required int? pageNumber}) =>
      "${dotenv.env['CUSTOMER']}/notifications?page=$pageNumber&limit=$paginationLimit&paginate=1";
  static markNotificationAsRead({required String? id}) =>
      "${dotenv.env['CUSTOMER']}/notifications/$id/read";

  //prize gallery
  static var fetchPrizeCategories =
      "${dotenv.env['GUEST']}/cms/prize-gallery/category";
  static fetchCategoryPrizes({required String? id}) =>
      "${dotenv.env['GUEST']}/cms/prize-gallery/prize-by-category-id/$id";
  static var fetchPredefinedPrizes =
      "${dotenv.env['GUEST']}/predefined-suggestions";
  static var suggestPrize =
      "${dotenv.env['GUEST']}/suggest-prize";



  //utility
  static var fetchLgaDetails =
      "${dotenv.env['GUEST']}/dropdown/lagos-lgas";
  static var fetchHearAboutUs =
      "${dotenv.env['GUEST']}/hear_about_us";
  static var fetchConfig =
      "${dotenv.env['GUEST']}/dropdown/get-all-configurations";
  static var fetchPaymentMethods =
      "${dotenv.env['GUEST']}/dropdown/payment-methods";


  //cart
  static var fetchCart =
      "${dotenv.env['GUEST']}/cart";
  static deleteItem({required String? gameId}) =>
      "${dotenv.env['GUEST']}/cart/remove/$gameId";
  static addToCart({required String? gameId}) =>
      "${dotenv.env['GUEST']}/cart/add/$gameId";

  //order history
  static fetchOrderHistory({required int? pageNumber, String? filterParams}) =>
      filterParams == null ?
      "${dotenv.env['GAMES']}/orders?paginate=1&limit=$paginationLimit&page=$pageNumber"
          :"${dotenv.env['GAMES']}/orders?paginate=1&limit=$paginationLimit&page=$pageNumber&$filterParams";
  static fetchOrderHistoryDetails({required String? id}) =>
      "${dotenv.env['GAMES']}/order/$id/games?paginate=1&limit=$paginationLimit";


}
