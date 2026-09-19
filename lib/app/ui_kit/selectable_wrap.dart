import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/app/extensions/extensions.dart';
import 'package:store/presentation/res/spacing_manager.dart';
import 'package:store/presentation/res/radius_manager.dart';

class SelectableWrap extends StatefulWidget {
  const SelectableWrap({
    super.key,
    required this.count,
    required this.buildChild,
    this.initialSelected,
    required this.onSelected,
  });
  final int count;
  final String Function(int index) buildChild;
  final int? initialSelected;
  final void Function(int?) onSelected;

  @override
  State<SelectableWrap> createState() => _SelectableWrapState();
}

class _SelectableWrapState extends State<SelectableWrap> {
  int? selected;

  @override
  void initState() {
    selected = widget.initialSelected;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: SpaceM.s3,
      runSpacing: SpaceM.s3,
      children: List.generate(
        widget.count,
        (index) => GestureDetector(
          onTap: () {
            setState(() {
              if (selected == index) {
                selected = null;
                widget.onSelected(null);
              } else {
                selected = index;
                widget.onSelected(index);
              }
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: SpaceM.s2, horizontal: SpaceM.s3.w),
            decoration: BoxDecoration(
              color: selected == index ? Colors.purple : Colors.transparent,
              borderRadius: BorderRadius.circular(RadiusM.sm.r),
              border: Border.all(
                color: selected == index
                    ? Colors.purple
                    : Colors.black.withValues(alpha: .1),
                width: 1,
              ),
            ),
            child: Text(
              widget.buildChild(index),
              style: context.labelLarge.copyWith(
                height: 1.2,
                color: selected == index
                    ? Colors.white
                    : Colors.black.withValues(alpha: .5),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
