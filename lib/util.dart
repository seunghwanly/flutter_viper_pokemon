import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// Use this class to return the result of an asynchronous operation.
class Result<T extends Object?, E> {
  const Result({
    this.data,
    this.error,
  });

  final T? data;

  final E? error;

  bool get hasData => data != null && error == null;

  bool get hasError => error != null && data == null;
}

class ResultException<E> implements Exception {
  const ResultException({
    required this.error,
  });

  final E error;

  factory ResultException.fromResult(Result result) {
    assert(result.hasError);
    return ResultException(error: result.error as E);
  }
}

/// [dio] package [Response] extension
extension ResponseExtension on Response {
  bool get isOk => statusCode != null && statusCode! ~/ 100 == 2;
}

class Debouncer {
  Timer? _timer;

  final Duration delay;

  Debouncer({
    this.delay = const Duration(milliseconds: 250),
  });

  void run({
    required VoidCallback action,
  }) {
    _timer?.cancel();
    _timer = Timer(delay, action);
  }

  void dispose() => _timer?.cancel();
}
