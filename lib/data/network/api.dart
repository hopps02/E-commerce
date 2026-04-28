import 'package:jar/data/request/request.dart';
import 'package:jar/data/responses/responses.dart';

import 'dio_factory.dart';

abstract class AppServicesClientAbs {
  Future<AuthInitResponse> authInit(AuthInitRequest request);
}

class AppServices implements AppServicesClientAbs {
  final DioFactory _dio;

  AppServices(this._dio);

  @override
  Future<AuthInitResponse> authInit(AuthInitRequest request) async {
    final response = await _dio.request(
      '/auth/init',
      method: RequestMethod.POST,
      body: request.toJson(),
    );
    return AuthInitResponse.fromJson(response.data);
  }
}
