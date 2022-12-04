import 'package:flutter/material.dart';
import 'package:radio_upp/config/brand_colors.dart';
import 'package:radio_upp/ui/components/logo/logo.dart';

const kToolbarHeight = 73;

class Header extends SliverPersistentHeaderDelegate {
  const Header(
    this.mediaQueryData,
  );

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      alignment: Alignment.bottomCenter,
      decoration: BoxDecoration(
          color: BrandColors.secondaryBlack,
          borderRadius: BorderRadius.circular(30)),
      padding: const EdgeInsets.only(bottom: 25),
      child: const Logo(),
    );
  }

  final MediaQueryData mediaQueryData;

  @override
  double get maxExtent => mediaQueryData.padding.top + kToolbarHeight;

  @override
  double get minExtent => mediaQueryData.padding.top + kToolbarHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
