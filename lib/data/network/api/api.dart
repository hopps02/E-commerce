import 'package:dio/dio.dart';
import 'package:for_u/data/request/request.dart';
import 'package:for_u/data/responses/responses.dart';
import 'package:retrofit/retrofit.dart';

part 'api.g.dart';

@RestApi()
abstract class AppServices {
  factory AppServices(Dio dio, {String baseUrl}) = _AppServices;

  @POST('/auth/init')
  Future<AuthInitResponse> authInit(@Body() AuthInitRequest request);
}
