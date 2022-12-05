import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:radio_upp/ui/components/brand_loader/brand_loader.dart';

class RadioAvatar extends StatelessWidget {
  final double size;
  final double radius;
  final String url;

  const RadioAvatar.s80(this.url)
      : size = 80,
        radius = 21;

  const RadioAvatar.s50(this.url)
      : size = 50,
        radius = 12;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: CachedNetworkImage(
        width: size,
        height: size,
        fit: BoxFit.cover,
        imageUrl: 'https://www.radioair.info/images_radios/$url',
        placeholder: (context, url) => const BrandLoader(),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }
}
