import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/base_response_model.dart';
import '../utils/error_handling_util.dart';

enum ConnectionStateType { none, loading, active, done }

typedef OnLoadingResponse = void Function();
typedef OnSuccessResponse = void Function(int, dynamic);
typedef OnErrorResponse = void Function(int, String, bool);
typedef OnDoneResponse = void Function();
typedef BaseResponseBuilder<S> = S Function(Object?);

abstract class BaseViewModel extends GetxController with StateMixin {
  final Rx<BaseResponseModel> _baseResponseStream = BaseResponseModel().obs;
  final Rx<ConnectionStateType> _connectionStateTypeStream = ConnectionStateType.none.obs;

  OnLoadingResponse? _onLoadingResponse;
  OnSuccessResponse? _onSuccessResponse;
  OnErrorResponse? _onErrorResponse;
  OnDoneResponse? _onDoneResponse;

  int _threadNumber = 1; // Initialize directly here

  BaseViewModel();

  ConnectionStateType get connectionState => _connectionStateTypeStream.value;
  Stream<ConnectionStateType> get connectionStateStream => _connectionStateTypeStream.stream;
  Stream<BaseResponseModel> get baseResponseStream => _baseResponseStream.stream;

  void setOnLoadingResponse(OnLoadingResponse callback) => _onLoadingResponse = callback;
  void setOnSuccessResponse(OnSuccessResponse callback) => _onSuccessResponse = callback;
  void setOnErrorResponse(OnErrorResponse callback) => _onErrorResponse = callback;
  void setOnDoneResponse(OnDoneResponse callback) => _onDoneResponse = callback;

  void initialLoading() {
    _onLoadingResponse?.call();
    _connectionStateTypeStream.value = ConnectionStateType.loading;
  }

  void doneResponse() {
    _onDoneResponse?.call();
    _connectionStateTypeStream.value = ConnectionStateType.done;
  }

  void onResponse(dynamic responseData, {int? typeCode}) {
    _onSuccessResponse?.call(typeCode ?? _threadNumber++, responseData);
    _connectionStateTypeStream.value = ConnectionStateType.active;
  }

  void handleError(dynamic error, {bool show = false}) {
    ErrorHandlingUtil.handleError(error);
    _onErrorResponse?.call(101, error.toString(), show);
  }

  BaseResponseModel<U>? handleGenericResponse<U>(String response, {BaseResponseBuilder<U>? builder, int? typeCode}) {
    try {
      final Map<String, dynamic> jsonMap = jsonDecode(response);
      final BaseResponseModel<U> baseResponseModel = BaseResponseModel<U>.fromJson(jsonMap, builder ?? (json) => null as U);

      if (baseResponseModel.isSuccess) {
        onResponse(baseResponseModel.isSuccess ? jsonMap['data'] : baseResponseModel, typeCode: typeCode);
      }

      return baseResponseModel;
    } catch (e) {
      debugPrint(e.toString());
      handleError(e.toString());
      return null;
    }
  }

  void addResponseListener({
    OnLoadingResponse? onLoadingResponse,
    OnSuccessResponse? onSuccessResponse,
    OnErrorResponse? onErrorResponse,
    OnDoneResponse? onDoneResponse,
  }) {
    _onLoadingResponse = onLoadingResponse;
    _onSuccessResponse = onSuccessResponse;
    _onErrorResponse = onErrorResponse;
    _onDoneResponse = onDoneResponse;
  }
}
