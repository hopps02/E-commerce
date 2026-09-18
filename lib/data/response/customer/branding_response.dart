import 'package:freezed_annotation/freezed_annotation.dart';

part 'branding_response.freezed.dart';
part 'branding_response.g.dart';

/// The store's identity as the panel set it (GET /mobile/branding): the
/// colours, the font and the logo. Every field has the value the app shipped
/// with, so a store nobody has branded still looks finished.
@freezed
abstract class Branding with _$Branding {
  const Branding._();

  const factory Branding({
    @Default('#5130EC') String primary,
    @Default('#A45C5C') String secondary,
    @Default('#2A9C64') String success,
    @Default('#E1712A') String warning,
    @Default('#EF4444') String danger,
    @Default('#FFC120') String accent,

    /// The bundled font to use, when no file was uploaded.
    @JsonKey(name: 'font_family')
    @Default('ibmp_plex_sans_arabic')
    String fontFamily,

    /// A font the panel uploaded. It wins over the bundled one once the app
    /// has managed to download it.
    @JsonKey(name: 'font_url') String? fontUrl,
    @JsonKey(name: 'logo_url') String? logoUrl,
    @Default(16) int radius,
  }) = _Branding;

  factory Branding.fromJson(Map<String, dynamic> json) =>
      _$BrandingFromJson(json);
}
