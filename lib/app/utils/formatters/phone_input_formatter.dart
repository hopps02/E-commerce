import 'package:flutter/services.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';

/// Builds an as-you-type phone formatter for the given ISO [countryCode]
/// (e.g. `SA`, `GB`). The user types only the national part — the dial code is
/// shown separately in the field's prefix — so the mask excludes the country
/// code.
///
/// Returns an empty list when the country isn't known yet (e.g. before
/// `libphonenumber.init()` has populated [CountryManager]), so the field
/// degrades to plain input instead of throwing.
List<TextInputFormatter> phoneInputFormatters(String countryCode) {
  final countries = CountryManager().countries;
  final index = countries.indexWhere((c) => c.countryCode == countryCode);
  if (index < 0) return const [];

  return [LibPhonenumberTextFormatter(country: countries[index])];
}
