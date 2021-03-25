import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// ignore: must_be_immutable
class ChoiceWidget extends StatefulWidget {
  final List<Widget> items;
  final Function(int) onChanged;
  List<bool> states;
  ChoiceWidget({Key key, this.items, this.onChanged}) {
    states = List.filled(items.length, false);
  }

  @override
  _ChoiceWidgetState createState() => _ChoiceWidgetState();
}

class _ChoiceWidgetState extends State<ChoiceWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: List.generate(
          widget.items.length,
          (index) => InkWell(
            onTap: () {
              widget.states = List.filled(widget.states.length, false);

              setState(() {
                widget.states[index] = true;
              });
              print(widget.states);

              widget.onChanged(index);
            },
            child: ListTile(
              leading: widget.states[index]
                  ? SvgPicture.asset(
                      "assets/icons/check.svg",
                      color: Colors.indigo,
                    )
                  : SizedBox.shrink(),
              trailing: widget.items[index],
            ),
          ),
        ),
      ),
    );
  }
}
