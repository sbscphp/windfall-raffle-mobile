import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';
import 'package:windfall/core/data/models/ticket.dart';
import '../../../core/constants/app_asset.dart';
import '../../../core/constants/color_path.dart';
import '../../../core/data/models/prize.dart';
import '../../../core/utilities/debouncer.dart';
import '../../../core/utilities/utilities.dart';
import '../custom_expansion_tile.dart';
import '../custom_svg.dart';
import '../custom_text_field.dart';
import '../dotted_container.dart';
import '../media_placeholder.dart';


class InstantGameItem extends StatefulWidget {
  final Prize prize;
  const InstantGameItem({super.key, required this.prize});

  @override
  State<InstantGameItem> createState() => _InstantGameItemState();
}

class _InstantGameItemState extends State<InstantGameItem> {

  final _keyWord = TextEditingController();
  late Debouncer debouncer;
  List<Ticket> _filteredList = [];

  @override
  void initState() {
    debouncer = Debouncer(milliseconds: 800);
    _filteredList = List.of(widget.prize.tickets ?? []);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final description = widget.prize.description ?? 'N/A';
    final total = double.tryParse(widget.prize.totalQuantity?.toString() ?? '0') ?? 0;
    final availableToWin = double.tryParse(widget.prize.availableToBeWon?.toString() ?? '0') ?? 0;
    final isEmpty = widget.prize.tickets?.isEmpty ?? true;
    final image = widget.prize.image ?? '';
    return CustomExpansionTile(
      initiallyExpanded: false,
      primaryChild: Row(
        children: [
          Container(
            height: 48.h,
            width: 48.w,
            decoration: BoxDecoration(
                border: Border.all(color: ColorPath.redOrange, width: 2.w),
                borderRadius: BorderRadius.all(Radius.circular(8.r))
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(8.r)),
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                width: double.infinity,
                imageUrl: image,
                placeholder: (context, url) => const MediaPlaceholder(),
                errorWidget: (context, url, error) => const MediaPlaceholder(),
              ),
            ),
          ),
          SizedBox(width: 16.w,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // Flexible(
                    //   child: NairaDisplay(
                    //     amount: 4500,
                    //     fontSize: 14.sp,
                    //     fontWeight: FontWeight.w700,
                    //     addDecimal: false,
                    //     color: Theme.of(context).colorScheme.textPrimary,
                    //   ),
                    // ),
                    Flexible(
                      child: Text(
                        description,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).colorScheme.textPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomSvg(asset: AppAsset.gift, height: 16.h, width: 16.w,),
                    SizedBox(width: 8.w,),
                    Expanded(
                      child: RichText(
                        textAlign: TextAlign.left,
                        text: TextSpan(
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).colorScheme.textSecondary
                          ),
                          children: [
                            TextSpan(
                              text: '${Utilities.formatAmount(
                                amount: availableToWin,
                                addDecimal: false
                              )}/${Utilities.formatAmount(
                                  amount: total,
                                  addDecimal: false
                              )}',
                            ),
                            TextSpan(
                              text: ' ${total > 1 ? 'Units':'Unit'} to be Won',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: Theme.of(context).colorScheme.textSecondary
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
      secondaryChild: isEmpty ? const SizedBox():Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
            label: '',
            showLabel: false,
            hintText: 'Search',
            controller: _keyWord,
            keyboardType: TextInputType.text,
            prefixIcon: Padding(
              padding: EdgeInsets.only(left: 14.w),
              child: CustomSvg(
                asset:AppAsset.search,
                height: 20.h,
                width: 20.w,
                colorFilter: ColorFilter.mode(
                  Theme.of(context).colorScheme.textFieldSuffixIcon,
                  BlendMode.srcIn,
                ),
              ),
            ),
            onChanged: (value){
              if(value.isEmpty){
                defaultFilterList();
                return;
              }
              filterList(searchWord: value);
            },
          ),
          SizedBox(height: 24.h,),
          if(_filteredList.isEmpty)
            Center(
              child: Text(
                'No Results',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.textTertiary
                ),
              ),
            )
            else GridView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              scrollDirection: Axis.vertical,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _filteredList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 24.h,
                crossAxisSpacing: 24.w,
                mainAxisExtent: 68.h,
              ),
              itemBuilder: (BuildContext context, int index) {
                final ticket = _filteredList[index];
                final ticketNumber = ticket.ticketNumber ?? 'N/A';
                final yetToWin = ticket.flag?.toLowerCase() == 'yet to be won';
                return DottedContainer(
                    borderColor: ColorPath.mistGrey,
                    borderRadius: 8,
                    padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 12.h
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
                          decoration: BoxDecoration(
                              color: yetToWin ? ColorPath.athensGrey10:ColorPath.scandalGreen,
                              borderRadius: BorderRadius.all(Radius.circular(16.r))
                          ),
                          child: Text(
                            yetToWin ? 'Not Yet Won':'Already Won',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.w500,
                                color: yetToWin ? ColorPath.oxfordBlue:ColorPath.hazeGreen
                            ),
                          ),
                        ),
                        SizedBox(height: 4.h,),
                        FittedBox(
                          child: Text(
                            ticketNumber,
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).colorScheme.textTertiary
                            ),
                          ),
                        ),

                      ],
                    )
                );
              })

        ],
      ),
    );
  }

  filterList({required String searchWord}) {
    _filteredList = (widget.prize.tickets ?? [])
        .where((ticket) =>
    (ticket.ticketNumber ?? '').toLowerCase().contains(searchWord.toLowerCase()))
        .toList();
    setState(() {});
  }

  defaultFilterList() {
    _filteredList = widget.prize.tickets ?? [];
    setState(() {});
  }
}
