import 'package:windfall/core/data/models/prize.dart';
import 'package:windfall/core/data/models/ticket_tier.dart';

import 'discount.dart';

class Game {
  final String? uuid;
  final String? name;
  final DateTime? drawDate;
  final dynamic minimumEntry;
  final dynamic maxTicketsPerPerson;
  final int? ticketsLeft;
  final String? cardImage;
  final String? mainActiveStatus;
  final String? uniqueId;
  final String? instantGame;
  final String? description;
  final String? longDescription;
  final String? categoryId;
  final dynamic prizeCost;
  final dynamic percentageMarkup;
  final dynamic ticketPrice;
  final int? availableTickets;
  final int? minimumTicketNumberPurchase;
  final int? maximumTicketNumberPurchase;
  final dynamic maximumTicketAmountPurchase;
  final String? discountType;
  final dynamic discountPercentage;
  final String? isScheduled;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? startTime;
  final String? endTime;
  final String? ctaText;
  final String? supportingText;
  final String? competitionDetails;
  final String? sponsorshipDetails;
  final dynamic otherInformation;
  final String? documents;
  final String? galleryImages;
  final String? status;
  final String? approvalStatus;
  final String? allowPromoCodeUsage;
  final String? allowReferralBalanceUsage;
  final dynamic minimumReferralBalanceAmount;
  final dynamic maximumReferralBalanceAmount;
  final String? isActive;
  final String? isDefault;
  final String? isFeatured;
  final List<TicketTier>? ticketTiers;
  final TicketTier? requantityPricing;
  final List<Prize>? prizes;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Discount? discount;

  Game({
    this.uuid,
    this.name,
    this.drawDate,
    this.minimumEntry,
    this.maxTicketsPerPerson,
    this.ticketsLeft,
    this.cardImage,
    this.mainActiveStatus,
    this.uniqueId,
    this.instantGame,
    this.description,
    this.longDescription,
    this.categoryId,
    this.prizeCost,
    this.percentageMarkup,
    this.ticketPrice,
    this.availableTickets,
    this.minimumTicketNumberPurchase,
    this.maximumTicketNumberPurchase,
    this.maximumTicketAmountPurchase,
    this.discountType,
    this.discountPercentage,
    this.isScheduled,
    this.startDate,
    this.endDate,
    this.startTime,
    this.endTime,
    this.ctaText,
    this.supportingText,
    this.competitionDetails,
    this.sponsorshipDetails,
    this.otherInformation,
    this.documents,
    this.galleryImages,
    this.status,
    this.approvalStatus,
    this.allowPromoCodeUsage,
    this.allowReferralBalanceUsage,
    this.minimumReferralBalanceAmount,
    this.maximumReferralBalanceAmount,
    this.isActive,
    this.isDefault,
    this.isFeatured,
    this.ticketTiers,
    this.requantityPricing,
    this.prizes,
    this.createdAt,
    this.updatedAt,
    this.discount,
  });

  factory Game.fromJson(Map<String, dynamic> json) => Game(
    uuid: json["uuid"],
    name: json["name"],
    drawDate: json["draw_date"] == null ? null : DateTime.parse(json["draw_date"]),
    minimumEntry: json["minimum_entry"],
    maxTicketsPerPerson: json["max_tickets_per_person"],
    ticketsLeft: json["tickets_left"],
    cardImage: json["card_image"],
    mainActiveStatus: json["main_active_status"],
    uniqueId: json["uniqueID"],
    instantGame: json["instant_game"],
    description: json["description"],
    longDescription: json["long_description"],
    categoryId: json["category_id"],
    prizeCost: json["prize_cost"],
    percentageMarkup: json["percentage_markup"],
    ticketPrice: json["ticket_price"],
    availableTickets: json["available_tickets"],
    minimumTicketNumberPurchase: json["minimum_ticket_number_purchase"],
    maximumTicketNumberPurchase: json["maximum_ticket_number_purchase"],
    maximumTicketAmountPurchase: json["maximum_ticket_amount_purchase"],
    discountType: json["discount_type"],
    discountPercentage: json["discount_percentage"],
    isScheduled: json["is_scheduled"],
    startDate: json["start_date"] == null ? null : DateTime.parse(json["start_date"]),
    endDate: json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
    startTime: json["start_time"],
    endTime: json["end_time"],
    ctaText: json["cta_text"],
    supportingText: json["supporting_text"],
    competitionDetails: json["competition_details"],
    sponsorshipDetails: json["sponsorship_details"],
    otherInformation: json["other_information"],
    documents: json["documents"],
    galleryImages: json["gallery_images"],
    status: json["status"],
    approvalStatus: json["approvalStatus"],
    allowPromoCodeUsage: json["allow_promo_code_usage"],
    allowReferralBalanceUsage: json["allow_referral_balance_usage"],
    minimumReferralBalanceAmount: json["minimum_referral_balance_amount"],
    maximumReferralBalanceAmount: json["maximum_referral_balance_amount"],
    isActive: json["is_active"],
    isDefault: json["is_default"],
    isFeatured: json["is_featured"],
    ticketTiers: json["ticket_tiers"] == null ? [] : List<TicketTier>.from(json["ticket_tiers"]!.map((x) => TicketTier.fromJson(x))),
    requantityPricing: json["requantity_pricing"] == null ? null : TicketTier.fromJson(json["requantity_pricing"]),
    prizes: json["prizes"] == null ? [] : List<Prize>.from(json["prizes"]!.map((x) => Prize.fromJson(x))),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    discount: json["discount"] == null ? null : Discount.fromJson(json["discount"]),
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid,
    "name": name,
    "draw_date": "${drawDate!.year.toString().padLeft(4, '0')}-${drawDate!.month.toString().padLeft(2, '0')}-${drawDate!.day.toString().padLeft(2, '0')}",
    "minimum_entry": minimumEntry,
    "max_tickets_per_person": maxTicketsPerPerson,
    "tickets_left": ticketsLeft,
    "card_image": cardImage,
    "main_active_status": mainActiveStatus,
    "uniqueID": uniqueId,
    "instant_game": instantGame,
    "description": description,
    "long_description": longDescription,
    "category_id": categoryId,
    "prize_cost": prizeCost,
    "percentage_markup": percentageMarkup,
    "ticket_price": ticketPrice,
    "available_tickets": availableTickets,
    "minimum_ticket_number_purchase": minimumTicketNumberPurchase,
    "maximum_ticket_number_purchase": maximumTicketNumberPurchase,
    "maximum_ticket_amount_purchase": maximumTicketAmountPurchase,
    "discount_type": discountType,
    "discount_percentage": discountPercentage,
    "is_scheduled": isScheduled,
    "start_date": "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
    "end_date": "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
    "start_time": startTime,
    "end_time": endTime,
    "cta_text": ctaText,
    "supporting_text": supportingText,
    "competition_details": competitionDetails,
    "sponsorship_details": sponsorshipDetails,
    "other_information": otherInformation,
    "documents": documents,
    "gallery_images": galleryImages,
    "status": status,
    "approvalStatus": approvalStatus,
    "allow_promo_code_usage": allowPromoCodeUsage,
    "allow_referral_balance_usage": allowReferralBalanceUsage,
    "minimum_referral_balance_amount": minimumReferralBalanceAmount,
    "maximum_referral_balance_amount": maximumReferralBalanceAmount,
    "is_active": isActive,
    "is_default": isDefault,
    "is_featured": isFeatured,
    "ticket_tiers": ticketTiers == null ? [] : List<dynamic>.from(ticketTiers!.map((x) => x.toJson())),
    "requantity_pricing": requantityPricing,
    "prizes": prizes == null ? [] : List<dynamic>.from(prizes!.map((x) => x.toJson())),
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "discount": discount?.toJson(),
  };
}