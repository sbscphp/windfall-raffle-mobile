import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiRoutes {
  //auth
  static var sendOtpVerifyEmail =
  "${dotenv.env['AUTH']}/send-otp-email";
  static var sendOtpVerifyPhone =
      "${dotenv.env['AUTH']}/send-otp-phone";
  static var sendForgotPasswordOtp =
      "${dotenv.env['AUTH']}/forgot-password/send-code";
  static resendForgotPasswordOtp({required String? userId}) =>
      "${dotenv.env['AUTH']}/forgot-password/resend-code/$userId";
  static var verifyOtpPhone =
      "${dotenv.env['AUTH']}/confirm-otp-phone";
  static var verifyOtpEmail =
      "${dotenv.env['AUTH']}/confirm-otp-email";
  static verifyForgotPasswordOtp({required String? userId}) =>
      "${dotenv.env['AUTH']}/forgot-password/confirm-code/$userId";
  static var register =
      "${dotenv.env['AUTH']}/signup";
  static createPassword({required String? userId}) =>
      "${dotenv.env['AUTH']}/forgot-password/create-password/$userId";
  static var login =
      "${dotenv.env['AUTH']}/login";

  //profile/settings
  static var fetchProfile =
      "${dotenv.env['SETTINGS']}/profile/check_profile";
  static var updateProfile =
      "${dotenv.env['SETTINGS']}/profile/update_profile";
  static var updatePassword =
      "${dotenv.env['SETTINGS']}/security/update/password";
  static var updateSpendLimit =
      "${dotenv.env['SETTINGS']}/spend_limit/update";
  static var updateSelfExclusion =
      "${dotenv.env['SETTINGS']}/self_exclusion/update";

  //Game
  static fetchGames({required int? pageNumber}) =>
      "${dotenv.env['GUEST']}/all-featured-games?page=$pageNumber";
  static fetchSingleGame({required String? gameId}) =>
      "${dotenv.env['GUEST']}/game/$gameId";
  static getTicketsByOrderId({required String? orderId}) =>
      "${dotenv.env['GAMES']}/order/$orderId/tickets";
  static fetchMyGames({required int? pageNumber}) =>
      "${dotenv.env['GAMES']}/by_orders?page=$pageNumber";
  static fetchGameTicketStatus({required String? id, required int? pageNumber}) =>
      "${dotenv.env['GAMES']}/order/$id/ticket_status?page=$pageNumber";

  //payment
  static var fetchPaymentBreakdown =
      "${dotenv.env['GAMES']}/checkout/summary";
  static var initiateCheckout =
      "${dotenv.env['GAMES']}/checkout";




  //referral
  static fetchReferralHistory({required int? pageNumber}) =>
      "${dotenv.env['REFERRAL']}/users?page=$pageNumber";

  //notification
  static var updateNotificationSettings =
      "${dotenv.env['NOTIFICATION']}/update";
  static fetchNotifications({required int? pageNumber}) =>
      "${dotenv.env['CUSTOMER']}/notifications?page=$pageNumber";
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
      "${dotenv.env['GUEST']}/lagos-lgas";
  static var fetchHearAboutUs =
      "${dotenv.env['GUEST']}/hear_about_us";
  static var fetchConfig =
      "${dotenv.env['GUEST']}/get-all-configurations";
  static var fetchPaymentMethods =
      "${dotenv.env['GUEST']}/payment-methods";

}
