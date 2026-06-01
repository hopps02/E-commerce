import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:for_u/app/extensions/extensions.dart';
import 'package:for_u/app/ui_kit/custom_cached_image.dart';
import 'package:for_u/presentation/res/color_manager.dart';
import 'package:for_u/presentation/res/fonts_manager.dart';
import 'package:for_u/presentation/res/gen/assets.gen.dart';

class CartItemCard extends StatefulWidget {
  final String title;
  final String weight;
  final double price;
  final String imageUrl;
  final int initialQuantity;
  final ValueChanged<int> onQuantityChanged;
  final VoidCallback onDelete;

  const CartItemCard({
    super.key,
    required this.title,
    required this.weight,
    required this.price,
    required this.imageUrl,
    required this.initialQuantity,
    required this.onQuantityChanged,
    required this.onDelete,
  });

  @override
  State<CartItemCard> createState() => _CartItemCardState();
}

class _CartItemCardState extends State<CartItemCard> {
  Timer? _debounceTimer;
  late int _quantity;

  @override
  void initState() {
    super.initState();
    _quantity = widget.initialQuantity;
  }

  @override
  void didUpdateWidget(covariant CartItemCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialQuantity != oldWidget.initialQuantity ||
        _quantity != widget.initialQuantity) {
      _quantity = widget.initialQuantity;
    }
  }

  void _handleQuantityChange(int change) {
    final newQuantity = _quantity + change;
    if (newQuantity >= 1) {
      setState(() {
        _quantity = newQuantity;
      });

      _debounceTimer?.cancel();
      _debounceTimer = Timer(const Duration(milliseconds: 300), () {
        widget.onQuantityChanged(_quantity);
      });
    }
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(color: ColorM.white),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Right Side in RTL (Start): Image
          Container(
            width: 73.w,
            height: 80.h,
            decoration: BoxDecoration(
              border: Border.all(color: ColorM.gray200, width: 1.w),
              borderRadius: BorderRadius.circular(12.r),
            ),
            padding: EdgeInsets.all(8.w),
            child: CustomCachedImage(
              imageUrl: widget.imageUrl,
              fit: BoxFit.contain,
            ),
          ),

          12.horizontalSpace,

          // Middle & Left Side in RTL (End): Info, Delete, Price, Counter
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Row: Info Column & Delete Bin
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Info Column (Title & Badge)
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.title,
                            style: context.bodyMedium.copyWith(
                              color: ColorM.gray900,
                              fontWeight: FontWeightM.medium,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          6.verticalSpace,
                          // Weight badge
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 4.h,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: ColorM.gray200,
                                width: 1.w,
                              ),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Text(
                              widget.weight,
                              style: context.labelSmall.copyWith(
                                color: ColorM.gray600,
                                fontWeight: FontWeightM.regular,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Delete Button (Far Left in RTL)
                    GestureDetector(
                      onTap: widget.onDelete,
                      child: Padding(
                        padding: EdgeInsetsDirectional.only(
                          start: 8.w,
                          bottom: 8.h,
                        ),
                        child: SvgPicture.asset(
                          Assets.svg.bin.path,
                          width: 20.w,
                        ),
                      ),
                    ),
                  ],
                ),

                12.verticalSpace,

                // Bottom Row: Price & Counter
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Price (Right Side in RTL)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      spacing: 3.w,
                      children: [
                        Text(
                          "${widget.price}",
                          style: context.titleMedium.copyWith(
                            color: ColorM.primary700,
                            fontWeight: FontWeightM.semiBold,
                          ),
                        ),
                        SvgPicture.asset(
                          Assets.svg.saudiRiyalSymbol.path,
                          width: 13.sp,
                          colorFilter: const ColorFilter.mode(
                            ColorM.primary700,
                            BlendMode.srcIn,
                          ),
                        ),
                      ],
                    ),

                    // Counter (Left Side in RTL)
                    Container(
                      width: 71.w,
                      padding: EdgeInsets.all(2.w),
                      decoration: BoxDecoration(
                        color: ColorM.primary50,
                        border: Border.all(
                          color: ColorM.primary50,
                          width: 0.5.w,
                        ),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // In RTL, the first child is on the Right. The screenshot shows [+] on the Right.
                          GestureDetector(
                            onTap: () => _handleQuantityChange(1),
                            child: SvgPicture.asset(
                              Assets.svg.addSquare.path,
                              width: 20.w,
                            ),
                          ),
                          Text(
                            "$_quantity",
                            style: context.bodySmall.copyWith(
                              color: ColorM.gray1000,
                              fontWeight: FontWeightM.bold,
                              fontSize: 12.sp,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => _handleQuantityChange(-1),
                            child: SvgPicture.asset(
                              Assets.svg.minusSquare.path,
                              width: 20.w,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
