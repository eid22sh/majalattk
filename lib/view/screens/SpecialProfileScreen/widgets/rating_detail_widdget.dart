import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:majalatek/view/components/provider_rating_widget.dart';

import '../../../constants.dart';

class RatingDetailWidget extends StatelessWidget {
  final String text;
  final String asset;
  final double rating;
  const RatingDetailWidget({
    Key key,
    this.text = "",
    this.rating = 0.0,
    this.asset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(asset),
        SizedBox(
          height: 5,
        ),
        Text(
          text,
          style: mainStyle.copyWith(color: primaryBlue, fontSize: width * 0.03),
        ),
        SizedBox(
          height: 10,
        ),
        ProviderRating(
          rating: rating,
          itemPadding: EdgeInsets.only(left: 2.0),
          itemSize: 10,
        )
      ],
    );
  }
}
