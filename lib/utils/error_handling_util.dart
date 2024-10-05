import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ErrorHandlingUtil {
  static const String defaultSystemErrorMessage = 'Oops! Something went wrong. Please try again later.';

  static String handleError(dynamic error) {
    String errorString = defaultSystemErrorMessage;

    if (error is DioException) {
      errorString = _handleDioException(error);
    } else if (error is String) {
      errorString = error;
    } else {
      errorString = defaultSystemErrorMessage;
    }

    logError(errorString);
    return errorString;
  }

  static void logError(String errorMessage) {
    debugPrint(errorMessage);
  }

  static String _handleDioException(DioException dioException) {
    if (dioException.type == DioExceptionType.badResponse) {
      return _handleResponseError(dioException.response!);
    } else {
      return dioException.toString();
    }
  }

  static String _handleResponseError(Response response) {
    String errorString = defaultSystemErrorMessage;
    final statusCode = response.statusCode;

    switch (statusCode) {
      case 400:
        errorString = getErrorString(response.data);
        break;
      case 401:
        errorString = _handle401Error(response.data);
        break;
      case 403:
        errorString = 'Forbidden';
        break;
      case 404:
        errorString = 'Not found';
        break;
      case 405:
        errorString = 'Method not allowed';
        break;
      case 429:
        errorString = 'Too many requests';
        break;
      case 431:
        errorString = 'Request Header Fields Too Large';
        break;
      case 500:
        errorString = 'Internal server error';
        break;
      case 502:
        errorString = 'Bad gateway';
        break;
      case 503:
        errorString = 'Service unavailable';
        break;
      default:
        errorString = defaultSystemErrorMessage;
        break;
    }

    return errorString;
  }

  static String _handle401Error(dynamic error) {
    String errorMessage = defaultSystemErrorMessage;
    // bool isInvalidSession = false;

    // try {
    //   final errorMsg = error['msg'].toString().toLowerCase();
    //
    //   if (errorMsg.contains('authorization service error') || errorMsg.contains('authorization session not found') || errorMsg.contains('authorization session expired')) {
    //     errorMessage = 'err_invalid_session'.translate();
    //     isInvalidSession = true;
    //   } else {
    //     errorMessage = error['msg'];
    //   }
    // } catch (e) {
    //   log('ErrorHandlingHelper: ${e.toString()}');
    //   errorMessage = defaultSystemErrorMessage;
    // }

    return errorMessage;
  }

  static String getErrorString(dynamic error) {
    var errorData = error;
    if (error is String) {
      errorData = jsonDecode(error);
    }
    if (errorData != null && errorData['msg'] != null) {
      return errorData['msg'];
    } else {
      return defaultSystemErrorMessage;
    }
  }
}
