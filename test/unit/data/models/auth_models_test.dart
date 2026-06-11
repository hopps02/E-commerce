import 'package:flutter_test/flutter_test.dart';
import 'package:for_u/data/models/auth/auth_models.dart';

import '../../../helpers/dummy_data.dart';

void main() {
  group('AuthSession.fromJson', () {
    test('parses the full happy-path customer session', () {
      final session = AuthSession.fromJson(DummyData.customerSessionJson);

      expect(session.accessToken, 'jwt-token-value');
      expect(session.tokenType, 'bearer');
      expect(session.role, MobileRole.customer);
      expect(session.account.phone, DummyData.customerPhone);
      expect(session.account.preferredLocale, 'ar');
      expect(session.profile?['customer_number'], 'C345678');
      expect(session.nextScreen, 'home');
      expect(session.blocked, isFalse);
    });

    test('parses the blocked session: no token, null profile', () {
      final session = AuthSession.fromJson(DummyData.blockedSessionJson);

      expect(session.accessToken, isNull);
      expect(session.tokenType, isNull);
      expect(session.profile, isNull);
      expect(session.blocked, isTrue);
      expect(session.nextScreen, 'blocked');
    });

    test('unknown role string yields null role, not a crash', () {
      final json = Map<String, dynamic>.from(DummyData.customerSessionJson)
        ..['active_role'] = 'supervisor';

      final session = AuthSession.fromJson(json);
      expect(session.role, isNull);
    });
  });

  group('MobileRole.tryFrom', () {
    test('maps the three known roles', () {
      expect(MobileRole.tryFrom('customer'), MobileRole.customer);
      expect(MobileRole.tryFrom('cashier'), MobileRole.cashier);
      expect(MobileRole.tryFrom('captain'), MobileRole.captain);
    });

    test('null and unknown values return null', () {
      expect(MobileRole.tryFrom(null), isNull);
      expect(MobileRole.tryFrom('admin'), isNull);
    });
  });

  group('MeData.fromJson', () {
    test('parses account + role without a token block', () {
      final me = MeData.fromJson(const {
        'account': DummyData.customerAccountJson,
        'active_role': 'customer',
        'profile': null,
        'scopes': <String, dynamic>{},
      });

      expect(me.role, MobileRole.customer);
      expect(me.account.id, 7);
      expect(me.profile, isNull);
    });
  });

  group('request bodies serialize with backend field names', () {
    test('RegisterDeviceBody uses app_version', () {
      const body = RegisterDeviceBody(
        token: 'fcm-token',
        platform: 'ios',
        locale: 'ar',
        appVersion: '1.0.0',
      );

      expect(body.toJson(), {
        'token': 'fcm-token',
        'platform': 'ios',
        'locale': 'ar',
        'app_version': '1.0.0',
      });
    });

    test('VerifyOtpBody carries phone + code', () {
      const body = VerifyOtpBody(
        phone: DummyData.customerPhone,
        code: '000000',
      );
      expect(body.toJson(), {
        'phone': DummyData.customerPhone,
        'code': '000000',
      });
    });
  });
}
