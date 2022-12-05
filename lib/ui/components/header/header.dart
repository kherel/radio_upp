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
    return _AnimatedHeader(height: maxExtent);
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

class _AnimatedHeader extends StatefulWidget {
  const _AnimatedHeader({
    required this.height,
  });

  final double height;
  @override
  State<_AnimatedHeader> createState() => __AnimatedHeaderState();
}

class __AnimatedHeaderState extends State<_AnimatedHeader>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Offset> offsetAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    )..forward();

    offsetAnimation = Tween<Offset>(
      begin: Offset(0, -widget.height),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOutCirc,
    ));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: offsetAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: offsetAnimation.value,
          child: child,
        );
      },
      child: Container(
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
            color: BrandColors.secondaryBlack,
            borderRadius: BorderRadius.circular(30)),
        padding: const EdgeInsets.only(bottom: 25),
        child: const Logo.small(),
      ),
    );
  }
}
