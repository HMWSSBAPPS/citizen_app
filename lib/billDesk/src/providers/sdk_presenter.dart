library;

import 'package:get/get.dart';
import 'package:hmwssb/billDesk/src/model/sdk_context.dart';
import 'package:hmwssb/billDesk/src/sdk_service/sdk_service.dart';
import 'package:hmwssb/billDesk/src/utilities/sdk_constant.dart';
import 'package:hmwssb/billDesk/src/providers/http_service.dart';

class SdkPresenter{
  SdkContext? sdkContext;
  SdkService? sdkService;

  SdkPresenter({
    this.sdkContext,
    this.sdkService,
  });

  Future<Response?> getOrder(
    authToken,
    merchantId,
    billdeskOrderId,
      config
  ) async {

    Map<String, String> headers = {
      'Authorization': authToken,
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    Map<String, dynamic> body = {
      'mercid': merchantId,
      'bdorderid': billdeskOrderId,
    };


    return await HttpService().post(
        routeDetails: SdkApiConstants.ORDER_DETAILS,
        reqHeaders: headers,
        body: body,
      config: config
    );

  }

  Future<Response?> getMandateOrder(
      authToken,
      mercid,
      mandateTokenId,
      config
      ) async {

    Map<String, String> headers = {
      'Authorization': authToken,
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    Map<String, dynamic> body = {
      'mercid': mercid,
      'mandate_tokenid': mandateTokenId,
    };

    return await HttpService().post(
        routeDetails: SdkApiConstants.MANDATE_DETAILS,
        reqHeaders: headers,
        body: body,
        config: config
    );

  }

  Future<Response?> getModifyMandateOrder(
      authToken,
      mercid,
      mandateTokenId,
      config
      ) async {
    Map<String, String> headers = {
      'Authorization': authToken,
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    Map<String, dynamic> body = {
      'mercid': mercid,
      'mandate_tokenid': mandateTokenId,
    };

    return await HttpService().post(
      routeDetails: SdkApiConstants.MODIFY_MANDATE_DETAILS,
      reqHeaders: headers,
      body: body,
      config: config
    );
    
  }

  Future<Response?> queryWeb(
      authToken,
      mercid,
      bdorderid,
      orderId,
      config
      ) async {

    Map<String, String> headers = {
      'Authorization': authToken,
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    Map<String, dynamic> body = {
      'mercid': mercid,
      'bdorderid': bdorderid,
      'orderid': orderId,
    };
    
    return await HttpService().post(
        routeDetails: SdkApiConstants.QUERY_WEB_DETAILS,
        reqHeaders: headers, 
        body: body,
      config: config
    );
  }

  Future<Response?> polling(
      authToken,
      mercid,
      mandateTokenId,
      config
      ) async {

    Map<String, String> headers = {
      'Authorization': authToken,
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    Map<String, dynamic> body = {
      'mercid': mercid,
      'mandate_tokenid': mandateTokenId,
    };

    return await HttpService().post(
        routeDetails: SdkApiConstants.POLLING_DETAILS,
        reqHeaders: headers,
        body: body,
        config: config
    );
  }
  
}

