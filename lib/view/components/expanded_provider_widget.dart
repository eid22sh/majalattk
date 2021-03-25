import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:majalatek/services/providers_service.dart';
import 'package:majalatek/view/dialogs/wait_pop_up.dart';
import 'package:majalatek/view/screens/ChatScreen/chat_screen.dart';

import '../../models/providers/providers_model.dart';
import '../../services/Language/language_service.dart';
import '../../services/location_service.dart';
import '../../utils/distance_calculator.dart';
import 'contacts_widget.dart';
import 'provider_rating_widget.dart';
import '../constants.dart';

class ExpandedProviderWidget extends StatefulWidget {
  final LanguageService language;
  final ProviderModel provider;

  const ExpandedProviderWidget({Key key, this.language, this.provider})
      : super(key: key);
  @override
  _ExpandedProviderWidgetState createState() => _ExpandedProviderWidgetState();
}

class _ExpandedProviderWidgetState extends State<ExpandedProviderWidget> {
  Widget detailsWidget = SizedBox.shrink();
  var detailsHidden = true;
  showDetails() {
    setState(() {
      if (detailsHidden) {
        detailsWidget = Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.provider.description,
                style: mainStyle,
                textDirection: widget.language.data["direction"],
              ),
            ),
            ContactsWidget(
              chatPressed: () async {
                Get.dialog(WaitPopup());
                await ProvidersService.instance
                    .profileSelected(widget.provider);
                Get.back();
                navigator.pushNamed(ChatScreen.id);
              },
              containerColor: Colors.white,
              iconsColor: primaryBlue,
              inProfile: false,
              provider: widget.provider,
              isSpecial: (widget.provider.isSpecial.compareTo("1") == 0),
            )
          ],
        );
      } else {
        detailsWidget = SizedBox.shrink();
      }
    });
    detailsHidden = !detailsHidden;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        showDetails();
      },
      child: Container(
        width: width,
        margin: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey[400],
              blurRadius: 8,
              spreadRadius: 0.5,
            )
          ],
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                      height: width * 0.13,
                      width: width * 0.13,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: widget.provider.isSpecial.compareTo("1") == 0
                          ? ClipPath(
                              clipper: StripeClip(),
                              child: Container(
                                color: Colors.yellow[600],
                              ),
                            )
                          : SizedBox.shrink(),
                    ),
                    Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.grey,
                    ),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0, top: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.provider.name,
                          textDirection: widget.language.data["direction"],
                          overflow: TextOverflow.ellipsis,
                          style: mainStyle.copyWith(
                            color: primaryBlue,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox.shrink(),
                            Text(
                              "(${widget.provider.ratingTotal})",
                            ),
                            ProviderRating(
                              rating: double.parse(widget.provider.ratingTotal),
                              itemSize: 16,
                              itemPadding: EdgeInsets.all(1.0),
                            ),
                          ],
                        ),
                        widget.provider.lat.isEmpty
                            ? Text("")
                            : Text(
                                calculateDistance(
                                      LocationService
                                          .instance.realTimeLocation["lat"],
                                      LocationService
                                          .instance.realTimeLocation["lng"],
                                      double.parse(widget.provider.lat),
                                      double.parse(widget.provider.lng),
                                    ).toStringAsFixed(1) +
                                    " km",
                                style: mainStyle),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.00),
                  child: Material(
                    type: MaterialType.circle,
                    color: Colors.white,
                    elevation: 5.0,
                    child: CircleAvatar(
                      radius: width * 0.1,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: width * 0.09,
                        backgroundImage: NetworkImage(
                          widget.provider.image,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            detailsWidget
          ],
        ),
      ),
    );
  }
}

class StripeClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = new Path();
    path.moveTo(size.width / 2, 0.0);
    path.lineTo(size.width, 0.0);
    path.lineTo(0.0, size.height);
    path.lineTo(0.0, size.height / 2);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
