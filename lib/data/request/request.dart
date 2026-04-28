import 'dart:io';

import 'package:dio/dio.dart';
import 'package:jar/app/enums/enums.dart';

class AuthInitRequest {
  final String email;

  AuthInitRequest({required this.email});

  Map<String, dynamic> toJson() => {'email': email};
}
