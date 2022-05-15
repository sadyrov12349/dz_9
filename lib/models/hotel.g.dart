// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hotel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HotelPreview _$HotelPreviewFromJson(Map<String, dynamic> json) {
  return HotelPreview(
    uuid: json['uuid'] as String,
    name: json['name'] as String,
    poster: json['poster'] as String,
    hotelAddress: json['hotelAddress'] as HotelAddress,
  );
}

Map<String, dynamic> _$HotelPreviewToJson(HotelPreview instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'name': instance.name,
      'poster': instance.poster,
      'hotelAddress': instance.hotelAddress,
    };




HotelAddress _$HotelAddressFromJson(Map<String, dynamic> json) {
  return HotelAddress(
    country: json['country'] as String,
    street: json['street'] as String,
    city: json['city'] as String,
  );
}

Map<String, dynamic> _$HotelAddressToJson(HotelAddress instance) =>
    <String, dynamic>{
      'country': instance.country,
      'street': instance.street,
      'city': instance.city,
    };
