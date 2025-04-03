import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hmwssb/core/api/api.dart';
import 'package:hmwssb/core/api/network.dart';
import 'package:hmwssb/core/theme/app_color.dart';
import 'package:hmwssb/core/utils.dart';
import 'package:hmwssb/data/models/consumer_info.dart';
import 'package:hmwssb/data/models/payment_token_model.dart';
import 'package:hmwssb/presentation/payment/payment_fail.dart';
import 'package:hmwssb/presentation/payment/payment_info.dart';
import 'package:hmwssb/presentation/payment/payment_status.dart';
import 'package:hmwssb/presentation/payment/payment_success.dart';
import 'package:hmwssb/billDesk/src/error/sdk_error.dart';
import 'package:hmwssb/billDesk/src/model/order_info.dart';
import 'package:hmwssb/billDesk/src/model/sdk_config.dart';
import 'package:hmwssb/billDesk/src/screens/sdk_webview.dart';

class PayForOthers extends StatefulWidget {
  const PayForOthers({super.key});

  @override
  State<PayForOthers> createState() => _PayForOthersState();
}

class _PayForOthersState extends State<PayForOthers> {
  MItem2? canInfo;
  GetConsumerInfoByCanMItem3? mItem3;
  var traceId = "";
  final TextEditingController amountController = TextEditingController();
  final TextEditingController canController = TextEditingController();
  final FocusNode amountFocus = FocusNode();
  final FocusNode canFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: primaryColor,
        title: const Text(
          'Pay Others',
          style: TextStyle(color: white, fontSize: 16),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      controller: canController,
                      focusNode: canFocus,
                      maxLines: 1,
                      maxLength: 9,
                      keyboardType: Platform.isIOS
                          ? const TextInputType.numberWithOptions(signed: true)
                          : TextInputType.number,
                      textInputAction: TextInputAction.done,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: ' Enter CAN ',
                        hintText: ' Enter CAN ',
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: Center(
                          child: ElevatedButton(
                        onPressed: () {
                          if (canController.text.isEmpty ||
                              canController.text.length < 9) {
                            EasyLoading.showInfo("Enter Valid Can Number");
                          } else {
                            getConsumerInfo();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: primaryColor,
                        ),
                        child: const Text("Search",
                            style: TextStyle(
                              color: Colors.white,
                            )),
                      )))
                ],
              ),
              showData()
            ],
          ),
        ),
      ),
    );
  }

  Widget showData() {
    final canInfo = this.canInfo;
    if (canInfo != null && mItem3 != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('CAN: ${canInfo.can ?? ""}',
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.blue)),
          const SizedBox(height: 8),
          Text('Name: ${canInfo.name}', style: const TextStyle(fontSize: 14)),
          const SizedBox(height: 8),
          Text('Address: ${canInfo.address}',
              style: const TextStyle(fontSize: 14)),
          const SizedBox(height: 8),
          Text('Category: ${canInfo.category}',
              style: const TextStyle(fontSize: 14)),
          const SizedBox(height: 8),
          Text('Water Pipe Size in MM: ${canInfo.waterPipesizeInMM}',
              style: const TextStyle(fontSize: 14)),
          const SizedBox(height: 8),
          Text(
            'Bill Consumption: ${canInfo.consumption}',
            style: const TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 8),
          Text('Outstanding Amount: ${canInfo.outstandingAmount}',
              style: const TextStyle(fontSize: 14, color: Colors.red)),
          const SizedBox(height: 8),
          Text('Mobile No.: ${canInfo.mobileno}',
              style: const TextStyle(fontSize: 14)),
          const SizedBox(height: 8),
          Text('Email: ${canInfo.email!.isNotEmpty ? canInfo.email : "N/A"}',
              style: const TextStyle(fontSize: 14, color: Colors.purple)),
          const SizedBox(height: 8),
          const Text('Note: Decimals are not allowed',
              style: TextStyle(fontSize: 14, color: Colors.red)),
          const SizedBox(height: 4),
          Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                  controller: amountController,
                  focusNode: amountFocus,
                  maxLines: 1,
                  maxLength: 6,
                  keyboardType: Platform.isIOS
                  ? const TextInputType.numberWithOptions(signed: true)
                  : TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: ' Enter Amount ',
                      hintText: ' Enter Amount '))),
          Center(
              child: ElevatedButton(
                  onPressed: () {
                    double? enteredAmount =
                        double.tryParse(amountController.text);
                    if (enteredAmount == null || enteredAmount == 0) {
                      EasyLoading.showInfo("Enter Valid Amount");
                    } else {
                      canFocus.unfocus();
                      amountFocus.unfocus();
                      // showPrompt();
                      ShowPayBillPrompt.showPrompt(
                        context: context,
                        amountController: amountController,
                        mItem2: canInfo,
                        mItem3: mItem3!,
                        onPressed: () async {
                          if (context.mounted) {
                            Navigator.pop(context);
                            getPaymentToken();
                          }
                        },
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: primaryColor,
                  ),
                  child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 80.0),
                      child: Text("Pay Bill",
                          style: TextStyle(color: Colors.white))))),
        ],
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  // Future showPrompt() {
  //   int? enteredAmount = int.tryParse(amountController.text) ?? 0;
  //   NumToWords.convertNumberToIndianWords(enteredAmount);
  //   return showDialog(
  //       context: context,
  //       builder: (context) {
  //         return AlertDialog(
  //           title: const Text(
  //             'Payment Confirmation',
  //             style: TextStyle(fontSize: 16),
  //           ),
  //           content: Text(
  //             "Rs $enteredAmount ( RUPEES ${(NumToWords.convertNumberToIndianWords(enteredAmount)).toUpperCase()})",
  //             style: const TextStyle(
  //                 fontWeight: FontWeight.bold,
  //                 fontStyle: FontStyle.italic,
  //                 color: Colors.red,
  //                 fontSize: 16),
  //           ),
  //           actions: <Widget>[
  //             OutlinedButton(
  //               onPressed: () {
  //                 Navigator.of(context).pop(false);
  //               },
  //               child: const Text('cancel'),
  //             ),
  //             OutlinedButton(
  //               onPressed: () async {
  //                 if (context.mounted) {
  //                   Navigator.pop(context);
  //                   getPaymentToken();
  //                 }
  //               },
  //               child: const Text('Proceed'),
  //             ),
  //           ],
  //         );
  //       });
  // }

  getPaymentToken() async {
    try {
      EasyLoading.show(status: "Loading...");
      var response =
          await NetworkApiService().commonApiCall(url: Api.paymentToken, data: {
        'can': canController.text.trim(),
        'amount': amountController.text.trim(),
      });
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        var value = PaymentTokenModel.fromJson(response.data);
        if (value.status != null && value.status == "ACTIVE") {
          sdkConfig(value);
        } else {
          EasyLoading.showError("${value.status ?? ''}An error 0ccured");
        }
      }
    } on DioException catch (ex) {
      EasyLoading.dismiss();
      showException(ex);
    }
  }

  sdkConfig(PaymentTokenModel value) async {
    ResponseHandler responseHandler =
        SdkResponseHandler(flowType: 'payments', context: context);

    var token = "";
    value.links?.forEach((element) {
      if (element.headers != null) {
        token = element.headers!.authorization.toString();
      }
    });

    final flowConfigmap = {
      "merchantId": value.mercid,
      "bdOrderId": value.bdorderid,
      "authToken": token,
      "childWindow": true,
      "retryCount": 3,
    };
    String base64Image =
        await Utils.imageAssetToBase64('assets/images/splash_logo.png');
    String imageDataUrl =
        "data:image/png;base64,$base64Image"; // Make sure to use the correct MIME type, e.g., image/png, image/jpeg

    final sdkConfigMap = {
      "flowConfig": flowConfigmap,
      "flowType": "payments",
      "merchantLogo": imageDataUrl,
      // "iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAABHNCSVQICAgIfAhkiAAAAAlwSFlzAAAApgAAAKYB3X3/OAAAABl0RVh0U29mdHdhcmUAd3d3Lmlua3NjYXBlLm9yZ5vuPBoAAANCSURBVEiJtZZPbBtFFMZ/M7ubXdtdb1xSFyeilBapySVU8h8OoFaooFSqiihIVIpQBKci6KEg9Q6H9kovIHoCIVQJJCKE1ENFjnAgcaSGC6rEnxBwA04Tx43t2FnvDAfjkNibxgHxnWb2e/u992bee7tCa00YFsffekFY+nUzFtjW0LrvjRXrCDIAaPLlW0nHL0SsZtVoaF98mLrx3pdhOqLtYPHChahZcYYO7KvPFxvRl5XPp1sN3adWiD1ZAqD6XYK1b/dvE5IWryTt2udLFedwc1+9kLp+vbbpoDh+6TklxBeAi9TL0taeWpdmZzQDry0AcO+jQ12RyohqqoYoo8RDwJrU+qXkjWtfi8Xxt58BdQuwQs9qC/afLwCw8tnQbqYAPsgxE1S6F3EAIXux2oQFKm0ihMsOF71dHYx+f3NND68ghCu1YIoePPQN1pGRABkJ6Bus96CutRZMydTl+TvuiRW1m3n0eDl0vRPcEysqdXn+jsQPsrHMquGeXEaY4Yk4wxWcY5V/9scqOMOVUFthatyTy8QyqwZ+kDURKoMWxNKr2EeqVKcTNOajqKoBgOE28U4tdQl5p5bwCw7BWquaZSzAPlwjlithJtp3pTImSqQRrb2Z8PHGigD4RZuNX6JYj6wj7O4TFLbCO/Mn/m8R+h6rYSUb3ekokRY6f/YukArN979jcW+V/S8g0eT/N3VN3kTqWbQ428m9/8k0P/1aIhF36PccEl6EhOcAUCrXKZXXWS3XKd2vc/TRBG9O5ELC17MmWubD2nKhUKZa26Ba2+D3P+4/MNCFwg59oWVeYhkzgN/JDR8deKBoD7Y+ljEjGZ0sosXVTvbc6RHirr2reNy1OXd6pJsQ+gqjk8VWFYmHrwBzW/n+uMPFiRwHB2I7ih8ciHFxIkd/3Omk5tCDV1t+2nNu5sxxpDFNx+huNhVT3/zMDz8usXC3ddaHBj1GHj/As08fwTS7Kt1HBTmyN29vdwAw+/wbwLVOJ3uAD1wi/dUH7Qei66PfyuRj4Ik9is+hglfbkbfR3cnZm7chlUWLdwmprtCohX4HUtlOcQjLYCu+fzGJH2QRKvP3UNz8bWk1qMxjGTOMThZ3kvgLI5AzFfo379UAAAAASUVORK5CYII="
    };

    final sdkConfig = SdkConfig(
        sdkConfigJson: SdkConfiguration.fromJson(sdkConfigMap),
        responseHandler: responseHandler,
        isUATEnv: true,
        isDevModeAllowed: true,
        isJailBreakAllowed: true);

    SDKWebView.openSDKWebView(sdkConfig);
  }

  getConsumerInfo() async {
    try {
      EasyLoading.show(status: "Loading...");
      var response = await NetworkApiService().commonApiCall(
          url: Api.getConsumerInfo, data: {'can': canController.text.trim()});
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        var value = ConsumerInfoData.fromJson(response.data);
        if ((value.mItem1?.responseCode ?? "0") != "200") {
          EasyLoading.showError(
              value.mItem1?.description ?? "An error 0ccured");
        } else {
          setState(() {
            canInfo = value.mItem2;
            mItem3 = value.mItem3;
          });
        }
      }
    } on DioException catch (ex) {
      EasyLoading.dismiss();
      showException(ex);
    }
  }
}

class SdkResponseHandler implements ResponseHandler {
  final String flowType;
  final BuildContext context;

  SdkResponseHandler({required this.flowType, required this.context});

  @override
  Future<void> onTransactionResponse(TxnInfo txnInfo) async {
    // print('Transaction Response: Order ID $txnInfo');

    try {
      EasyLoading.show(status: "Loading...");
      var response = await NetworkApiService().commonApiCall(
          url: Api.paymentStatus,
          data: {'orderid': txnInfo.txnInfoMap['orderId']});
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        PaymentStatus value = PaymentStatus.fromJson(response.data);
        if ((value.mItem1?.authStatus ?? "0") == "0300") {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => PaymentSuccess(value)));
        } else {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => PaymentFail(value)));
        }
      }
    } on DioException catch (ex) {
      EasyLoading.dismiss();
      showException(ex);
    }
  }

  @override
  void onError(SdkError sdkError) {
    EasyLoading.showInfo(sdkError.description);
  }
}
