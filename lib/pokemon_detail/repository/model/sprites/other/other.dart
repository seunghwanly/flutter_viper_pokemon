import 'package:flutter_viper_pokemon/pokemon_detail/repository/model/sprites/other/showdown/showdown.dart';
import 'package:json_annotation/json_annotation.dart';

import 'converter.dart';

part 'other.g.dart';

@JsonSerializable(createToJson: false)
class OtherModel {
  const OtherModel({
    required this.officialArtworkDefault,
    required this.showdown,
  });

  @JsonKey(name: 'official-artwork', fromJson: getOfficialArtworkDefault)
  final String officialArtworkDefault;

  final ShowdownModel showdown;

  factory OtherModel.fromJson(Map<String, dynamic> json) =>
      _$OtherModelFromJson(json);
}
