// m_Item1 : {"objectid":"transaction","transactionid":"UHDF0000945719","orderid":"HMW20240607063641385","mercid":"BDUATV2APT","transaction_date":"2024-06-07T12:08:19+05:30","amount":"222.00","surcharge":"4.00","discount":"0.00","charge_amount":"224.00","currency":"356","ru":"https://merchant.com/payment/process","txn_process_type":"nb","bankid":"HDF","itemcode":"DIRECT","bank_ref_no":"BILLDESK12","auth_status":"0300","transaction_error_code":"TRS0000","transaction_error_desc":"Transaction Successful","transaction_error_type":"success","payment_method_type":"netbanking","payment_category":"01"}
// m_Item2 : {"receiptPdfLink":"https://test3.hyderabadwater.gov.in/DownloadBills/BillDeskPaymentReceiptPDFs/011103088.pdf"}

class PaymentStatus {
  PaymentStatus({
      MItem1? mItem1, 
      MItem3? mItem2,}){
    _mItem1 = mItem1;
    _mItem2 = mItem2;
}

  PaymentStatus.fromJson(dynamic json) {
    _mItem1 = json['m_Item1'] != null ? MItem1.fromJson(json['m_Item1']) : null;
    _mItem2 = json['m_Item2'] != null ? MItem3.fromJson(json['m_Item2']) : null;
  }
  MItem1? _mItem1;
  MItem3? _mItem2;
PaymentStatus copyWith({  MItem1? mItem1,
  MItem3? mItem2,
}) => PaymentStatus(  mItem1: mItem1 ?? _mItem1,
  mItem2: mItem2 ?? _mItem2,
);
  MItem1? get mItem1 => _mItem1;
  MItem3? get mItem2 => _mItem2;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_mItem1 != null) {
      map['m_Item1'] = _mItem1?.toJson();
    }
    if (_mItem2 != null) {
      map['m_Item2'] = _mItem2?.toJson();
    }
    return map;
  }

}

/// receiptPdfLink : "https://test3.hyderabadwater.gov.in/DownloadBills/BillDeskPaymentReceiptPDFs/011103088.pdf"

class MItem3 {
  MItem3({
      String? receiptPdfLink,}){
    _receiptPdfLink = receiptPdfLink;
}

  MItem3.fromJson(dynamic json) {
    _receiptPdfLink = json['receiptPdfLink'];
  }
  String? _receiptPdfLink;
MItem3 copyWith({  String? receiptPdfLink,
}) => MItem3(  receiptPdfLink: receiptPdfLink ?? _receiptPdfLink,
);
  String? get receiptPdfLink => _receiptPdfLink;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['receiptPdfLink'] = _receiptPdfLink;
    return map;
  }

}

/// objectid : "transaction"
/// transactionid : "UHDF0000945719"
/// orderid : "HMW20240607063641385"
/// mercid : "BDUATV2APT"
/// transaction_date : "2024-06-07T12:08:19+05:30"
/// amount : "222.00"
/// surcharge : "4.00"
/// discount : "0.00"
/// charge_amount : "224.00"
/// currency : "356"
/// ru : "https://merchant.com/payment/process"
/// txn_process_type : "nb"
/// bankid : "HDF"
/// itemcode : "DIRECT"
/// bank_ref_no : "BILLDESK12"
/// auth_status : "0300"
/// transaction_error_code : "TRS0000"
/// transaction_error_desc : "Transaction Successful"
/// transaction_error_type : "success"
/// payment_method_type : "netbanking"
/// payment_category : "01"

class MItem1 {
  MItem1({
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

  MItem1.fromJson(dynamic json) {
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
MItem1 copyWith({  String? objectid,
  String? transactionid,
  String? orderid,
  String? mercid,
  String? transactionDate,
  String? amount,
  String? surcharge,
  String? discount,
  String? chargeAmount,
  String? currency,
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
}) => MItem1(  objectid: objectid ?? _objectid,
  transactionid: transactionid ?? _transactionid,
  orderid: orderid ?? _orderid,
  mercid: mercid ?? _mercid,
  transactionDate: transactionDate ?? _transactionDate,
  amount: amount ?? _amount,
  surcharge: surcharge ?? _surcharge,
  discount: discount ?? _discount,
  chargeAmount: chargeAmount ?? _chargeAmount,
  currency: currency ?? _currency,
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