// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branding_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Branding _$BrandingFromJson(Map<String, dynamic> json) => _Branding(
  primary: json['primary'] as String? ?? '#5130EC',
  secondary: json['secondary'] as String? ?? '#A45C5C',
  success: json['success'] as String? ?? '#2A9C64',
  warning: json['warning'] as String? ?? '#E1712A',
  danger: json['danger'] as String? ?? '#EF4444',
  accent: json['accent'] as String? ?? '#FFC120',
  fontFamily: json['font_family'] as String? ?? 'ibmp_plex_sans_arabic',
  fontUrl: json['font_url'] as String?,
  logoUrl: json['logo_url'] as String?,
  radius: (json['radius'] as num?)?.toInt() ?? 16,
);

Map<String, dynamic> _$BrandingToJson(_Branding instance) => <String, dynamic>{
  'primary': instance.primary,
  'secondary': instance.secondary,
  'success': instance.success,
  'warning': instance.warning,
  'danger': instance.danger,
  'accent': instance.accent,
  'font_family': instance.fontFamily,
  'font_url': instance.fontUrl,
  'logo_url': instance.logoUrl,
  'radius': instance.radius,
};
