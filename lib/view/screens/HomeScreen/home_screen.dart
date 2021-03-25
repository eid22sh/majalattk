import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoder/geocoder.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:majalatek/view/bloc/flagBloc/flag_bloc.dart';
import 'package:majalatek/view/screens/BeforeLoginScreen/before_login_screen.dart';
import 'package:majalatek/view/screens/ConverstaionScreen/conversations_screen.dart';
import 'package:provider/provider.dart';

import '../../../models/providers/providers_model.dart';
import '../../../services/Language/language_service.dart';
import '../../../services/location_service.dart';
import '../../bloc/Providers/providers_bloc.dart';
import '../../bloc/searchBloc/search_bloc.dart';
import '../../components/app_bar_icons.dart';
import '../../components/drawer/drawe.dart';
import '../../components/search_bar.dart';
import '../../components/svg_button.dart';
import '../../constants.dart';
import '../../dialogs/wait_pop_up.dart';
import '../SearchProvidersScreen/search_providers_screen.dart';
import 'widgets/provider_widget.dart';

class HomeScreen extends StatefulWidget {
  static const String id = "/home";
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Widget provider = SizedBox.shrink();
  Widget notif = SizedBox.shrink();
  Widget searchBar = SizedBox.shrink();
  var location;
  availableProvidersNotif() {
    setState(() {
      notif = Container(
        padding: EdgeInsets.symmetric(horizontal: 8),
        color: Colors.green[800],
        width: width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              constraints: BoxConstraints(maxHeight: 16, maxWidth: 16),
              padding: EdgeInsets.all(0),
              icon: Icon(
                Icons.close,
                color: Colors.white,
                size: 16,
              ),
              onPressed: closeNotif,
              iconSize: 16,
            ),
            Text(
              LanguageService.instance.data["data"]
                  ["have_special_providers_near_you"],
              style: mainStyle.copyWith(color: Colors.white),
              textDirection: LanguageService.instance.data["direction"],
            ),
          ],
        ),
      );
    });
  }

  Future locationFetch() async {
    await LocationService.instance.locatePosition();
    final coordinates = new Coordinates(
        LocationService.instance.realTimeLocation["lat"],
        LocationService.instance.realTimeLocation["lng"]);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    setState(() {
      location = addresses.first.adminArea + " ," + addresses.first.countryName;
    });
  }

  showSearchBar() {
    setState(() {
      searchBar = InkWell(
        onTap: () {
          SearchBloc.instance.setNearbySpecialities();
          navigator.pushNamed(SearchProviderScreen.id);
        },
        child: Hero(
          tag: "searchBar",
          child: Material(
            type: MaterialType.transparency,
            child: SearchBar(
              text: LanguageService.instance.data["data"]
                  ["search_for_providers"],
              textDirection: LanguageService.instance.data["direction"],
              rightIcon: Padding(
                  padding: EdgeInsets.only(
                    left: 16,
                  ),
                  child: Icon(
                    Icons.search,
                    color: primaryBlue,
                  )),
            ),
          ),
        ),
      );
    });
  }

  closeNotif() {
    setState(() {
      notif = SizedBox.shrink();
    });
  }

  closeProviderNotif() {
    setState(() {
      notif = SizedBox.shrink();
    });
  }

  closeProviderPopUp() {
    setState(() {
      provider = SizedBox.shrink();
    });
  }

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () async {
      await locationFetch().then((value) async {
        Get.dialog(WaitPopup());
        var i = await ProviderBloc.instance.getProviders();
        if (i > 0) {
          availableProvidersNotif();
        } else {
          closeProviderNotif();
        }
        Get.back();
        showSearchBar();
        SearchBloc.instance.setNearbySpecialities();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        closeProviderPopUp();
        return false;
      },
      child: Scaffold(
        key: _scaffoldKey,
        drawer: CustomDrawer(),
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            BlocBuilder<ProviderBloc, List<ProviderModel>>(
              cubit: ProviderBloc.instance,
              builder: (conntext, data) {
                Set<Marker> markers = Set<Marker>();
                for (var state in data) {
                  var icon = BitmapDescriptor.fromBytes(state.icon);
                  markers.add(Marker(
                      icon: icon,
                      onTap: () {
                        setState(() {
                          provider = ProviderWidget(
                            provider: state,
                          );
                        });
                      },
                      markerId: MarkerId(state.id),
                      position: LatLng(
                          double.parse(state.lat), double.parse(state.lng))));
                }
                return GoogleMap(
                    onTap: (_) {
                      closeProviderPopUp();
                    },
                    myLocationEnabled: true,
                    circles: Set.from([
                      Circle(
                          fillColor: Colors.blue.withOpacity(0.15),
                          strokeWidth: 0,
                          circleId: CircleId("1"),
                          center: LatLng(
                              LocationService.instance.realTimeLocation["lat"],
                              LocationService.instance.realTimeLocation["lng"]),
                          radius: 12000)
                    ]),
                    markers: markers,
                    initialCameraPosition:
                        CameraPosition(target: LatLng(0.0, 0.0), zoom: 1),
                    onMapCreated: LocationService.instance.onMapCreate);
              },
            ),
            SizedBox(
              height: height,
              width: width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          padding:
                              EdgeInsets.only(top: 32, right: 16, left: 16),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                Colors.white,
                                Colors.white,
                                Colors.white.withOpacity(0.0)
                              ])),
                          width: width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                              notif,
                              SizedBox(
                                height: 10,
                              ),
                              Consumer<LanguageService>(
                                builder: (context, language, child) =>
                                    SearchBar(
                                  text: location ??
                                      language.data["data"]
                                          ["fetch_your_location"],
                                  textDirection: language.data["direction"],
                                  rightIcon: Padding(
                                    padding: EdgeInsets.only(left: 16.0),
                                    child: SVGButton(
                                      width: width * 0.05,
                                      location: "assets/icons/marker.svg",
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              searchBar,
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                        SVGButton(
                          location: "assets/icons/locate.svg",
                          onTap: () async {
                            Get.dialog(WaitPopup());
                            await locationFetch();
                            var i = await ProviderBloc.instance.getProviders();
                            if (i > 0) {
                              availableProvidersNotif();
                            } else {
                              closeProviderNotif();
                            }
                            Get.back();
                            showSearchBar();
                            SearchBloc.instance.setNearbySpecialities();
                          },
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: width,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 8,
                        bottom: 16,
                        right: 8.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: width / 1.8,
                            child: Row(
                              children: [
                                SVGButton(
                                  onTap: () {
                                    FlagBloc.instance.getCountries();
                                    navigator.pushNamed(BeforeLoginScreen.id);
                                  },
                                  location: "assets/icons/auth.svg",
                                ),
                                Expanded(
                                  child: Container(
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: primaryBlue,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      height: 40,
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.arrow_back_ios_outlined,
                                            color: Colors.white,
                                            size: 15,
                                          ),
                                          Expanded(
                                            child: FittedBox(
                                              child: Text(
                                                " " +
                                                    LanguageService.instance
                                                            .data["data"]
                                                        ["are_you_provider"],
                                                style: mainStyle.copyWith(
                                                    color: Colors.white),
                                                textDirection:
                                                    TextDirection.rtl,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )),
                                )
                              ],
                            ),
                          ),
                          SVGButton(
                            onTap: () async {
                              navigator.pushNamed(ConversationScreen.id);
                            },
                            location: "assets/icons/chat.svg",
                          ),
                          provider
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
