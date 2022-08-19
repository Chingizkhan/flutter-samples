import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';

part 'offices.g.dart';

@JsonSerializable()
class OfficesList {
  List<Office> offices;
  OfficesList({required this.offices});

  factory OfficesList.fromJson(Map<String, dynamic> json) => _$OfficesListFromJson(json);

  Map<String, dynamic> toJson() => _$OfficesListToJson(this);

  // factory OfficesList.fromJson(Map<String, dynamic> json) {
  //
  //   var officesJson = json['offices'] as List;
  //
  //   List<Office> officesList = officesJson.map((i) => Office.fromJson(i)).toList();
  //
  //   return OfficesList(
  //       offices: officesList
  //   );
  // }
}

@JsonSerializable()
class Office {
  // @JsonKey(name: 'dt')
  final String name;
  final String address;
  final String image;

  Office({required this.name,required  this.address,required  this.image});

  factory Office.fromJson(Map<String, dynamic> json) => _$OfficeFromJson(json);

  Map<String, dynamic> toJson() => _$OfficeToJson(this);

  // manually
  // factory Office.fromJson(Map<String, dynamic> json) {
  //   return Office(
  //     name: json['name'] as String,
  //     address: json['address'] as String,
  //     image: json['image'] as String
  //   );
  // }
}

Future<OfficesList> getOfficesList() async {
  var url = Uri.https('about.google/static/data/locations.json', '');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    return OfficesList.fromJson(json.decode(response.body));
  } else {
    throw Exception('Http Error: ${response.reasonPhrase}');
  }
}