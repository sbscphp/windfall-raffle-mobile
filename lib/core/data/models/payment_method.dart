class PaymentMethod {
  final String? logo;
  final String? paymentChannels;
  final String? slug;
  final String? name;

  PaymentMethod({
    this.logo,
    this.paymentChannels,
    this.slug,
    this.name
  });

  factory PaymentMethod.fromJson(Map<String, dynamic> json) => PaymentMethod(
    logo: json["logo"],
    paymentChannels: json["payment_channels"],
    slug: json["slug"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "logo": logo,
    "payment_channels": paymentChannels,
    "slug": slug,
    "name": name,
  };
}