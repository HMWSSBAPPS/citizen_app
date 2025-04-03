// objectid : "transaction"
// transactionid : "USBI0000926802"
// orderid : "ORD20240523093205"
// mercid : "BDUATV2APT"
// transaction_date : "2024-05-23T15:02:29+05:30"
// amount : "41.00"
// surcharge : "0.00"
// discount : "0.00"
// charge_amount : "41.00"
// currency : "356"
// additional_info : {"additional_info1":"Details1","additional_info2":"Details2"}
// ru : "https://merchant.com/payment/process"
// txn_process_type : "nb"
// bankid : "SBI"
// itemcode : "DIRECT"
// bank_ref_no : "BILLDESK12"
// auth_status : "0300"
// transaction_error_code : "TRS0000"
// transaction_error_desc : "Transaction Successful"
// transaction_error_type : "success"
// payment_method_type : "netbanking"
// payment_category : "02"

class PaymentStatusModel {
  PaymentStatusModel({
      String? objectid, 
      String? transactionid, 
      String? orderid, 
      String? mercid, 
      String? transactionDate, 
      String? amount, 
      String? surcharge, 
      String? discount, 
      String? chargeAmount, 
      String? currency, 
      AdditionalInfo? additionalInfo, 
      String? ru, 
      String? txnProcessType, 
      String? bankid, 
      String? itemcode, 
      String? bankRefNo, 
      String? authStatus, 
      String? transactionErrorCode, 
      String? transactionErrorDesc, 
      String? transactionErrorType, 
      String? paymentMethodType, 
      String? paymentCategory,}){
    _objectid = objectid;
    _transactionid = transactionid;
    _orderid = orderid;
    _mercid = mercid;
    _transactionDate = transactionDate;
    _amount = amount;
    _surcharge = surcharge;
    _discount = discount;
    _chargeAmount = chargeAmount;
    _currency = currency;
    _additionalInfo = additionalInfo;
    _ru = ru;
    _txnProcessType = txnProcessType;
    _bankid = bankid;
    _itemcode = itemcode;
    _bankRefNo = bankRefNo;
    _authStatus = authStatus;
    _transactionErrorCode = transactionErrorCode;
    _transactionErrorDesc = transactionErrorDesc;
    _transactionErrorType = transactionErrorType;
    _paymentMethodType = paymentMethodType;
    _paymentCategory = paymentCategory;
}

  PaymentStatusModel.fromJson(dynamic json) {
    _objectid = json['objectid'];
    _transactionid = json['transactionid'];
    _orderid = json['orderid'];
    _mercid = json['mercid'];
    _transactionDate = json['transaction_date'];
    _amount = json['amount'];
    _surcharge = json['surcharge'];
    _discount = json['discount'];
    _chargeAmount = json['charge_amount'];
    _currency = json['currency'];
    _additionalInfo = json['additional_info'] != null ? AdditionalInfo.fromJson(json['additional_info']) : null;
    _ru = json['ru'];
    _txnProcessType = json['txn_process_type'];
    _bankid = json['bankid'];
    _itemcode = json['itemcode'];
    _bankRefNo = json['bank_ref_no'];
    _authStatus = json['auth_status'];
    _transactionErrorCode = json['transaction_error_code'];
    _transactionErrorDesc = json['transaction_error_desc'];
    _transactionErrorType = json['transaction_error_type'];
    _paymentMethodType = json['payment_method_type'];
    _paymentCategory = json['payment_category'];
  }
  String? _objectid;
  String? _transactionid;
  String? _orderid;
  String? _mercid;
  String? _transactionDate;
  String? _amount;
  String? _surcharge;
  String? _discount;
  String? _chargeAmount;
  String? _currency;
  AdditionalInfo? _additionalInfo;
  String? _ru;
  String? _txnProcessType;
  String? _bankid;
  String? _itemcode;
  String? _bankRefNo;
  String? _authStatus;
  String? _transactionErrorCode;
  String? _transactionErrorDesc;
  String? _transactionErrorType;
  String? _paymentMethodType;
  String? _paymentCategory;
PaymentStatusModel copyWith({  String? objectid,
  String? transactionid,
  String? orderid,
  String? mercid,
  String? transactionDate,
  String? amount,
  String? surcharge,
  String? discount,
  String? chargeAmount,
  String? currency,
  AdditionalInfo? additionalInfo,
  String? ru,
  String? txnProcessType,
  String? bankid,
  String? itemcode,
  String? bankRefNo,
  String? authStatus,
  String? transactionErrorCode,
  String? transactionErrorDesc,
  String? transactionErrorType,
  String? paymentMethodType,
  String? paymentCategory,
}) => PaymentStatusModel(  objectid: objectid ?? _objectid,
  transactionid: transactionid ?? _transactionid,
  orderid: orderid ?? _orderid,
  mercid: mercid ?? _mercid,
  transactionDate: transactionDate ?? _transactionDate,
  amount: amount ?? _amount,
  surcharge: surcharge ?? _surcharge,
  discount: discount ?? _discount,
  chargeAmount: chargeAmount ?? _chargeAmount,
  currency: currency ?? _currency,
  additionalInfo: additionalInfo ?? _additionalInfo,
  ru: ru ?? _ru,
  txnProcessType: txnProcessType ?? _txnProcessType,
  bankid: bankid ?? _bankid,
  itemcode: itemcode ?? _itemcode,
  bankRefNo: bankRefNo ?? _bankRefNo,
  authStatus: authStatus ?? _authStatus,
  transactionErrorCode: transactionErrorCode ?? _transactionErrorCode,
  transactionErrorDesc: transactionErrorDesc ?? _transactionErrorDesc,
  transactionErrorType: transactionErrorType ?? _transactionErrorType,
  paymentMethodType: paymentMethodType ?? _paymentMethodType,
  paymentCategory: paymentCategory ?? _paymentCategory,
);
  String? get objectid => _objectid;
  String? get transactionid => _transactionid;
  String? get orderid => _orderid;
  String? get mercid => _mercid;
  String? get transactionDate => _transactionDate;
  String? get amount => _amount;
  String? get surcharge => _surcharge;
  String? get discount => _discount;
  String? get chargeAmount => _chargeAmount;
  String? get currency => _currency;
  AdditionalInfo? get additionalInfo => _additionalInfo;
  String? get ru => _ru;
  String? get txnProcessType => _txnProcessType;
  String? get bankid => _bankid;
  String? get itemcode => _itemcode;
  String? get bankRefNo => _bankRefNo;
  String? get authStatus => _authStatus;
  String? get transactionErrorCode => _transactionErrorCode;
  String? get transactionErrorDesc => _transactionErrorDesc;
  String? get transactionErrorType => _transactionErrorType;
  String? get paymentMethodType => _paymentMethodType;
  String? get paymentCategory => _paymentCategory;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['objectid'] = _objectid;
    map['transactionid'] = _transactionid;
    map['orderid'] = _orderid;
    map['mercid'] = _mercid;
    map['transaction_date'] = _transactionDate;
    map['amount'] = _amount;
    map['surcharge'] = _surcharge;
    map['discount'] = _discount;
    map['charge_amount'] = _chargeAmount;
    map['currency'] = _currency;
    if (_additionalInfo != null) {
      map['additional_info'] = _additionalInfo?.toJson();
    }
    map['ru'] = _ru;
    map['txn_process_type'] = _txnProcessType;
    map['bankid'] = _bankid;
    map['itemcode'] = _itemcode;
    map['bank_ref_no'] = _bankRefNo;
    map['auth_status'] = _authStatus;
    map['transaction_error_code'] = _transactionErrorCode;
    map['transaction_error_desc'] = _transactionErrorDesc;
    map['transaction_error_type'] = _transactionErrorType;
    map['payment_method_type'] = _paymentMethodType;
    map['payment_category'] = _paymentCategory;
    return map;
  }

}

/// additional_info1 : "Details1"
/// additional_info2 : "Details2"

class AdditionalInfo {
  AdditionalInfo({
      String? additionalInfo1, 
      String? additionalInfo2,}){
    _additionalInfo1 = additionalInfo1;
    _additionalInfo2 = additionalInfo2;
}

  AdditionalInfo.fromJson(dynamic json) {
    _additionalInfo1 = json['additional_info1'];
    _additionalInfo2 = json['additional_info2'];
  }
  String? _additionalInfo1;
  String? _additionalInfo2;
AdditionalInfo copyWith({  String? additionalInfo1,
  String? additionalInfo2,
}) => AdditionalInfo(  additionalInfo1: additionalInfo1 ?? _additionalInfo1,
  additionalInfo2: additionalInfo2 ?? _additionalInfo2,
);
  String? get additionalInfo1 => _additionalInfo1;
  String? get additionalInfo2 => _additionalInfo2;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['additional_info1'] = _additionalInfo1;
    map['additional_info2'] = _additionalInfo2;
    return map;
  }

}