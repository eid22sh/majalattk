import '../../../constants.dart';
import 'package:flutter/material.dart';

class DepartmentWidget extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String number;
  final String color;
  final Function onTap;
  const DepartmentWidget({
    Key key,
    this.imageUrl,
    this.name,
    this.number,
    this.color,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: 200,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              Image.network(
                imageUrl,
                width: 200,
                fit: BoxFit.cover,
              ),
              Container(
                height: 130,
                color: Color(
                  0xff000000 +
                      int.parse(
                        "0x" + color.toString().substring(1),
                      ),
                ).withOpacity(0.6),
                alignment: Alignment.center,
                child: Text(
                  name,
                  textAlign: TextAlign.center,
                  style: mainStyle.copyWith(color: Colors.white),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.white,
                  child: Text(number),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
