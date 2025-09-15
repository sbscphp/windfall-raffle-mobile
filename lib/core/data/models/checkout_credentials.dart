class CheckoutCredentials {
  final String? authorizationUrl;
  final String? accessCode;
  final String? reference;
  final String? successRedirect;
  final String? failureRedirect;
  final String? orderId;
  final String? callback;

  CheckoutCredentials({
    this.authorizationUrl,
    this.accessCode,
    this.reference,
    this.successRedirect,
    this.failureRedirect,
    this.orderId,
    this.callback
  });

  factory CheckoutCredentials.fromJson(Map<String, dynamic> json) => CheckoutCredentials(
    authorizationUrl: json["authorization_url"],
    accessCode: json["access_code"],
    reference: json["reference"],
    successRedirect: json["success_redirect"],
    failureRedirect: json["failure_redirect"],
    orderId: json["order_id"],
    callback: json["callback"],
  );

  Map<String, dynamic> toJson() => {
    "authorization_url": authorizationUrl,
    "access_code": accessCode,
    "reference": reference,
    'success_redirect': successRedirect,
    'failure_redirect':failureRedirect,
    'order_id':orderId,
    'callback': callback
  };
}