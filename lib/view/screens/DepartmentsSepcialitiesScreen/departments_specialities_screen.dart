import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../../services/providers_service.dart';
import '../../components/app_bar_icons.dart';
import '../../components/drawer/drawe.dart';
import '../../components/speciality_widget.dart';
import '../../constants.dart';

class DepSpecScreen extends StatefulWidget {
  static const id = "/home/search/depspec";
  @override
  _DepSpecScreenState createState() => _DepSpecScreenState();
}

class _DepSpecScreenState extends State<DepSpecScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var searchKey = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        drawer: CustomDrawer(),
        backgroundColor: Colors.white,
        body: SizedBox(
          height: height,
          width: width,
          child: Padding(
            padding: EdgeInsets.only(top: 32, right: 16, left: 16),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TopAppIcons(
                    listTapped: () {
                      _scaffoldKey.currentState.openDrawer();
                    },
                  ),
                  Text("مزودي الخدمة",
                      style: TextStyle(
                          fontFamily: "NotoKufi",
                          color: primaryBlue,
                          fontSize: width * 0.05,
                          fontWeight: FontWeight.bold))
                ],
              ),
              space24,
              // CustomTextField(
              //   onChanged: (value) {
              //     SearchBloc.instance.searchNearbySpecialities(value);
              //     searchKey = value;
              //   },
              //   suffixWidget: IconButton(
              //     onPressed: () async {
              //       Get.dialog(WaitPopup());
              //       await SearchBloc.instance
              //           .searchNearbySpecialities(searchKey);
              //       Get.back();
              //     },
              //     icon: Icon(
              //       Icons.search,
              //       color: primaryBlue,
              //       size: 24,
              //     ),
              //   ),
              // ),
              Expanded(
                child: FutureBuilder<List<Map>>(
                  future:
                      ProvidersService.instance.getDepartmentsSpecialities(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      snapshot.data.removeWhere((element) {
                        return element["providersCount"] == 0;
                      });
                    }
                    return snapshot.hasData
                        ? snapshot.data.isNotEmpty
                            ? GridView.builder(
                                physics: BouncingScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3),
                                itemBuilder: (context, index) =>
                                    SpecialityWidget(
                                      allProviders: true,
                                      text: snapshot.data[index]["title"],
                                      id: snapshot.data[index]["id"].toString(),
                                      image: snapshot.data[index]["image"],
                                    ),
                                itemCount: snapshot.data.length)
                            : Center(
                                child: Text(
                                    "Error fetching data , check your internet connection"))
                        : Center(child: CircularProgressIndicator());
                  },
                ),
              )
            ]),
          ),
        ));
  }
}
