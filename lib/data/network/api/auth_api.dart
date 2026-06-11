import 'package:dio/dio.dart';
import 'package:for_u/data/models/auth/auth_models.dart';
import 'package:for_u/data/network/envelope.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_api.g.dart';

/// Auth + device endpoints (guard: mobile). Role is resolved server-side at
/// verify-otp; the same surface serves customer, cashier and captain.
@RestApi()
abstract class AuthApi {
  factory AuthApi(Dio dio, {String? baseUrl}) = _AuthApi;

  @POST('/mobile/auth/request-otp')
  Future<Envelope<OtpRequested>> requestOtp(@Body() RequestOtpBody body);

  @POST('/mobile/auth/verify-otp')
  Future<Envelope<AuthSession>> verifyOtp(@Body() VerifyOtpBody body);

  @GET('/mobile/me')
  Future<Envelope<MeData>> me();

  // Acknowledgement-only endpoints: the body carries no data the app reads
  // (e.g. {logged_out: true}), so the payload stays untyped and repositories
  // map it to Unit.
  @POST('/mobile/auth/logout')
  Future<Envelope<dynamic>> logout();

  @POST('/mobile/devices')
  Future<Envelope<dynamic>> registerDevice(@Body() RegisterDeviceBody body);

  /// The token travels in the body — it is the device's stable identity and
  /// too long for a URL path segment.
  @DELETE('/mobile/devices')
  Future<Envelope<dynamic>> unregisterDevice(@Body() Map<String, String> body);
}
