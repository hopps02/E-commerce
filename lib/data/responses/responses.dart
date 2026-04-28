import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

import 'package:jar/app/enums/enums.dart';

class BasicResponse {
  final bool success;
  final String message;

  BasicResponse({required this.success, required this.message});

  factory BasicResponse.fromJson(Map<String, dynamic> json) {
    return BasicResponse(
      success: (json['success'] as bool?) ?? true,
      message: (json['message'] as String?) ?? "",
    );
  }
}

class AuthInitResponse extends BasicResponse {
  final bool registered;

  AuthInitResponse({
    required super.success,
    required super.message,
    required this.registered,
  });

  factory AuthInitResponse.fromJson(Map<String, dynamic> json) {
    return AuthInitResponse(
      success: (json['success'] as bool?) ?? true,
      message: (json['message'] as String?) ?? "",
      registered: (json['registered'] as bool?) ?? false,
    );
  }
}
