import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:for_u/app/extensions/extensions.dart';
import 'package:for_u/app/ui_kit/custom_cached_image.dart';
import 'package:for_u/app/ui_kit/flex_text.dart';
import 'package:for_u/presentation/res/color_manager.dart';
import 'package:for_u/presentation/res/fonts_manager.dart';
import 'package:for_u/presentation/res/gen/assets.gen.dart';
import 'package:for_u/presentation/res/router/app_router.dart';
import 'package:for_u/presentation/res/translations_manager.dart';
import 'package:for_u/presentation/views/user/product_details/view/screens/product_details_view.dart';
import 'package:nice_text_form/common/custom_ink_button.dart';

class ProductCard extends StatefulWidget {
  final String title;
  final String imageUrl;
  final double price;
  final double? oldPrice;
  final bool isFavorite;
  final int? quantity;

  /// Live stock ceiling: the counter never climbs past it, so the visible
  /// number always matches what the cart actually holds.
  final int? maxQuantity;
  final void Function(int)? onQuantityChanged;
  final VoidCallback? onLimitReached;
  final VoidCallback? onFavTap;
  final VoidCallback? onTap;
  final bool fitForGridList;

  const ProductCard({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.price,
    this.oldPrice,
    this.isFavorite = false,
    this.quantity,
    this.maxQuantity,
    this.onQuantityChanged,
    this.onLimitReached,
    this.onFavTap,
    this.onTap,
    this.fitForGridList = false,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  Timer? _debounceTimer;
  late int _currentQuantity;

  /// The branch has no available units left for this product.
  bool get _isOutOfStock => widget.maxQuantity != null && widget.maxQuantity! <= 0;

  @override
  void initState() {
    super.initState();
    _currentQuantity = widget.quantity ?? 0;
  }

  void _handleQuantityChange(int change) {
    final newQuantity = _currentQuantity + change;
    if (newQuantity < 0) return;

    final max = widget.maxQuantity;
    // Guard increases only — decreasing is always allowed, even when the line
    // already sits above live stock, so the user can still reduce it.
    if (change > 0 && max != null && newQuantity > max) {
      widget.onLimitReached?.call();
      return;
    }

    setState(() {
      _currentQuantity = newQuantity;
    });

    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 300), () {
      widget.onQuantityChanged?.call(_currentQuantity);
    });
  }

  @override
  void didUpdateWidget(covariant ProductCard oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.quantity != oldWidget.quantity ||
        _currentQuantity != widget.quantity) {
      _currentQuantity = widget.quantity ?? 0;
    }
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;

    return InkWell(
      onTap: widget.onTap ??
          () {
            context.pushNamed(
              Routes.productDetails,
              arguments: const ProductDetailsViewArgs(productId: 0),
            );
          },
      hoverColor: ColorM.transparent,
      splashColor: ColorM.transparent,
      highlightColor: ColorM.transparent,
      child: SizedBox(
        width: widget.fitForGridList ? 9999999 : 156.w,
        child: Column(
          crossAxisAlignment: .end,
          children: [
            Stack(
              children: [
                // Background with Curve
                CustomPaint(
                  size: Size(widget.fitForGridList ? 9999999 : 156.w, 147.h),
                  painter: CardTopPainter(
                    isRtl: !isRtl,
                    innerBorderRadius: 10.r,
                    backgroundBorderRadius: 12.r,
                    padding: 4.w,
                    notchRadius: 55.w,
                  ),
                ),
                // Product Image
                Positioned.fill(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 40.w,
                      vertical: 40.w,
                    ),
                    child: CustomCachedImage(
                      imageUrl: widget.imageUrl,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                // Favorite Button - Positioned on the LEFT visually (End in RTL, Start in LTR)
                PositionedDirectional(
                  top: 4.w,
                  end: 4.w,
                  child: CustomInkButton(
                    onTap: widget.onFavTap,
                    width: 32.w,
                    height: 32.w,
                    backgroundColor: ColorM.white,
                    borderRadius: 99999,
                    child: Center(
                      child: widget.isFavorite
                          ? Assets.svg.fillHeart.svg(
                              width: 14.w,
                              color: Colors.red,
                            )
                          : Assets.svg.borderHeart.svg(
                              width: 14.w,
                              color: ColorM.gray900,
                            ),
                    ),
                  ),
                ),
              ],
            ),
            8.verticalSpace,
            Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      Text(
                        widget.title,
                        style: context.labelMedium.copyWith(
                          color: ColorM.gray900,
                          fontWeight: FontWeightM.medium,
                        ),
                        maxLines: 1,
                        overflow: .ellipsis,
                      ),
                      Row(
                        mainAxisAlignment: .start,
                        children: [
                          FlexText(
                            child: Text(
                              "${widget.price}",
                              style: context.labelMedium.copyWith(
                                color: ColorM.primary550,
                                fontWeight: FontWeightM.semiBold,
                              ),
                            ),
                          ),
                          2.horizontalSpace,
                          Assets.svg.saudiRiyalSymbol.svg(
                            width: 9.w,
                            color: ColorM.primary550,
                          ),
                          if (widget.oldPrice != null) ...[
                            8.horizontalSpace,
                            FlexText(
                              child: Text(
                                "${widget.oldPrice}",
                                style: context.labelSmall.copyWith(
                                  color: ColorM.gray500,
                                  decoration: .lineThrough,
                                  fontSize: 10.sp,
                                ),
                              ),
                            ),
                            4.horizontalSpace,
                            Assets.svg.saudiRiyalSymbol.svg(
                              width: 7.w,
                              color: ColorM.gray500,
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),

                // Add/Quantity Section
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: _currentQuantity > 0
                      ? Container(
                          key: const ValueKey("counter"),
                          width: 58.w,
                          height: 22.h,
                          padding: EdgeInsets.symmetric(horizontal: 2.w),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF3F0FF),
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () => _handleQuantityChange(1),
                                child: SvgPicture.asset(
                                  Assets.svg.addSquare.path,
                                  width: 14.w,
                                  colorFilter: ColorFilter.mode(
                                    ColorM.primary550,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                              FlexText(
                                child: Text(
                                  "$_currentQuantity",
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeightM.medium,
                                    color: const Color(0xFF433F41),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () => _handleQuantityChange(-1),
                                child: SvgPicture.asset(
                                  Assets.svg.minusSquare.path,
                                  width: 14.w,
                                ),
                              ),
                            ],
                          ),
                        )
                      : _isOutOfStock
                          ? Container(
                              key: const ValueKey("out_of_stock"),
                              height: 24.w,
                              constraints: BoxConstraints(maxWidth: 80.w),
                              padding: EdgeInsets.symmetric(horizontal: 8.w),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: ColorM.gray50,
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: FlexText(
                                child: Text(
                                  Translation.out_of_stock.tr,
                                  maxLines: 1,
                                  overflow: .ellipsis,
                                  style: context.labelSmall.copyWith(
                                    color: ColorM.gray500,
                                    fontWeight: FontWeightM.medium,
                                    fontSize: 9.sp,
                                  ),
                                ),
                              ),
                            )
                          : GestureDetector(
                              key: const ValueKey("add"),
                              onTap: () => _handleQuantityChange(1),
                              child: Container(
                                width: 28.w,
                                height: 28.w,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF3F0FF),
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: Center(
                                  child: Assets.svg.bagPlus.svg(
                                    width: 16.w,
                                    color: ColorM.primary,
                                  ),
                                ),
                              ),
                            ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CardTopPainter extends CustomPainter {
  final bool isRtl;
  final double notchRadius;
  final double padding;
  final double backgroundBorderRadius;
  final double innerBorderRadius;

  CardTopPainter({
    required this.isRtl,
    this.notchRadius = 20,
    this.padding = 3,
    this.backgroundBorderRadius = 12,
    this.innerBorderRadius = 12,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final grayPaint = Paint()
      ..color = const Color(0xFFF4F4F4)
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    final whitePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    // ── Background (full rounded rect) ──────────────────────────────────
    canvas.drawRRect(
      RRect.fromLTRBR(
        0,
        0,
        size.width,
        size.height,
        Radius.circular(backgroundBorderRadius),
      ),
      grayPaint,
    );

    canvas.save();

    // ── RTL: mirror horizontally ─────────────────────────────────────────
    if (isRtl) {
      canvas.translate(size.width, 0);
      canvas.scale(-1, 1);
    }

    final double w = size.width - (padding * 2);
    final double h = size.height - (padding * 2);

    canvas.translate(padding, padding);

    // ── Notch scale (original design anchor = 52.0229) ───────────────────
    final double ns = notchRadius / 52.0229;
    final double nw = 52.0229 * ns;

    // ── Corner radius (clamped so it never exceeds card dimensions) ───────
    final double r = innerBorderRadius.clamp(0.0, (w / 2).clamp(0.0, h / 2));
    final Radius cr = Radius.circular(r);

    // ── Build path ────────────────────────────────────────────────────────
    final path = Path();

    // Start at: top edge, right side of notch
    path.moveTo(nw, 0);

    // Original Figma notch — 3-curve asymmetric shape, scaled by ns
    final double nh = 49.1839 * ns;
    path.cubicTo(
      45.7707 * ns,
      0,
      41.4951 * ns,
      8.64819 * ns,
      41.4951 * ns,
      14.9004 * ns,
    );
    path.cubicTo(
      41.4949 * ns,
      27.1057 * ns,
      31.4094 * ns,
      37.0 * ns,
      19.2041 * ns,
      37.0 * ns,
    );
    path.cubicTo(12.7381 * ns, 37.0 * ns, 0, 42.718 * ns, 0, nh);

    // Left side downward
    path.lineTo(0, h - r);

    // Bottom-Left corner → moves to (r, h)
    path.arcToPoint(Offset(r, h), radius: cr, clockwise: false);

    // Bottom edge rightward
    path.lineTo(w - r, h);

    // Bottom-Right corner → moves to (w, h - r)
    path.arcToPoint(Offset(w, h - r), radius: cr, clockwise: false);

    // Right side upward
    path.lineTo(w, r);

    // Top-Right corner → moves to (w - r, 0)
    path.arcToPoint(Offset(w - r, 0), radius: cr, clockwise: false);

    // Top edge back to notch start
    path.lineTo(nw, 0);
    path.close();

    canvas.drawPath(path, whitePaint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CardTopPainter oldDelegate) {
    return oldDelegate.isRtl != isRtl ||
        oldDelegate.notchRadius != notchRadius ||
        oldDelegate.padding != padding ||
        oldDelegate.backgroundBorderRadius != backgroundBorderRadius ||
        oldDelegate.innerBorderRadius != innerBorderRadius;
  }
}
