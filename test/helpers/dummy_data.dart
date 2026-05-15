import 'package:for_u/data/request/request.dart';
import 'package:for_u/data/responses/responses.dart';

class DummyData {
  static final DateTime fixedBirthDate = DateTime.utc(1995, 6, 15);
  static final DateTime fixedCreatedAt = DateTime.utc(2026, 1, 1, 12, 0, 0);
  static final DateTime fixedLastLoginAt = DateTime.utc(2026, 5, 1, 9, 30, 0);

  static const String validEmail = 'test.user@example.com';
  static const String invalidEmail = 'not-an-email';

  static AuthInitRequest authInitRequest({
    String email = validEmail,
    DateTime? birthDate,
  }) {
    return AuthInitRequest(
      email: email,
      birthDate: birthDate ?? fixedBirthDate,
    );
  }

  static AuthInitResponse authInitResponseSuccess({
    bool registered = false,
    String message = 'ok',
  }) {
    return AuthInitResponse(
      success: true,
      message: message,
      registered: registered,
      createdAt: fixedCreatedAt,
      lastLoginAt: fixedLastLoginAt,
    );
  }

  static AuthInitResponse authInitResponseLogicalFailure({
    String message = 'Invalid credentials',
  }) {
    return AuthInitResponse(
      success: false,
      message: message,
      registered: false,
      createdAt: fixedCreatedAt,
    );
  }

  static const Map<String, dynamic> authInitRequestJson = {
    'email': validEmail,
    'birth_date': '1995-06-15T00:00:00.000Z',
  };

  static const Map<String, dynamic> authInitResponseJson = {
    'success': true,
    'message': 'ok',
    'registered': true,
    'created_at': '2026-01-01T12:00:00.000Z',
    'last_login_at': '2026-05-01T09:30:00.000Z',
  };
}
