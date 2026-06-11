import 'package:flutter_test/flutter_test.dart';
import 'package:for_u/data/models/auth/auth_models.dart';
import 'package:for_u/data/network/envelope.dart';

import '../../../helpers/dummy_data.dart';

void main() {
  group('Envelope', () {
    test('parses a single-resource {data: {...}} body', () {
      final envelope = Envelope<OtpRequested>.fromJson(const {
        'data': DummyData.otpRequestedJson,
      }, (json) => OtpRequested.fromJson(json! as Map<String, dynamic>));

      expect(envelope.data.expiresInSeconds, 300);
      expect(envelope.data.resendAfterSeconds, 60);
      expect(envelope.meta, isNull);
    });

    test('parses a paginated {data: [...], meta: {...}} body', () {
      final envelope = Envelope<List<OtpRequested>>.fromJson(
        const {
          'data': [DummyData.otpRequestedJson, DummyData.otpRequestedJson],
          'meta': {'page': 2, 'page_size': 20, 'total': 41},
        },
        (json) => (json! as List)
            .map((e) => OtpRequested.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

      expect(envelope.data, hasLength(2));
      expect(envelope.meta?.page, 2);
      expect(envelope.meta?.pageSize, 20);
      expect(envelope.meta?.total, 41);
    });

    test('meta fields default sanely when absent', () {
      final meta = Meta.fromJson(const {});
      expect(meta.page, 1);
      expect(meta.pageSize, 20);
      expect(meta.total, 0);
    });
  });
}
