import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hooks_riverpod/misc.dart';

bool isConnectivityError(Object error) => switch (error) {
  ProviderException(:final exception) => isConnectivityError(exception),
  DioException(type: .connectionError || .connectionTimeout || .sendTimeout || .receiveTimeout) => true,
  DioException(:final error?) => isConnectivityError(error),
  SocketException() || HttpException() || TimeoutException() => true,
  // App Check reports every failure with the code "unknown", so only the platform message tells offline apart.
  FirebaseException(plugin: 'firebase_app_check', :final message?) => appCheckConnectivityMessages.any(
    message.toLowerCase().contains,
  ),
  _ => false,
};

final appCheckConnectivityMessages = [
  'failed to connect',
  'unable to resolve host',
  'timeout',
  'timed out',
  'offline',
  'network connection was lost',
  'could not be found',
];
