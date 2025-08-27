class LgaDetails {
  final String? lga;
  final List<String>? wards;

  LgaDetails({
    this.lga,
    this.wards,
  });

  factory LgaDetails.fromJson(Map<String, dynamic> json) => LgaDetails(
    lga: json["lga"],
    wards: json["wards"] == null ? [] : List<String>.from(json["wards"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "lga": lga,
    "wards": wards == null ? [] : List<dynamic>.from(wards!.map((x) => x)),
  };
}