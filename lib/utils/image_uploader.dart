import 'dart:io';
import 'package:http_parser/http_parser.dart' as HttpParser;
import 'package:dio/dio.dart';
import 'package:mime/mime.dart' as mime;

Future<MapEntry<String, MultipartFile>> createRequestFile(
    File _imagePickedFile) async {
  final mimeTypeData = mime.lookupMimeType(
    _imagePickedFile.path,
    headerBytes: [0xFF, 0xD8],
  ).split('/');
  final file = await MultipartFile.fromFile(
    _imagePickedFile.path,
    filename: 'image',
    contentType: HttpParser.MediaType(mimeTypeData[0], mimeTypeData[1]),
  );
  return MapEntry(file.filename, file);
}
