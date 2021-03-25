import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:majalatek/view/bloc/searchBloc/search_bloc.dart';
import 'package:majalatek/view/constants.dart';
import 'package:majalatek/view/dialogs/wait_pop_up.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final String textInitial;
  final Function validator;
  final Widget prefixIcon;
  final int maxLines;
  final TextEditingController controller;
  final bool readOnly;
  final TextInputType inputype;
  final Widget suffixWidget;
  final Function onTap;
  final bool autoFocus;
  final Function(String) onChanged;
  const CustomTextField({
    Key key,
    this.hint,
    this.textInitial,
    this.validator,
    this.prefixIcon,
    this.suffixWidget,
    this.onChanged,
    this.inputype,
    this.readOnly = false,
    this.onTap,
    this.maxLines,
    this.autoFocus = false,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4.0,
      borderRadius: BorderRadius.circular(10.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: controller,
                enableSuggestions: false,
                autocorrect: false,
                initialValue: textInitial,
                maxLines: maxLines ?? 1,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (value) async {
                  Get.dialog(WaitPopup());
                  await SearchBloc.instance.searchNearbySpecialities(value);
                  Get.back();
                },
                textAlign: TextAlign.end,
                autofocus: autoFocus ?? false,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12,
                  ),
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: hint,
                  prefixIcon: prefixIcon,
                ),
                style: mainStyle.copyWith(color: primaryBlue),
                readOnly: readOnly,
                onTap: onTap,
                keyboardType: inputype,
                validator: validator,
                onChanged: onChanged,
              ),
            ),
            suffixWidget
          ],
        ),
      ),
    );
  }
}
