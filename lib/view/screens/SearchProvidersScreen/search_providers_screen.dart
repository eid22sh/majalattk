import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../services/Language/language_service.dart';
import '../../../services/providers_service.dart';
import '../../bloc/searchBloc/search_bloc.dart';
import '../../components/app_bar_icons.dart';
import '../../components/custom_text_field_widget.dart';
import '../../components/drawer/drawe.dart';
import '../../components/speciality_widget.dart';
import '../../constants.dart';
import '../../dialogs/wait_pop_up.dart';
import '../DepartmentsSepcialitiesScreen/departments_specialities_screen.dart';
import 'widgets/departments_widget.dart';

class SearchProviderScreen extends StatefulWidget {
  static const id = "/home/search";
  @override
  _SearchProviderScreenState createState() => _SearchProviderScreenState();
}

class _SearchProviderScreenState extends State<SearchProviderScreen> {
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
              CustomTextField(
                onChanged: (value) {
                  SearchBloc.instance.searchNearbySpecialities(value);
                  searchKey = value;
                },
                suffixWidget: IconButton(
                  onPressed: () async {
                    Get.dialog(WaitPopup());
                    await SearchBloc.instance
                        .searchNearbySpecialities(searchKey);
                    Get.back();
                  },
                  icon: Icon(
                    Icons.search,
                    color: primaryBlue,
                    size: 24,
                  ),
                ),
              ),
              space24,
              SizedBox(
                height: 130,
                width: width,
                child: FutureBuilder(
                  future: ProvidersService.instance.getDepartments(),
                  builder: (context, snapshot) => snapshot.hasData
                      ? ListView.separated(
                          physics: BouncingScrollPhysics(),
                          separatorBuilder: (context, index) => SizedBox(
                            width: 20,
                          ),
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) => snapshot.data[index]
                                      ["providersCount"] ==
                                  0
                              ? SizedBox.shrink()
                              : DepartmentWidget(
                                  imageUrl: snapshot.data[index]["image"],
                                  color: snapshot.data[index]["color"],
                                  name: snapshot.data[index]["title"],
                                  number: snapshot.data[index]["providersCount"]
                                      .toString(),
                                  onTap: () async {
                                    ProvidersService.instance.selectedDepart =
                                        snapshot.data[index]["id"].toString();
                                    navigator.pushNamed(DepSpecScreen.id);
                                  },
                                ),
                        )
                      : Center(
                          child: CircularProgressIndicator(),
                        ),
                ),
              ),
              Consumer<LanguageService>(
                builder: (context, language, child) => Text(
                  language.data["data"]["specialization_in_you_area"],
                  textDirection: language.data["direction"],
                  style: welcomeTitleStyle.copyWith(
                      color: primaryBlue, fontSize: 22),
                ),
              ),
              Expanded(
                child: BlocBuilder<SearchBloc, Map<String, List<Map>>>(
                  cubit: SearchBloc.instance,
                  builder: (context, data) => GridView.builder(
                    physics: BouncingScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3),
                    itemBuilder: (context, index) => SpecialityWidget(
                      text: data["data"][index]["title"],
                      image: data["data"][index]["image"],
                    ),
                    itemCount: data["data"].length,
                  ),
                ),
              )
            ]),
          ),
        ));
  }
}
