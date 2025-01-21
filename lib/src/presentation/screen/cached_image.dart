import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';

class CachedImage extends StatelessWidget {
  final String? url;
  final bool isBig;
  const CachedImage({super.key, required this.url, required this.isBig});

  @override
  Widget build(BuildContext context) {
    if (url == null || url!.isEmpty) {
      return SizedBox.shrink();
    }
    return CachedNetworkImage(
      imageUrl: 'https://image.tmdb.org/t/p/w1280$url',
      width: isBig ? 240 : 80,
      height: isBig ? 360 : 120,
      fit: BoxFit.cover,
    );
  }
}
