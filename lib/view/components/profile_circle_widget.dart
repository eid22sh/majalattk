import 'package:flutter/material.dart';
import 'package:majalatek/services/providers_service.dart';

class ProfileCircleWidget extends StatelessWidget {
  final double size;
  const ProfileCircleWidget({
    Key key,
    @required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.white,
      radius: size + 4,
      child: CircleAvatar(
        backgroundColor: Colors.grey,
        radius: size,
        backgroundImage:
            NetworkImage(ProvidersService.instance.selectedProvider.image),
      ),
    );
  }
}
