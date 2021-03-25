import 'package:flutter/material.dart';
import '../constants.dart';

class FlagDropDown extends StatelessWidget {
  final Function onChanged;
  final data;
  const FlagDropDown({
    Key key,
    @required this.country,
    this.onChanged,
    this.data,
  }) : super(key: key);

  final String country;

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      onChanged: onChanged,
      value: country,
      items: List.generate(
        data.length,
        (index) => DropdownMenuItem(
          value: data[index]["code"],
          child: Row(
            children: [
              Image.network(
                data[index]["flag"],
                width: 32,
              ),
              Text(
                " (${data[index]["code"]})",
                style: contactStyle.copyWith(fontSize: 12),
              )
            ],
          ),
        ),
      ),
    );
  }
}
