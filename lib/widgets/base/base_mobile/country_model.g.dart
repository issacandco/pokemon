// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CountryModel _$CountryModelFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'CountryModel',
      json,
      ($checkedConvert) {
        final val = CountryModel(
          id: $checkedConvert('id', (v) => v as int?),
          name: $checkedConvert('name', (v) => v as String?),
          abbreviation: $checkedConvert('abbreviation', (v) => v as String?),
          phoneCode: $checkedConvert('phoneCode', (v) => v as String?),
          isSelected: $checkedConvert('isSelected', (v) => v as bool?),
        );
        return val;
      },
    );

Map<String, dynamic> _$CountryModelToJson(CountryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'abbreviation': instance.abbreviation,
      'phoneCode': instance.phoneCode,
      'isSelected': instance.isSelected,
    };
