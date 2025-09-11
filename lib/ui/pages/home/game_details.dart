import 'package:another_xlider/another_xlider.dart';
import 'package:another_xlider/models/handler.dart';
import 'package:another_xlider/models/tooltip/tooltip.dart';
import 'package:another_xlider/models/trackbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/app_asset.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';
import 'package:windfall/core/data/enum/checkout_type.dart';
import 'package:windfall/core/data/view_models/cart_vm.dart';
import 'package:windfall/core/data/view_models/checkout_vm.dart';
import 'package:windfall/core/data/view_models/game_vms/related_games_vm.dart';
import 'package:windfall/core/data/view_models/game_vms/single_game_vm.dart';
import 'package:windfall/core/utilities/extensions/num_extension.dart';
import 'package:windfall/ui/widgets/app_loader.dart';
import 'package:windfall/ui/widgets/busy_overlay.dart';
import 'package:windfall/ui/widgets/custom_divider.dart';
import 'package:windfall/ui/widgets/custom_svg.dart';
import 'package:windfall/ui/widgets/dotted_container.dart';
import 'package:windfall/ui/widgets/error_state.dart';
import 'package:windfall/ui/widgets/home/game_details_section.dart';
import 'package:windfall/ui/widgets/home/related_games_section.dart';
import 'package:windfall/ui/widgets/listview_items/instant_game_item.dart';
import 'package:windfall/ui/widgets/show_flush_bar.dart';
import 'package:windfall/ui/widgets/windfall_container.dart';
import '../../../core/constants/app_dimension.dart';
import '../../../core/constants/color_path.dart';
import '../../../core/constants/named_routes.dart';
import '../../../core/data/enum/view_state.dart';
import '../../../core/utilities/date_utilitites.dart';
import '../../../core/utilities/navigator.dart';
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
import '../../widgets/with_scope.dart';
import '../checkout/checkout.dart';

class GameDetails extends ConsumerStatefulWidget {
  const GameDetails({super.key});

  @override
  ConsumerState<GameDetails> createState() => _GameDetailsState();
}

class _GameDetailsState extends ConsumerState<GameDetails> {
  //late double quantity;
  int _currentIndex = 0;

  @override
  void initState() {
    //quantity = 1;
    final gameId = ref.read(gameIdProvider);
    print('game id returned:::$gameId>>>>>');
    final vm = ref.read(singleGameViewModel(gameId));
    SchedulerBinding.instance.addPostFrameCallback((_) {
      //fetch game details
      vm.fetchSingleGame(gameId: gameId).then((value) async {
        if (vm.state == ViewState.retrieved) {
          final relatedGamesVm = ref.read(relatedGamesViewModel(gameId));
          relatedGamesVm.fetchRelatedGames(gameId: gameId);
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext parentContext) {
    final gameId = ref.watch(gameIdProvider);
    final vm = ref.watch(singleGameViewModel(gameId));
    final cartVm = ref.watch(cartViewModel);
    return BusyOverlay(
      show: cartVm.secondState == ViewState.busy,
      child: Scaffold(
        appBar: customAppBar(
          context: context,
          title: 'View Raffle',
          actions: [
            Padding(
              padding: EdgeInsets.only(right: AppDimension.paddingRight),
              child: CartIcon(),
            ),
          ],
        ),
        body: Builder(
          builder: (context) {
            if (vm.state == ViewState.busy) {
              return Center(child: AppLoader());
            }

            if (vm.state == ViewState.retrieved) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.only(bottom: 20.h),
                      child: vm.isEnded
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                imageAndName(context, vm),
                                SizedBox(height: 8.h),
                                gameStatus(context, vm),
                                SizedBox(height: 32.h),
                                winnerDetails(context),
                              ],
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                imageAndName(context, vm),
                                SizedBox(height: 8.h),
                                gameStatus(context, vm),
                                SizedBox(height: 32.h),
                                priceDetails(context, vm),
                                if (vm.isInstantGame && vm.instantPrizes.isNotEmpty) instantPrizes(context, vm),
                                SizedBox(height: 32.h),
                                GameDetailsSection(
                                  margin: EdgeInsets.symmetric(
                                    horizontal: AppDimension.paddingRight,
                                  ),
                                  title: 'Competition Details',
                                  value: vm.competitionDetails,
                                ),
                                SizedBox(height: 24.h),
                                GameDetailsSection(
                                  margin: EdgeInsets.symmetric(
                                    horizontal: AppDimension.paddingRight,
                                  ),
                                  title: 'Sponsorship Details',
                                  value: vm.sponsorShipDetails,
                                ),
                                SizedBox(height: 24.h),
                                RelatedGamesSection(),
                              ],
                            ),
                    ),
                  ),
                  if(!vm.isEnded)Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 24.h,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.whiteText,
                      boxShadow: [
                        BoxShadow(
                          color: ColorPath.regentGrey.withAlpha(
                            (255 * 0.14).toInt(),
                          ),
                          spreadRadius: 0,
                          blurRadius: 250,
                          offset: const Offset(0, -100),
                        ),
                      ],
                    ),
                    child: SafeArea(
                      child: vm.isUpComing
                          ? CustomButton(
                              useDottedBorder: true,
                              disableBgColor: ColorPath.californiaOrange,
                              buttonText: 'Upcoming Game ~ Coming Soon ',
                              onPressed: null,
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomButton(
                                  useDottedBorder: true,
                                  buttonText: 'Add to Cart',
                                  showButtonIcon: true,
                                  buttonIcon: AppAsset.cart2,
                                  onPressed: () async{
                                    await cartVm.addToCart(
                                        gameId: gameId,
                                        quantity: vm.quantity.toInt()
                                    );
                                    showFlushBar(
                                        context: context,
                                        message: cartVm.message,
                                        success: cartVm.secondState == ViewState.retrieved
                                    );
                                  },
                                ),
                                SizedBox(height: 24.h),
                                CustomButton(
                                  bgColor: Theme.of(
                                    context,
                                  ).colorScheme.textPrimary,
                                  useDottedBorder: true,
                                  buttonText: 'Buy Now',
                                  showButtonIcon: true,
                                  buttonIcon: AppAsset.cart2,
                                  onPressed: () {

                                    final checkoutVm = ref.read(checkoutViewModel);
                                    //set checkout type
                                    checkoutVm.checkoutType = CheckoutType.buyNow;
                                    //generate checkout item
                                    checkoutVm.initCheckoutItems(input: vm.generateCheckout());

                                    // pushNavigation(
                                    //   context: context,
                                    //   widget: Checkout(),
                                    //   routeName: NamedRoutes.checkout,
                                    // );
                                    pushNavigation(
                                      context: context,
                                      widget: WithScope(
                                        overrides: [
                                          gameIdProvider.overrideWithValue(gameId),
                                        ],
                                        child: const Checkout(),
                                      ),
                                      routeName: NamedRoutes.checkout,
                                    );
                                  },
                                ),
                              ],
                            ),
                    ),
                  ),
                ],
              );
            }

            if (vm.state == ViewState.error) {
              return Center(
                child: ErrorState(
                  message: vm.message,
                  onPressed: () => vm.fetchSingleGame(gameId: gameId).then((value) async {
                    if (vm.state == ViewState.retrieved) {
                      final relatedGamesVm = ref.read(relatedGamesViewModel(gameId));
                      relatedGamesVm.fetchRelatedGames(gameId: gameId);
                    }
                  }),
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget instantPrizes(BuildContext context, SingleGameVm vm) {
    return WindfallContainer(
      margin: EdgeInsets.only(
        top: AppDimension.paddingTop,
        left: AppDimension.paddingLeft,
        right: AppDimension.paddingRight,
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Instant Prizes",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.textPrimary,
            ),
          ),
          CustomDivider(
            equalVerticalSpace: false,
            verticalSpace: 8.h,
            bottomMargin: 16.h,
          ),
          ListView.separated(
            itemCount: vm.instantPrizes.length,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              final prize = vm.instantPrizes[index];
              return InstantGameItem(
                prize: prize,
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(height: 16.h);
            },
          ),
        ],
      ),
    );
  }

  Widget imageAndName(BuildContext context, SingleGameVm vm) {
    return Padding(
      padding: EdgeInsets.only(
        top: AppDimension.paddingTop,
        left: AppDimension.paddingLeft,
        right: AppDimension.paddingRight,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (vm.images.isNotEmpty)
            SizedBox(
              height: 168.h,
              child: Align(
                alignment: Alignment.center,
                child: Swiper(
                  //autoplay: true,
                  //autoplayDisableOnInteraction: true,
                  itemCount: vm.images.length,
                  duration: 400,
                  //autoplayDelay: 3000, // Delay in milliseconds
                  curve: Curves.easeInOut,
                  itemHeight: double.infinity,
                  itemWidth: double.infinity,
                  onIndexChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  scale: 0.7,
                  itemBuilder: (BuildContext context, int index) {
                    final image = vm.images[index];
                    return ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(16.r)),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        width: double.infinity,
                        imageUrl: image,
                        placeholder: (context, url) => const MediaPlaceholder(),
                        errorWidget: (context, url, error) =>
                            const MediaPlaceholder(),
                      ),
                    );
                  },
                ),
              ),
            ),
          if (vm.images.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(top: 16.h),
              child: Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                    vm.images.length,
                    (index) => CustomDot(
                      height: 14,
                      width: 14,
                      activeColor: ColorPath.redOrange,
                      inactiveColor: ColorPath.cosmosPink,
                      useRoundCircles: true,
                      isActive: index == _currentIndex,
                    ),
                  ),
                ),
              ),
            ),
          SizedBox(height: 24.h),
          Text(
            vm.name,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: Theme.of(context).colorScheme.textPrimary,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            vm.description,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w400,
              color: Theme.of(context).colorScheme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget gameStatus(BuildContext context, SingleGameVm vm) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppDimension.paddingLeft),
      child: FittedBox(
        child: Row(
          children: [
            if (vm.isInstantGame)
              Container(
                padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
                decoration: BoxDecoration(
                  color: ColorPath.pattensBlue,
                  borderRadius: BorderRadius.all(Radius.circular(16.r)),
                ),
                child: Row(
                  children: [
                    Text(
                      'Instant Game',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: ColorPath.toryBlue,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    CustomSvg(asset: AppAsset.zap, height: 12.h, width: 12.w),
                  ],
                ),
              ),
            Container(
              margin: EdgeInsets.only(left: !vm.isInstantGame ? 0 : 8.w),
              padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
              decoration: BoxDecoration(
                color: Utilities.statusContainerColor(status: vm.status),
                borderRadius: BorderRadius.all(Radius.circular(16.r)),
              ),
              child: Text(
                Utilities.statusText(status: vm.status),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: Utilities.statusTextColor(status: vm.status),
                ),
              ),
            ),
            if (!vm.isEnded && !vm.isUpComing)
              Container(
                margin: EdgeInsets.only(left: 8.w),
                padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
                decoration: BoxDecoration(
                  color: ColorPath.solitudeBlue,
                  borderRadius: BorderRadius.all(Radius.circular(16.r)),
                ),
                child: Text(
                  'Draw Date: ${DateUtilities.monthDayYear(date: vm.drawDate)}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: ColorPath.bayBlue,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget winnerDetails(BuildContext context) {
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
          SizedBox(height: 16.h),
          WindfallContainer(
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 150.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4.r)),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(4.r)),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      width: double.infinity,
                      imageUrl:
                          'https://mir-s3-cdn-cf.behance.net/user/276/888fd91082619909.61d2827bbd7a2.jpg',
                      placeholder: (context, url) => const MediaPlaceholder(),
                      errorWidget: (context, url, error) =>
                          const MediaPlaceholder(),
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
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
                  ),
                ),
                SizedBox(height: 8.h),
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
                  ),
                ),
                SizedBox(height: 8.h),
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
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),
          DottedContainer(
            borderRadius: 8,
            padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 24.w),
            decoration: BoxDecoration(
              color: ColorPath.fairPink,
              borderRadius: BorderRadius.all(Radius.circular(8.r)),
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
                    SizedBox(height: 5.h),
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
            ),
          ),
        ],
      ),
    );
  }

  Widget priceDetails(BuildContext context, SingleGameVm vm) {
    return Padding(
      padding: EdgeInsets.only(
        left: AppDimension.paddingLeft,
        right: AppDimension.paddingRight,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (vm.isUpComing)
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 8.h,
                    horizontal: 16.w,
                  ),
                  decoration: BoxDecoration(
                    color: ColorPath.chablisPink,
                    border: Border(
                      bottom: BorderSide(
                        color: ColorPath.redOrange,
                        width: 2.w,
                      ),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Coming Soon',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: ColorPath.redOrange,
                      ),
                    ),
                  ),
                )
              else
                QuantityCounter(
                  value: vm.quantity.toInt(),
                  upperLimit: vm.availableTickets,
                  onChanged: (value) {
                    // setState(() {
                    //   vm.quantity = value.toDouble() ?? 1;
                    // });
                    //update quantity count
                    vm.quantity = value.toDouble() ?? 1;
                    //calculate discount price
                    vm.calculatePrice(isUnitPriceCalculation: true);
                  },
                ),
              SizedBox(width: 10.w),
              if(vm.isUpComing)
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
                    SizedBox(height: 5.h),
                    FittedBox(
                      child: NairaDisplay(
                        amount: vm.unitPrice,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        addDecimal: false,
                        color: Theme.of(context).colorScheme.textPrimary,
                      ),
                    ),
                  ],
                ),
              )
              else
                Flexible(
                child: vm.hasDiscount
                    ? Column(
                  children: [
                    Text(
                      "Unit Ticket Price",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).colorScheme.textSecondary,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    FittedBox(
                      child: NairaDisplay(
                        amount: vm.discountUnitPrice,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        addDecimal: true,
                        color: Theme.of(context).colorScheme.textPrimary,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 3.h),
                      child: FittedBox(
                        child: NairaDisplay(
                          amount: vm.unitPrice,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          addDecimal: true,
                          color: ColorPath.redOrange,
                          isSlashedAmount: true,
                        ),
                      ),
                    ),
                  ],
                )
                  : Column(
                  children: [
                    Text(
                      "Unit Ticket Price",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).colorScheme.textSecondary,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    FittedBox(
                      child: NairaDisplay(
                        amount: vm.unitPrice,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        addDecimal: false,
                        color: Theme.of(context).colorScheme.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          if(!vm.isUpComing) Padding(
            padding: EdgeInsets.only(top: 32.h),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "Get Best Deal today!!!",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: ColorPath.redOrange,
                ),
              ),
            ),
          ),
          if(!vm.isUpComing) Padding(
            padding: EdgeInsets.only(top: 20.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 5.h),
                    child: FlutterSlider(
                      values: [vm.quantity.toDouble()],
                      min: 1,
                      max: vm.availableTickets.toDouble(),
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
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(4.r),
                                        ),
                                      ),
                                      child: Center(
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              vm.quantity.toInt().toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium
                                                  ?.copyWith(
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
                        // setState(() {
                        //   quantity = lowerValue;
                        // });
                        vm.quantity = lowerValue;
                        vm.calculatePrice(isUnitPriceCalculation: true);
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
          ),
          if(!vm.isUpComing)Padding(
            padding: EdgeInsets.only(top: 5.h),
            child: Row(
              spacing: 12.w,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(vm.discountTiers.length, (index) {
                final tier = vm.discountTiers[index];
                final min = tier.min ?? 1;
                final max = tier.max ?? 1;
                final value = tier.value ?? 0;
                final isActive = vm.quantity.toInt().isBetween(min, max);

                return Expanded(
                  child: CustomPaint(
                    painter: DottedBorder(
                      color: isActive ? ColorPath.redOrange : ColorPath.altoGrey,
                      borderRadius: BorderRadius.all(Radius.circular(8.r)),
                    ),
                    child: Container(
                      height: 54.h,
                      padding: EdgeInsets.symmetric(
                        vertical: 8.h,
                        horizontal: 8.w,
                      ),
                      decoration: BoxDecoration(
                        color: isActive ? ColorPath.fairPink : ColorPath.wildGrey,
                        borderRadius: BorderRadius.all(Radius.circular(8.r)),
                      ),
                      child: Center(
                        child: FittedBox(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "$min ${min > 1 ? 'Units':'Unit'} +",
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.textTertiary,
                                    ),
                              ),
                              SizedBox(height: 5.h),
                              Text(
                                "${value}% Off",
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: isActive
                                          ? ColorPath.redOrange
                                          : Theme.of(
                                              context,
                                            ).colorScheme.textPrimary,
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
          ),
          if(!vm.isUpComing)Padding(
            padding: EdgeInsets.only(top: 16.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    CustomSvg(
                      asset: AppAsset.minEntry2,
                      height: 16.h,
                      width: 16.w,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      "Min Entry: ₦${Utilities.abbreviateAmount(value: vm.minEntryPrice)}",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).colorScheme.textSecondary,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 16.w),
                Row(
                  children: [
                    CustomSvg(asset: AppAsset.avatar2, height: 16.h, width: 16.w),
                    SizedBox(width: 8.w),
                    Text(
                      "${Utilities.formatAmount(
                          amount: vm.maxPerson,
                          addDecimal: false
                      )} ${vm.maxPerson > 1 ? 'Tickets':'Ticket'}",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).colorScheme.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if(!vm.isUpComing)Padding(
            padding: EdgeInsets.only(top: 24.h),
            child: DottedContainer(
              borderRadius: 8,
              padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 24.w),
              decoration: BoxDecoration(
                color: ColorPath.fairPink,
                borderRadius: BorderRadius.all(Radius.circular(8.r)),
              ),
              child: Center(
                child: FittedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        vm.hasDiscount ? "Discounted price " : "Total price",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).colorScheme.textTertiary,
                        ),
                      ),
                      SizedBox(height: 5.h),
                      vm.hasDiscount
                          ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FittedBox(
                            child: NairaDisplay(
                              amount: (vm.unitPrice * vm.quantity),
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w400,
                              addDecimal: true,
                              color: ColorPath.lisaPink,
                              isSlashedAmount: true,
                            ),
                          ),
                          SizedBox(width: 10.w),
                          FittedBox(
                            child: NairaDisplay(
                              amount: (vm.discountUnitPrice * vm.quantity),
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w700,
                              addDecimal: true,
                              color: ColorPath.redOrange,
                            ),
                          ),
                        ],
                      ):FittedBox(
                              child: NairaDisplay(
                                amount: (vm.unitPrice * vm.quantity),
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w700,
                                addDecimal: true,
                                color: ColorPath.redOrange,
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
