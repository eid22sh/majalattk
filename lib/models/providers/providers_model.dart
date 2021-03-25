import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:majalatek/view/bloc/Providers/providers_bloc.dart';

class ProviderModel {
  String id;
  String name;
  String phone;
  String country;
  Map<String, dynamic> specialty;
  String description;
  String facebook;
  String twiter;
  String instagram;
  String whatsapp;
  String snapchat;
  String website;
  String email;
  String isSpecial;
  String specialUntil;
  String views;
  String image;
  String ratingTotal;
  String lat;
  String lng;
  Uint8List icon;
  String countryFlag;
  ImageProvider imageProvider;
  ProviderModel({
    this.id,
    this.name,
    this.phone,
    this.country,
    this.specialty,
    this.description,
    this.facebook,
    this.twiter,
    this.instagram,
    this.whatsapp,
    this.snapchat,
    this.website,
    this.email,
    this.isSpecial,
    this.specialUntil,
    this.views,
    this.image,
    this.ratingTotal,
    this.lat,
    this.lng,
  });

  factory ProviderModel.fromJson(Map json) {
    return ProviderModel(
      id: json["id"].toString(),
      name: json["name"].toString(),
      phone: json["phone"].toString(),
      country: json["country"].toString(),
      specialty: json["specialty"],
      description: json["description"].toString(),
      facebook: json["facebook"].toString(),
      twiter: json["twitter"].toString(),
      instagram: json["instagram"].toString(),
      whatsapp: json["whatsapp"].toString(),
      snapchat: json["snapchat"].toString(),
      website: json["website"].toString(),
      email: json["email"].toString(),
      isSpecial: json["is_special"].toString(),
      specialUntil: json["special_until"].toString(),
      views: json["views"].toString(),
      image: json["image"].toString(),
      ratingTotal: json["ratingTotal"].toString(),
      lat: json["location"] == null ? "" : json["location"]["lat"].toString(),
      lng: json["location"] == null ? "" : json["location"]["lng"].toString(),
    );
  }

  factory ProviderModel.fromJsonRegister(Map json) {
    return ProviderModel(
      id: json["id"].toString(),
      name: json["name"].toString(),
      phone: json["phone"].toString(),
      country: json["country"].toString(),
      specialty: json["specialty"],
      description: json["description"].toString(),
      facebook: json["facebook"].toString(),
      twiter: json["twitter"].toString(),
      instagram: json["instagram"].toString(),
      whatsapp: json["whatsapp"].toString(),
      snapchat: json["snapchat"].toString(),
      website: json["website"].toString(),
      email: json["email"].toString(),
      isSpecial: json["is_special"].toString(),
      specialUntil: json["special_until"].toString(),
      views: json["views"].toString(),
      image: json["image"].toString(),
      ratingTotal: json["ratingTotal"].toString(),
    );
  }

  Future getImage() async {
    imageProvider = NetworkImage(image);
    imageProvider.resolve(ImageConfiguration()).addListener(
            ImageStreamListener((info, loaded) {}, onChunk: (chunk) async {
          if (chunk.cumulativeBytesLoaded == chunk.expectedTotalBytes) {
            await ProviderBloc.instance.getProviders();
          }
        }));
  }

  @override
  String toString() {
    return this.id +
        " ," +
        this.name +
        " ," +
        this.phone +
        " ," +
        this.country +
        " ," +
        this.description;
  }
}
