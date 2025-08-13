import 'package:another_xlider/another_xlider.dart';
import 'package:another_xlider/models/handler.dart';
import 'package:another_xlider/models/tooltip/tooltip.dart';
import 'package:another_xlider/models/trackbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/app_asset.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';
import 'package:windfall/ui/widgets/custom_svg.dart';
import 'package:windfall/ui/widgets/dotted_container.dart';
import 'package:windfall/ui/widgets/home/game_details_section.dart';
import 'package:windfall/ui/widgets/home/related_games_section.dart';
import 'package:windfall/ui/widgets/windfall_container.dart';
import '../../../core/constants/app_dimension.dart';
import '../../../core/constants/color_path.dart';
import '../../../core/utilities/utilities.dart';
import '../../widgets/cart/cart_icon.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_dot.dart';
import '../../widgets/custom_painter/dotted_border.dart';
import '../../widgets/home/game_property.dart';
import '../../widgets/media_placeholder.dart';
import '../../widgets/naira_display.dart';
import '../../widgets/quantity_counter.dart';

class GameDetails extends StatefulWidget {
  const GameDetails({super.key});

  @override
  State<GameDetails> createState() => _GameDetailsState();
}

class _GameDetailsState extends State<GameDetails> {

  late double quantity;

  @override
  void initState() {
    quantity = 1;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
          context: context,
          title: 'View Raffle',
          actions: [
            Padding(
              padding: EdgeInsets.only(right: AppDimension.paddingRight),
              child: CartIcon(),
            )
          ]
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 20.h),
              child: 1 + 1 == 3 ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  imageAndName(context),
                  SizedBox(height: 8.h,),
                  gameStatus(context),
                  SizedBox(height: 32.h,),
                  winnerDetails(context)
                ],
              ):Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  imageAndName(context),
                  SizedBox(height: 8.h,),
                  gameStatus(context),
                  SizedBox(height: 32.h,),
                  priceDetails(context),
                  SizedBox(height: 32.h,),
                  GameDetailsSection(
                    margin: EdgeInsets.symmetric(horizontal: AppDimension.paddingRight,
                    ),
                    title: 'Competition Details',
                    value: 'This raffle is proudly sponsored by [Insert Sponsor Name(s)], who have made it possible for one lucky participant to win a luxury studio apartment in Lekki, Lagos.a a  a a a a a  a a a a  a a a a a a  a a a a a a a a a a  a a a a a a  a a',
                  ),
                  SizedBox(height: 24.h,),
                  GameDetailsSection(
                    margin: EdgeInsets.symmetric(horizontal: AppDimension.paddingRight,
                    ),
                    title: 'Sponsorship Details',
                    value: 'This raffle is proudly sponsored by [Insert Sponsor Name(s)], who have made it possible for one lucky participant to win a luxury studio apartment in Lekki, Lagos.a a  a a a a a  a a a a  a a a a a a  a a a a a a a a a a  a a a a a a  a a',
                  ),
                  SizedBox(height: 24.h,),
                  RelatedGamesSection()
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.whiteText,
              boxShadow: [
                BoxShadow(
                    color: ColorPath.regentGrey.withAlpha((255 * 0.14).toInt()),
                    spreadRadius: 0,
                    blurRadius: 250,
                    offset: const Offset(
                        0, -100)
                ),
              ],
            ),
            child: SafeArea(
              child: 1 + 1 == 2 ? CustomButton(
                  useDottedBorder: true,
                  disableBgColor: ColorPath.californiaOrange,
                  buttonText:'Upcoming Game ~ Coming Soon ',
                  onPressed: null
              ):Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomButton(
                      useDottedBorder: true,
                      buttonText:'Add to Cart',
                      showButtonIcon: true,
                      buttonIcon: AppAsset.cart2,
                      onPressed: (){

                      }
                  ),
                  SizedBox(height: 24.h,),
                  CustomButton(
                      bgColor: Theme.of(context).colorScheme.textPrimary,
                      useDottedBorder: true,
                      buttonText:'Buy Now',
                      showButtonIcon: true,
                      buttonIcon: AppAsset.cart2,
                      onPressed: (){

                      }
                  ),

                ],
              ),
            ),
          ),

        ],
      ),
    );
  }

  Widget imageAndName(BuildContext context){
    return Padding(
      padding: EdgeInsets.only(
          top: AppDimension.paddingTop,
          left: AppDimension.paddingLeft,
          right: AppDimension.paddingRight
      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 168.h,
              child: Align(
                alignment: Alignment.center,
                child: Swiper(
                  //autoplay: true,
                  //autoplayDisableOnInteraction: true,
                  itemCount:3,
                  duration: 400,
                  //autoplayDelay: 3000, // Delay in milliseconds
                  curve: Curves.easeInOut,
                  itemHeight: double.infinity,
                  itemWidth: double.infinity,
                  onIndexChanged: (index){
                  },
                  scale: 0.7,
                  itemBuilder: (BuildContext context, int index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(16.r)),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        width: double.infinity,
                        imageUrl: 'https://mir-s3-cdn-cf.behance.net/user/276/888fd91082619909.61d2827bbd7a2.jpg',
                        placeholder: (context, url) => const MediaPlaceholder(),
                        errorWidget: (context, url, error) => const MediaPlaceholder(),
                      ),
                    );

                  },
                ),
              ),
            ),
            SizedBox(height: 16.h,),
            Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: List.generate(
                    3,
                        (index) => CustomDot(
                      height: 14,
                      width: 14,
                      activeColor: ColorPath.redOrange,
                      inactiveColor: ColorPath.cosmosPink,
                      useRoundCircles: true,
                      isActive: index == 2,
                    )),
              ),
            ),
            SizedBox(height: 24.h,),
            Text(
              "Secure a Luxury Studio Apartment in Lekki, Lagos State, Nigeria. ",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: Theme.of(context).colorScheme.textPrimary,
              ),
            ),
            SizedBox(height: 4.h,),
            Text(
              "Enter now to grab the opportunity of a brand new Samsung",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w400,
                color: Theme.of(context).colorScheme.textSecondary,
              ),
            ),
          ]
      ),
    );
  }

  Widget gameStatus(BuildContext context){
    if(1 + 1 == 3){
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: AppDimension.paddingLeft),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
              decoration: BoxDecoration(
                  color: Utilities.statusContainerColor(status: 'live'),
                  borderRadius: BorderRadius.all(Radius.circular(16.r))
              ),
              child: Text(
                Utilities.statusText(status: 'Live Game'),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: Utilities.statusTextColor(status: 'live')
                ),
              ),
            ),
            SizedBox(width: 8.w,),
            Container(
              padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
              decoration: BoxDecoration(
                  color: ColorPath.solitudeBlue,
                  borderRadius: BorderRadius.all(Radius.circular(16.r))
              ),
              child: Text(
                'Draw Date: April 11',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: ColorPath.bayBlue
                ),
              ),
            ),

          ],
        ),
      );
    }
    if(1 + 1 == 2){
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: AppDimension.paddingLeft),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
              decoration: BoxDecoration(
                  color: ColorPath.scandalGreen,
                  borderRadius: BorderRadius.all(Radius.circular(16.r))
              ),
              child: Text(
                'Winner Announced',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: ColorPath.hazeGreen
                ),
              ),
            ),
            SizedBox(width: 8.w,),
            Container(
              padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
              decoration: BoxDecoration(
                  color: ColorPath.pippinPink,
                  borderRadius: BorderRadius.all(Radius.circular(16.r))
              ),
              child: Text(
                'Draw Closed',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: ColorPath.shirazRed
                ),
              ),
            ),

          ],
        ),
      );
    }
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
      margin: EdgeInsets.symmetric(horizontal: AppDimension.paddingLeft),
      decoration: BoxDecoration(
          color: Utilities.statusContainerColor(status: 'upcoming'),
          borderRadius: BorderRadius.all(Radius.circular(16.r))
      ),
      child: Text(
        Utilities.statusText(status: 'upcoming'),
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w500,
            color: Utilities.statusTextColor(status: 'upcoming')
        ),
      ),
    );
  }

  Widget winnerDetails(BuildContext context){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppDimension.paddingLeft),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Draw Winner Announcement 🚀",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.textPrimary,
            ),
          ),
          SizedBox(height: 16.h,),
          WindfallContainer(
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 150.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(4.r))
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(4.r)),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        width: double.infinity,
                        imageUrl: 'https://mir-s3-cdn-cf.behance.net/user/276/888fd91082619909.61d2827bbd7a2.jpg',
                        placeholder: (context, url) => const MediaPlaceholder(),
                        errorWidget: (context, url, error) => const MediaPlaceholder(),
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h,),
                  GameProperty(
                      imageAsset: AppAsset.drawDate,
                      label: 'Draw Date:',
                      value: Expanded(
                        child: Text(
                          "April 11, 2025",
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).colorScheme.textSecondary,
                          ),
                        ),
                      )
                  ),
                  SizedBox(height: 8.h,),
                  GameProperty(
                      imageAsset: AppAsset.ticketsLeft,
                      label: 'Total Tickets:',
                      value: Expanded(
                        child: Text(
                          "1,000 Tickets",
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).colorScheme.textSecondary,
                          ),
                        ),
                      )
                  ),
                  SizedBox(height: 8.h,),
                  GameProperty(
                      imageAsset: AppAsset.maxPerson,
                      label: 'No of Winners:',
                      value: Expanded(
                        child: Text(
                          "200",
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).colorScheme.textSecondary,
                          ),
                        ),
                      )
                  ),



                ],
              )
          ),
          SizedBox(height: 24.h,),
          DottedContainer(
              borderRadius:8,
              padding: EdgeInsets.symmetric(
                  vertical: 16.h,
                  horizontal: 24.w
              ),
              decoration: BoxDecoration(
                  color: ColorPath.fairPink,
                  borderRadius: BorderRadius.all(Radius.circular(8.r))
              ),
              child: Center(
                child: FittedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Winner Announced",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).colorScheme.textTertiary,
                        ),
                      ),
                      SizedBox(height: 5.h,),
                      Text(
                        "Dariye Damilola Fiyin",
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: ColorPath.redOrange,
                        ),
                      ),
                    ],
                  ),
                ),
              )
          )

        ],
      ),
    );
  }
  
  Widget priceDetails(BuildContext context){
    return Padding(
      padding: EdgeInsets.only(
        left: AppDimension.paddingLeft,
        right: AppDimension.paddingRight
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              1 + 1 == 3 ? QuantityCounter(
                  value: quantity.toInt(),
                  upperLimit: 33,
                  onChanged: (value){
                    setState(() {
                      quantity = value.toDouble() ?? 1;
                    });
                  }
              ):Container(
    padding: EdgeInsets.symmetric(
    vertical: 8.h,
      horizontal: 16.w
    ),
    decoration: BoxDecoration(
    color: ColorPath.chablisPink,
    border: Border(bottom: BorderSide(
    color: ColorPath.redOrange,
    width: 2.w,
    )),

    ),
    child:  Center(
    child: Text(
    'Coming Soon',
    style: Theme.of(context).textTheme.titleMedium?.copyWith(
    fontWeight: FontWeight.w800,
    color: ColorPath.redOrange,
    ),
    ),
    ),
    ),
              SizedBox(width: 10.w,),
              Flexible(
                child: Column(
                  children: [
                    Text(
                      "Unit Ticket Price",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).colorScheme.textSecondary,
                      ),
                    ),
                    SizedBox(height: 5.h,),
                    FittedBox(
                      child: NairaDisplay(
                        amount: 45000,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        addDecimal: false,
                        color: Theme.of(context).colorScheme.textPrimary,
                      ),
                    ),
                    SizedBox(height: 3.h,),
                    FittedBox(
                      child: NairaDisplay(
                        amount: 3000,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        addDecimal: false,
                        color: ColorPath.redOrange,
                        isSlashedAmount: true,
                      ),
                    ),
                  ],
                ),
              )

            ],
          ),
          SizedBox(height: 32.h,),
          Align(
            alignment: Alignment.center,
            child: Text(
              "Get Best Deal today!!!",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
                color: ColorPath.redOrange,
              ),
            ),
          ),
          SizedBox(height: 20.h,),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 5.h),
              child: FlutterSlider(
                values: [quantity.toDouble()],
                min: 1,
                max: 33,
                handler: FlutterSliderHandler(
                  decoration: BoxDecoration(), // removes default glow
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: ColorPath.redOrange,
                        width: 2,
                      ),
                    ),
                  ),
                ),
                trackBar: FlutterSliderTrackBar(
                  activeTrackBarHeight: 8,
                  inactiveTrackBarHeight: 8,
                  activeTrackBar: BoxDecoration(
                    color: ColorPath.redOrange,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  inactiveTrackBar: BoxDecoration(
                    color: ColorPath.athensGrey7,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                ),
                tooltip: FlutterSliderTooltip(
                  alwaysShowTooltip: true,
                  custom: (value) {
                    return Transform.translate(
                      offset: Offset(0, -15.h),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: 6.h,
                                  horizontal: 8.w,
                                ),
                                decoration: BoxDecoration(
                                  color: ColorPath.redOrange,
                                  borderRadius: BorderRadius.all(Radius.circular(4.r)),
                                ),
                                child: Center(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        quantity.toInt().toString(),
                                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(width: 4.w),
                                      CustomSvg(
                                        asset: AppAsset.ticketSlider,
                                        height: 12.h,
                                        width: 12.w,
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              Positioned(
                                bottom: -4.h,
                                left: 0,
                                right: 0,
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    height: 7.h,
                                    width: 7.h,
                                    decoration: BoxDecoration(
                                      color: ColorPath.redOrange,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: 26.h,
                            width: 2.w,
                            color: ColorPath.redOrange,
                          ),
                        ],
                      ),
                    );
                  },
                ),
                onDragging: (handlerIndex, lowerValue, upperValue) {
                  setState(() {
                    quantity = lowerValue;
                  });
                },
              ),
            ),
          ),
          // SizedBox(width: 12.w,),
          // Column(
          //   children: [
          //     Text(
          //       "Discount",
          //       style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          //         fontWeight: FontWeight.w400,
          //         color: Theme.of(context).colorScheme.textSecondary,
          //       ),
          //     ),
          //     SizedBox(height: 10.h,),
          //     Container(
          //       width: 74.w,
          //       padding: EdgeInsets.symmetric(vertical: 8.h),
          //       decoration: BoxDecoration(
          //         color: Theme.of(context).colorScheme.blackText,
          //         borderRadius: BorderRadius.all(Radius.circular(4.r))
          //       ),
          //       child:  Center(
          //         child: Text(
          //           1 + 1 == 3 ? "No Discount":"7% Off",
          //           style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          //             fontSize: 12.sp,
          //             fontWeight: FontWeight.w600,
          //             color: Theme.of(context).colorScheme.whiteText,
          //           ),
          //         ),
          //       ),
          //     )
          //   ],
          // ),
        ],
      ),
          SizedBox(height: 5.h,),
          Row(
            spacing: 12.w,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(4, (index){
              final isActive = index == 2;
              return Expanded(
                child: CustomPaint(
                  painter: DottedBorder(
                      color: isActive ? ColorPath.redOrange:ColorPath.altoGrey,
                      borderRadius: BorderRadius.all(Radius.circular(8.r))
                  ),
                  child: Container(
                    height: 54.h,
                    padding: EdgeInsets.symmetric(
                      vertical: 8.h,
                      horizontal: 8.w
                    ),
                    decoration: BoxDecoration(
                        color: isActive ? ColorPath.fairPink:ColorPath.wildGrey,
                        borderRadius: BorderRadius.all(Radius.circular(8.r))
                    ),
                    child: Center(
                      child: FittedBox(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "5 Units +",
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: Theme.of(context).colorScheme.textTertiary,
                              ),
                            ),
                            SizedBox(height: 5.h,),
                            Text(
                              "20% Off",
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: isActive ? ColorPath.redOrange:Theme.of(context).colorScheme.textPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
          SizedBox(height: 16.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  CustomSvg(asset: AppAsset.minEntry2, height: 16.h, width: 16.w,),
                  SizedBox(width: 8.w,),
                  Text(
                    "Min Entry: ₦3K",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).colorScheme.textSecondary,
                    ),
                  )

                ],
              ),
              SizedBox(width: 16.w,),
              Row(
                children: [
                  CustomSvg(asset: AppAsset.avatar2, height: 16.h, width: 16.w,),
                  SizedBox(width: 8.w,),
                  Text(
                    "Max/Person: 200 Tickets",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).colorScheme.textSecondary,
                    ),
                  )

                ],
              )
            ],
          ),
          SizedBox(height: 24.h,),
          DottedContainer(
              borderRadius:8,
              padding: EdgeInsets.symmetric(
                  vertical: 16.h,
                  horizontal: 24.w
              ),
              decoration: BoxDecoration(
                color: ColorPath.fairPink,
                borderRadius: BorderRadius.all(Radius.circular(8.r))
              ),
              child: Center(
                child: FittedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        1 + 1 == 3 ? "Total price ":"Discounted price",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).colorScheme.textTertiary,
                        ),
                      ),
                      SizedBox(height: 5.h,),
                      1 + 1 == 3 ? FittedBox(
                        child: NairaDisplay(
                          amount: 45000,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w700,
                          addDecimal: false,
                          color: ColorPath.redOrange,
                        ),
                      ):Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FittedBox(
                            child: NairaDisplay(
                              amount: 54000,
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w400,
                              addDecimal: false,
                              color: ColorPath.lisaPink,
                              isSlashedAmount: true,
                            ),
                          ),
                          SizedBox(width: 10.w,),
                          FittedBox(
                            child: NairaDisplay(
                              amount: 45000,
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w700,
                              addDecimal: false,
                              color: ColorPath.redOrange,
                            ),
                          ),

                        ],
                      ),
                    ],
                  ),
                ),
              )
          )


        ]
      ),
    );
  }


}
