import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';

class RateLineWidget extends StatelessWidget {
  final String text;
  final Function(double) onRate;
  const RateLineWidget({
    Key key,
    @required this.text,
    this.onRate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: Text(
        text,
        style: mainStyle.copyWith(color: primaryBlue),
      ),
      leading: RatingBar(
        textDirection: TextDirection.rtl,
        itemSize: 16,
        initialRating: 0.0,
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
        itemPadding: EdgeInsets.all(2.0),
        onRatingUpdate: onRate,
      ),
    );
  }
}
