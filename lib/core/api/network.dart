import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hmwssb/core/api/shared_prefernce.dart';
import 'package:hmwssb/core/utils.dart';
import 'package:hmwssb/presentation/auth/login_screen.dart';
// import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class NetworkApiService {
  final Dio _dio = Dio(BaseOptions(
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60)));
  // ..interceptors.add(PrettyDioLogger(
  //     requestHeader: false,
  //     requestBody: true,
  //     responseBody: true,
  //     responseHeader: false,
  //     error: true,
  //     compact: true,
  //     maxWidth: 200))

  // Dio getDioWithOutHeaders() {
  //   return _dio;
  // }

  // Dio getLoginDio() {
  //   return _dio;
  // }

  Future<Response> commonApiCall({
    required String url,
    Object? data,
    bool isTokenNotPassing = false,
    bool isGetAppVersion = false,
    bool isGetMethod = false,
    bool isPostMethod = false,
  }) async {
    Object? body = data != null ? jsonEncode(data) : data;
    log(isTokenNotPassing
        ? 'Token Not Passing'
        : isGetAppVersion
            ? 'Get App Version'
            : isGetMethod
                ? "GET"
                : isPostMethod
                    ? "POST"
                    : "PUT" "   uri : \n$url\nbody : $body");

    try {
      Response response;

      // Determine the HTTP method and make the request
      if (isGetAppVersion) {
        response = await NetworkApiService()
            .getInterceptorDio(isToken: false)
            .get(url, data: body);
      } else if (isTokenNotPassing) {
        response = await NetworkApiService()
            .getInterceptorDio(isToken: false)
            .put(url, data: body);
      } else if (isPostMethod) {
        response =
            await NetworkApiService().getInterceptorDio().post(url, data: body);
      } else if (isGetMethod) {
        response =
            await NetworkApiService().getInterceptorDio().get(url, data: body);
      } else {
        response =
            await NetworkApiService().getInterceptorDio().put(url, data: body);
      }

      log("${isTokenNotPassing ? 'Token Not Passing' : ''}${isGetMethod ? "GET" : isPostMethod ? "POST" : "PUT"} API CALL CODE:${response.statusCode} ~~   $url ~~~ \nSEND BODY:\n $body\nRESPONSE BODY:\n ${jsonEncode(response.data)}");

      // Handle 401 Unauthorized error
      if (response.statusCode == 401) {
        await LocalStorages.logOutUser();
        Navigator.pushAndRemoveUntil(
          Utils.navigatorKey.currentState?.context ??
              Utils.navigatorKey.currentContext!,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
          ModalRoute.withName("/login"),
        );
        EasyLoading.showInfo('Multiple Device logged in');
        return Response(
            requestOptions: RequestOptions(path: url),
            data: null,
            statusCode: 401);
      }

      return response;
    } on DioException catch (ex) {
      log('DioException code: ${ex.response?.statusCode.toString() ?? ex.toString()}');
      if (ex.response?.statusCode == 401) {
        await LocalStorages.logOutUser();
        Navigator.pushAndRemoveUntil(
          Utils.navigatorKey.currentState?.context ??
              Utils.navigatorKey.currentContext!,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
          ModalRoute.withName("/login"),
        );
        // EasyLoading.showInfo('Multiple Device logged in');
        return Response(
            requestOptions: RequestOptions(path: ex.requestOptions.path),
            data: null,
            statusCode: 401);
      } else {
        showException(ex);
        return Response(
            requestOptions: RequestOptions(path: ex.requestOptions.path),
            data: null,
            statusCode: 500);
      }
    }
  }

  // Future<Response> commonApiCall({
  //   required String url,
  //   Object? data,
  //   bool isTokenNotPassing = false,
  //   bool isGetAppVersion = false,
  //   bool isGetMethod = false,
  //   bool isPostMethod = false,
  // }) async {
  //   Object? body = data != null ? jsonEncode(data) : data;
  //   // log("uri : \n$url\nbody : $body");
  //   log(isTokenNotPassing
  //       ? 'Token Not Passing'
  //       : isGetAppVersion
  //           ? 'Get App Version'
  //           : isGetMethod
  //               ? "GET"
  //               : isPostMethod
  //                   ? "POST"
  //                   : "PUT" "   uri : \n$url\nbody : $body");
  //   // log("uri : \n$url\n${LocalStorages.getToken()}");
  //   // await NetworkApiService()
  //   //     .getBasicToken()
  //   //     .put(url, data: body)
  //   //     .then((value) => log("response code : ${value.statusCode}"));
  //   try {
  //     // Response response;
  //     Response response = isGetAppVersion
  //         ? await NetworkApiService()
  //             .getInterceptorDio(isToken: false)
  //             .get(url, data: body)
  //         : isTokenNotPassing
  //             ? await NetworkApiService()
  //                 .getInterceptorDio(isToken: false)
  //                 .put(url, data: body)
  //             : isPostMethod
  //                 ? await NetworkApiService()
  //                     .getInterceptorDio()
  //                     .post(url, data: body)
  //                 : isGetMethod
  //                     ? await NetworkApiService()
  //                         .getInterceptorDio()
  //                         .get(url, data: body)
  //                     : await NetworkApiService()
  //                         .getInterceptorDio()
  //                         .put(url, data: body);
  //     if (isGetAppVersion) {
  //       response = await NetworkApiService()
  //           .getInterceptorDio(isToken: false)
  //           .get(url, data: body);
  //       log("isGetAppVersion response code : ${response.statusCode}");
  //     }
  //     if (isTokenNotPassing) {
  //       response = await NetworkApiService()
  //           .getInterceptorDio(isToken: false)
  //           .put(url, data: body);
  //       log("isTokenNotPassing response code : ${response.statusCode}");
  //     }
  //     if (isPostMethod) {
  //       response =
  //           await NetworkApiService().getInterceptorDio().post(url, data: body);
  //       log("isPostMethod response code : ${response.statusCode}");
  //     }
  //     if (isGetMethod) {
  //       response =
  //           await NetworkApiService().getInterceptorDio().get(url, data: body);
  //       log("isGetMethod response code : ${response.statusCode}");
  //     } else {
  //       response =
  //           await NetworkApiService().getInterceptorDio().put(url, data: body);
  //       log("isPutMethod response code : ${response.statusCode}");
  //     }
  //     // log("response code : ${response.statusCode}");
  //     log("${isTokenNotPassing ? 'Token Not Passing' : ''}${isGetMethod ? "GET" : isPostMethod ? "POST" : "PUT"} API CALL CODE:${response.statusCode} ~~   $url ~~~ \nSEND BODY:\n $body\nRESPONSE BODY:\n ${jsonEncode(response.data)}");
  //     if (response.statusCode == 401) {
  //       await LocalStorages.logOutUser();
  //       Navigator.pushAndRemoveUntil(
  //         Utils.navigatorKey.currentState?.context ??
  //             Utils.navigatorKey.currentContext!,
  //         MaterialPageRoute(builder: (context) => const LoginScreen()),
  //         ModalRoute.withName("/login"),
  //       );
  //       EasyLoading.showInfo('Multiple Device logged in');
  //       return Response(
  //           requestOptions: RequestOptions(path: url),
  //           data: null,
  //           statusCode: 401);
  //     }
  //     return response;
  //   } on DioException catch (ex) {
  //     log('DioException code: ${ex.response?.statusCode.toString() ?? ex.toString()}');
  //     if (ex.response?.statusCode == 401) {
  //       await LocalStorages.logOutUser();
  //       Navigator.pushAndRemoveUntil(
  //         Utils.navigatorKey.currentState?.context ??
  //             Utils.navigatorKey.currentContext!,
  //         MaterialPageRoute(builder: (context) => const LoginScreen()),
  //         ModalRoute.withName("/login"),
  //       );
  //       EasyLoading.showInfo('Multiple Device logged in');
  //       return Response(
  //           requestOptions: RequestOptions(path: ex.requestOptions.path),
  //           data: null,
  //           statusCode: 401);
  //     } else {
  //       showException(ex);
  //       return Response(
  //           requestOptions: RequestOptions(path: ex.requestOptions.path),
  //           data: null,
  //           statusCode: 500);
  //     }
  //   }
  // }

  Dio getInterceptorDio({bool isToken = true}) {
    String token = LocalStorages.getToken();
    // String username = "edp";
    // String password = "Navayuga123";
    String username = "selfbilling";
    String password = "XklLh/eaJmWq937pJu2hBB9nvKVeqYirS1WbwDpHK+U=";
    // String password = '';
    if (isToken) {
      _dio.interceptors.add(BearerTokenInterceptor(token: token));
    } else {
      _dio.interceptors
          .add(BasicAuthInterceptor(username: username, password: password));
    }
    return _dio;
  }

  // Dio getBasicDio() {
  //   String username = "edp";
  //   String password = "Navayuga123";
  //   // String username = "selfbilling";
  //   // String password = "XklLh/eaJmWq937pJu2hBB9nvKVeqYirS1WbwDpHK+U=";
  //   // String password = '';
  //   _dio.interceptors
  //       .add(BasicAuthInterceptor(username: username, password: password));
  //   return _dio;
  // }
  // Dio getBasicToken() {
  //   String token = LocalStorages.getToken();
  //   _dio.interceptors.add(BearerTokenInterceptor(token: token));
  //   return _dio;
  // }
}

class BasicAuthInterceptor extends Interceptor {
  final String username;
  final String password;

  BasicAuthInterceptor({required this.username, required this.password});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final authHeader =
        'Basic ${base64Encode(utf8.encode('$username:$password'))}';
    options.headers['Authorization'] = authHeader;
    super.onRequest(options, handler);
  }
}

class BearerTokenInterceptor extends Interceptor {
  final String token;

  BearerTokenInterceptor({required this.token});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['Authorization'] = 'Bearer $token';
    super.onRequest(options, handler);
  }
}

void showException(DioException ex) {
  if (ex.error is SocketException) {
    EasyLoading.showInfo("No Internet Connection");
  } else if (ex.error is FormatException) {
    EasyLoading.showInfo("Invalid Response Format");
  }
  // else if (ex.error is SocketException) {
  //   EasyLoading.showInfo("No Internet Connection");
  // }
  else if (ex.type == DioExceptionType.unknown) {
    EasyLoading.showInfo("Something Went Wrong");
  } else if (ex.type == DioExceptionType.connectionTimeout) {
    EasyLoading.showInfo("Connection TimeOut");
  } else if (ex.type == DioExceptionType.sendTimeout) {
    EasyLoading.showInfo("Connection Send TimeOut");
  } else if (ex.type == DioExceptionType.receiveTimeout) {
    EasyLoading.showInfo("Connection Received TimeOut");
  } else {
    EasyLoading.showInfo(
        'Error occurred while communicating with server ${ex.error}');
  }
  if (kDebugMode) {
    print(ex.message);
  }
}
