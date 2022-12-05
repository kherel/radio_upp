import 'package:dio/dio.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter_config/flutter_config.dart';
// import 'package:pretty_dio_logger/pretty_dio_logger.dart';
// import 'package:radio_upp/utils/debug.dart';

import 'dart:async';

import 'api.dart';

abstract class RapidApi extends ApiMap {
  @override
  FutureOr<Dio> getClient() async {
    var dio = Dio(await options);
    // if (Application.isInDebugMode) {
    //   dio.interceptors.add(PrettyDioLogger(
    //     request: true,
    //     requestHeader: true,
    //     requestBody: true,
    //     responseBody: true,
    //     responseHeader: false,
    //     compact: true,
    //     maxWidth: 90,
    //   ));

    //   dio.interceptors.add(
    //     InterceptorsWrapper(
    //       onError: (DioError e, handler) {
    //         if (kDebugMode) {
    //           print(e.requestOptions.baseUrl);
    //         }
    //         print(e.runtimeType);
    //         print(e.requestOptions.headers);
    //         print(e.requestOptions.path);
    //         print(e.requestOptions.data);
    //         print(e.message);
    //         print(e.response);

    //         return handler.next(e);
    //       },
    //     ),
    //   );
    // }
    return dio;
  }

  @override
  @protected
  FutureOr<BaseOptions> get options {
    return BaseOptions(
      headers: {
        'X-RapidAPI-Key': FlutterConfig.get("RAPID_API"),
      },
    );
  }
}
