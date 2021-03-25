import 'package:flutter/material.dart';
import '../../../constants.dart';

class ProviderMarker extends StatelessWidget {
  final ImageProvider imageprovider;
  const ProviderMarker({Key key, this.imageprovider}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQueryData(),
      child: SizedBox(
        height: width * 0.1,
        width: width * 0.14,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: width * 0.05,
                child: CircleAvatar(
                  radius: width * 0.043,
                  backgroundImage: imageprovider,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: width * 0.03,
                child: CircleAvatar(
                  backgroundColor: Colors.yellow,
                  radius: width * 0.023,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
