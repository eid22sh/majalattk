import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProviderRating extends StatelessWidget {
  const ProviderRating(
      {Key key,
      @required this.rating,
      this.itemPadding,
      this.itemSize,
      this.ignore = true,
      this.onChanged})
      : super(key: key);
  final EdgeInsets itemPadding;
  final double rating;
  final double itemSize;
  final bool ignore;
  final Function(double) onChanged;
  @override
  Widget build(BuildContext context) {
    return RatingBar(
      ignoreGestures: ignore,
      textDirection: TextDirection.rtl,
      itemSize: itemSize,
      initialRating: rating,
      direction: Axis.horizontal,
      allowHalfRating: false,
      itemCount: 5,
      ratingWidget: RatingWidget(
        half: SizedBox.shrink(),
        full: SvgPicture.asset(
          "assets/icons/full_star.svg",
        ),
        empty: SvgPicture.asset(
          "assets/icons/empty_star.svg",
        ),
      ),
      itemPadding: itemPadding,
      onRatingUpdate: onChanged,
    );
  }
}
