import 'package:flutter_test/flutter_test.dart';
import 'package:for_u/data/network/converters/datetime_converter.dart';

void main() {
  group('DateTimeConverter', () {
    const converter = DateTimeConverter();

    test('fromJson parses ISO string into a local DateTime', () {
      final result = converter.fromJson('2026-01-01T12:00:00.000Z');
      expect(result.toUtc(), DateTime.utc(2026, 1, 1, 12, 0, 0));
    });

    test('toJson serializes DateTime as UTC ISO-8601', () {
      final result = converter.toJson(DateTime.utc(2026, 1, 1, 12, 0, 0));
      expect(result, '2026-01-01T12:00:00.000Z');
    });

    test('round-trip keeps the same instant', () {
      final original = DateTime.utc(2026, 5, 12, 8, 30, 0);
      final round = converter.fromJson(converter.toJson(original));
      expect(round.toUtc(), original);
    });
  });

  group('NullableDateTimeConverter', () {
    const converter = NullableDateTimeConverter();

    test('fromJson returns null on null input', () {
      expect(converter.fromJson(null), isNull);
    });

    test('fromJson returns null on empty string', () {
      expect(converter.fromJson(''), isNull);
    });

    test('fromJson parses non-empty string', () {
      final result = converter.fromJson('2026-05-12T00:00:00.000Z');
      expect(result?.toUtc(), DateTime.utc(2026, 5, 12));
    });

    test('toJson returns null on null input', () {
      expect(converter.toJson(null), isNull);
    });

    test('toJson serializes DateTime as UTC ISO-8601', () {
      expect(
        converter.toJson(DateTime.utc(2026, 5, 12)),
        '2026-05-12T00:00:00.000Z',
      );
    });
  });
}
