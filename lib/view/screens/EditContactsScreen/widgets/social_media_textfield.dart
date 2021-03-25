import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:majalatek/view/components/custom_text_field_widget.dart';

class SocialMediaTextField extends StatelessWidget {
  const SocialMediaTextField({
    Key key,
    this.svgLocation,
    this.onChanged,
    this.initialText,
    this.readOnly = false,
  }) : super(key: key);
  final String assetsLocation = "assets/icons/";
  final String initialText;
  final svgLocation;

  final bool readOnly;
  final Function(String) onChanged;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        children: [
          Expanded(
            child: CustomTextField(
              readOnly: readOnly,
              textInitial: initialText,
              suffixWidget: SizedBox.shrink(),
              onChanged: onChanged,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.grey[100],
            child: SvgPicture.asset(
              assetsLocation + svgLocation,
              height: 32,
            ),
          ),
        ],
      ),
    );
  }
}
