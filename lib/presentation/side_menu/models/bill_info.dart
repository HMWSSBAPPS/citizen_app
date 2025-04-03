// m_Item1 : {"ResponseCode":"200","ResponseType":"Success","Description":""}
// m_Item2 : {"Can":"620557270","ConsumerName":"SAYAKONDA ANJAMMA","BillNo":138171124,"BillDate":"2023-04-07T00:00:00","FromMonth":"202303","ToMonth":"202303","FwsNetPayableAmount":0.0,"RebateAmount":0.0,"Arrears":242.53,"Total":242.50,"PayableTotal":495.03,"DueDate":"2023-04-21T00:00:00","PDFlink":"https://test3.hyderabadwater.gov.in/DownloadBills/042023/620557270.pdf"}

class BillInfo {
  BillInfo({
      MItem1? mItem1, 
      MItem2? mItem2,}){
    _mItem1 = mItem1;
    _mItem2 = mItem2;
}

  BillInfo.fromJson(dynamic json) {
    _mItem1 = json['m_Item1'] != null ? MItem1.fromJson(json['m_Item1']) : null;
    _mItem2 = json['m_Item2'] != null ? MItem2.fromJson(json['m_Item2']) : null;
  }
  MItem1? _mItem1;
  MItem2? _mItem2;
BillInfo copyWith({  MItem1? mItem1,
  MItem2? mItem2,
}) => BillInfo(  mItem1: mItem1 ?? _mItem1,
  mItem2: mItem2 ?? _mItem2,
);
  MItem1? get mItem1 => _mItem1;
  MItem2? get mItem2 => _mItem2;

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

/// Can : "620557270"
/// ConsumerName : "SAYAKONDA ANJAMMA"
/// BillNo : 138171124
/// BillDate : "2023-04-07T00:00:00"
/// FromMonth : "202303"
/// ToMonth : "202303"
/// FwsNetPayableAmount : 0.0
/// RebateAmount : 0.0
/// Arrears : 242.53
/// Total : 242.50
/// PayableTotal : 495.03
/// DueDate : "2023-04-21T00:00:00"
/// PDFlink : "https://test3.hyderabadwater.gov.in/DownloadBills/042023/620557270.pdf"

class MItem2 {
  MItem2({
      String? can, 
      String? consumerName, 
      num? billNo, 
      String? billDate, 
      String? fromMonth, 
      String? toMonth, 
      num? fwsNetPayableAmount, 
      num? rebateAmount, 
      num? arrears, 
      num? total, 
      num? payableTotal, 
      String? dueDate, 
      String? pDFlink,}){
    _can = can;
    _consumerName = consumerName;
    _billNo = billNo;
    _billDate = billDate;
    _fromMonth = fromMonth;
    _toMonth = toMonth;
    _fwsNetPayableAmount = fwsNetPayableAmount;
    _rebateAmount = rebateAmount;
    _arrears = arrears;
    _total = total;
    _payableTotal = payableTotal;
    _dueDate = dueDate;
    _pDFlink = pDFlink;
}

  MItem2.fromJson(dynamic json) {
    _can = json['Can'];
    _consumerName = json['ConsumerName'];
    _billNo = json['BillNo'];
    _billDate = json['BillDate'];
    _fromMonth = json['FromMonth'];
    _toMonth = json['ToMonth'];
    _fwsNetPayableAmount = json['FwsNetPayableAmount'];
    _rebateAmount = json['RebateAmount'];
    _arrears = json['Arrears'];
    _total = json['Total'];
    _payableTotal = json['PayableTotal'];
    _dueDate = json['DueDate'];
    _pDFlink = json['PDFlink'];
  }
  String? _can;
  String? _consumerName;
  num? _billNo;
  String? _billDate;
  String? _fromMonth;
  String? _toMonth;
  num? _fwsNetPayableAmount;
  num? _rebateAmount;
  num? _arrears;
  num? _total;
  num? _payableTotal;
  String? _dueDate;
  String? _pDFlink;
MItem2 copyWith({  String? can,
  String? consumerName,
  num? billNo,
  String? billDate,
  String? fromMonth,
  String? toMonth,
  num? fwsNetPayableAmount,
  num? rebateAmount,
  num? arrears,
  num? total,
  num? payableTotal,
  String? dueDate,
  String? pDFlink,
}) => MItem2(  can: can ?? _can,
  consumerName: consumerName ?? _consumerName,
  billNo: billNo ?? _billNo,
  billDate: billDate ?? _billDate,
  fromMonth: fromMonth ?? _fromMonth,
  toMonth: toMonth ?? _toMonth,
  fwsNetPayableAmount: fwsNetPayableAmount ?? _fwsNetPayableAmount,
  rebateAmount: rebateAmount ?? _rebateAmount,
  arrears: arrears ?? _arrears,
  total: total ?? _total,
  payableTotal: payableTotal ?? _payableTotal,
  dueDate: dueDate ?? _dueDate,
  pDFlink: pDFlink ?? _pDFlink,
);
  String? get can => _can;
  String? get consumerName => _consumerName;
  num? get billNo => _billNo;
  String? get billDate => _billDate;
  String? get fromMonth => _fromMonth;
  String? get toMonth => _toMonth;
  num? get fwsNetPayableAmount => _fwsNetPayableAmount;
  num? get rebateAmount => _rebateAmount;
  num? get arrears => _arrears;
  num? get total => _total;
  num? get payableTotal => _payableTotal;
  String? get dueDate => _dueDate;
  String? get pDFlink => _pDFlink;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Can'] = _can;
    map['ConsumerName'] = _consumerName;
    map['BillNo'] = _billNo;
    map['BillDate'] = _billDate;
    map['FromMonth'] = _fromMonth;
    map['ToMonth'] = _toMonth;
    map['FwsNetPayableAmount'] = _fwsNetPayableAmount;
    map['RebateAmount'] = _rebateAmount;
    map['Arrears'] = _arrears;
    map['Total'] = _total;
    map['PayableTotal'] = _payableTotal;
    map['DueDate'] = _dueDate;
    map['PDFlink'] = _pDFlink;
    return map;
  }

}

/// ResponseCode : "200"
/// ResponseType : "Success"
/// Description : ""

class MItem1 {
  MItem1({
      String? responseCode, 
      String? responseType, 
      String? description,}){
    _responseCode = responseCode;
    _responseType = responseType;
    _description = description;
}

  MItem1.fromJson(dynamic json) {
    _responseCode = json['ResponseCode'];
    _responseType = json['ResponseType'];
    _description = json['Description'];
  }
  String? _responseCode;
  String? _responseType;
  String? _description;
MItem1 copyWith({  String? responseCode,
  String? responseType,
  String? description,
}) => MItem1(  responseCode: responseCode ?? _responseCode,
  responseType: responseType ?? _responseType,
  description: description ?? _description,
);
  String? get responseCode => _responseCode;
  String? get responseType => _responseType;
  String? get description => _description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ResponseCode'] = _responseCode;
    map['ResponseType'] = _responseType;
    map['Description'] = _description;
    return map;
  }

}