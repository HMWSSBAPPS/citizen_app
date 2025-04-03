// m_Item1 : {"ResponseCode":"200","ResponseType":"Success","Description":"47Complaints Found"}
// m_Item2 : [{"ComplaintTypeCode":1,"ComplaintTypeName":"Water Supply","ComplaintReasonCode":1,"ComplaintReasonName":"WATER LEAKAGE"},{"ComplaintTypeCode":1,"ComplaintTypeName":"Water Supply","ComplaintReasonCode":6,"ComplaintReasonName":"NO WATER FOR X DAYS"},{"ComplaintTypeCode":1,"ComplaintTypeName":"Water Supply","ComplaintReasonCode":8,"ComplaintReasonName":"LOW WATER PRESSURE"},{"ComplaintTypeCode":1,"ComplaintTypeName":"Water Supply","ComplaintReasonCode":13,"ComplaintReasonName":"POLLUTED WATER SUPPLY"},{"ComplaintTypeCode":1,"ComplaintTypeName":"Water Supply","ComplaintReasonCode":14,"ComplaintReasonName":"ILLEGAL USING OF MOTOR"},{"ComplaintTypeCode":1,"ComplaintTypeName":"Water Supply","ComplaintReasonCode":17,"ComplaintReasonName":"ERRATIC TIMING OF WATER SUPPLY"},{"ComplaintTypeCode":1,"ComplaintTypeName":"Water Supply","ComplaintReasonCode":24,"ComplaintReasonName":"CHANGE OF CATEGORY OF CONSUMPTION"},{"ComplaintTypeCode":1,"ComplaintTypeName":"Water Supply","ComplaintReasonCode":26,"ComplaintReasonName":"MISSING WATER MANHOLE COVER"},{"ComplaintTypeCode":1,"ComplaintTypeName":"Water Supply","ComplaintReasonCode":53,"ComplaintReasonName":"PIPE LEAKAGE"},{"ComplaintTypeCode":1,"ComplaintTypeName":"Water Supply","ComplaintReasonCode":54,"ComplaintReasonName":"VALVE LEAKAGE"},{"ComplaintTypeCode":1,"ComplaintTypeName":"Water Supply","ComplaintReasonCode":55,"ComplaintReasonName":"ILLEGAL WATER CONNECTION"},{"ComplaintTypeCode":2,"ComplaintTypeName":"Sewerage","ComplaintReasonCode":4,"ComplaintReasonName":"REPLACEMENT OF MISSING MANHOLE COVER"},{"ComplaintTypeCode":2,"ComplaintTypeName":"Sewerage","ComplaintReasonCode":7,"ComplaintReasonName":"SEWERAGE OVERFLOWS-ON THE ROAD"},{"ComplaintTypeCode":2,"ComplaintTypeName":"Sewerage","ComplaintReasonCode":21,"ComplaintReasonName":"CHOKAGE CUSTOMER PREMISES"},{"ComplaintTypeCode":2,"ComplaintTypeName":"Sewerage","ComplaintReasonCode":27,"ComplaintReasonName":"SILT ON THE ROAD"},{"ComplaintTypeCode":2,"ComplaintTypeName":"Sewerage","ComplaintReasonCode":56,"ComplaintReasonName":"DAMAGED/REPAIR/RAISING OF MANHOLE COVER"},{"ComplaintTypeCode":3,"ComplaintTypeName":"Meter","ComplaintReasonCode":22,"ComplaintReasonName":"METER REPAIRS AND REPLACEMENTS DOMESTIC"},{"ComplaintTypeCode":4,"ComplaintTypeName":"Billing","ComplaintReasonCode":11,"ComplaintReasonName":"NON-RECEIPT OF WATER BILL"},{"ComplaintTypeCode":4,"ComplaintTypeName":"Billing","ComplaintReasonCode":12,"ComplaintReasonName":"EXCESS BILL AND VERIFICATION"},{"ComplaintTypeCode":4,"ComplaintTypeName":"Billing","ComplaintReasonCode":20,"ComplaintReasonName":"OTHERS"},{"ComplaintTypeCode":4,"ComplaintTypeName":"Billing","ComplaintReasonCode":28,"ComplaintReasonName":"METER READING DISPUTE"},{"ComplaintTypeCode":4,"ComplaintTypeName":"Billing","ComplaintReasonCode":29,"ComplaintReasonName":"NON-POSTING OF PAYMENTS"},{"ComplaintTypeCode":4,"ComplaintTypeName":"Billing","ComplaintReasonCode":30,"ComplaintReasonName":"POSTING OF PAYMENTS IN WRONG ACCOUNT"},{"ComplaintTypeCode":4,"ComplaintTypeName":"Billing","ComplaintReasonCode":32,"ComplaintReasonName":"DISPUTE OVER SEWERAGE CESS"},{"ComplaintTypeCode":4,"ComplaintTypeName":"Billing","ComplaintReasonCode":33,"ComplaintReasonName":"NON-COMPLIANCE OF ONE TIME SETTLEMENT"},{"ComplaintTypeCode":4,"ComplaintTypeName":"Billing","ComplaintReasonCode":34,"ComplaintReasonName":"DISPUTE OVER CATEGORY CLASSIFICATION"},{"ComplaintTypeCode":4,"ComplaintTypeName":"Billing","ComplaintReasonCode":35,"ComplaintReasonName":"PROTEST AGAINST THE CUSTOMER ACCOUNT NO.S"},{"ComplaintTypeCode":4,"ComplaintTypeName":"Billing","ComplaintReasonCode":36,"ComplaintReasonName":"NAME CHANGE"},{"ComplaintTypeCode":4,"ComplaintTypeName":"Billing","ComplaintReasonCode":37,"ComplaintReasonName":"CORRECTION OF NAME"},{"ComplaintTypeCode":4,"ComplaintTypeName":"Billing","ComplaintReasonCode":38,"ComplaintReasonName":"CORRECTION OF HOUSE NO"},{"ComplaintTypeCode":4,"ComplaintTypeName":"Billing","ComplaintReasonCode":39,"ComplaintReasonName":"NON-ISSUE OF BILLS"},{"ComplaintTypeCode":4,"ComplaintTypeName":"Billing","ComplaintReasonCode":40,"ComplaintReasonName":"REQUEST FOR DISCONNECTION OF WATER SUPPLY"},{"ComplaintTypeCode":4,"ComplaintTypeName":"Billing","ComplaintReasonCode":41,"ComplaintReasonName":"SERVICE ALREADY DC,GETTING REGULAR BILLS"},{"ComplaintTypeCode":4,"ComplaintTypeName":"Billing","ComplaintReasonCode":42,"ComplaintReasonName":"REQUEST FOR THE RECONNECTION OF WATER SUPPLY"},{"ComplaintTypeCode":4,"ComplaintTypeName":"Billing","ComplaintReasonCode":43,"ComplaintReasonName":"SETTLEMENTS OF OVER DUES"},{"ComplaintTypeCode":4,"ComplaintTypeName":"Billing","ComplaintReasonCode":44,"ComplaintReasonName":"ENHANCEMENT OF CONNECTIONS (GETTING TWO BILLS)"},{"ComplaintTypeCode":4,"ComplaintTypeName":"Billing","ComplaintReasonCode":49,"ComplaintReasonName":"NON-ISSUE OF METERED BILL"},{"ComplaintTypeCode":5,"ComplaintTypeName":"Request Services","ComplaintReasonCode":52,"ComplaintReasonName":"RAIN WATER HARVESTING"},{"ComplaintTypeCode":6,"ComplaintTypeName":"Others","ComplaintReasonCode":2,"ComplaintReasonName":"BOREWELL REPAIRS"},{"ComplaintTypeCode":6,"ComplaintTypeName":"Others","ComplaintReasonCode":15,"ComplaintReasonName":"CHANGING OF LINE REQUESTED"},{"ComplaintTypeCode":6,"ComplaintTypeName":"Others","ComplaintReasonCode":45,"ComplaintReasonName":"SWC NEW CONNECTION RELATED"},{"ComplaintTypeCode":6,"ComplaintTypeName":"Others","ComplaintReasonCode":47,"ComplaintReasonName":"TANKER DELIVERY COMPLAINT"},{"ComplaintTypeCode":6,"ComplaintTypeName":"Others","ComplaintReasonCode":48,"ComplaintReasonName":"MISCELLANEOUS"},{"ComplaintTypeCode":6,"ComplaintTypeName":"Others","ComplaintReasonCode":58,"ComplaintReasonName":"WORK SITE SAFETY LAPSES"},{"ComplaintTypeCode":7,"ComplaintTypeName":"QAT","ComplaintReasonCode":31,"ComplaintReasonName":"ABSENSE OF RESIDUAL CHLORINE"},{"ComplaintTypeCode":8,"ComplaintTypeName":"AMR Meter","ComplaintReasonCode":50,"ComplaintReasonName":"ABNORMAL METER READING"},{"ComplaintTypeCode":8,"ComplaintTypeName":"AMR Meter","ComplaintReasonCode":51,"ComplaintReasonName":"NON-WORKING OF METER"}]

class ComplaintsMaster {
  ComplaintsMaster({
      MItem1? mItem1, 
      List<MItem2>? mItem2,}){
    _mItem1 = mItem1;
    _mItem2 = mItem2;
}

  ComplaintsMaster.fromJson(dynamic json) {
    _mItem1 = json['m_Item1'] != null ? MItem1.fromJson(json['m_Item1']) : null;
    if (json['m_Item2'] != null) {
      _mItem2 = [];
      json['m_Item2'].forEach((v) {
        _mItem2?.add(MItem2.fromJson(v));
      });
    }
  }
  MItem1? _mItem1;
  List<MItem2>? _mItem2;
ComplaintsMaster copyWith({  MItem1? mItem1,
  List<MItem2>? mItem2,
}) => ComplaintsMaster(  mItem1: mItem1 ?? _mItem1,
  mItem2: mItem2 ?? _mItem2,
);
  MItem1? get mItem1 => _mItem1;
  List<MItem2>? get mItem2 => _mItem2;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_mItem1 != null) {
      map['m_Item1'] = _mItem1?.toJson();
    }
    if (_mItem2 != null) {
      map['m_Item2'] = _mItem2?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// ComplaintTypeCode : 1
/// ComplaintTypeName : "Water Supply"
/// ComplaintReasonCode : 1
/// ComplaintReasonName : "WATER LEAKAGE"

class MItem2 {
  MItem2({
      num? complaintTypeCode, 
      String? complaintTypeName, 
      num? complaintReasonCode, 
      String? complaintReasonName,}){
    _complaintTypeCode = complaintTypeCode;
    _complaintTypeName = complaintTypeName;
    _complaintReasonCode = complaintReasonCode;
    _complaintReasonName = complaintReasonName;
}

  MItem2.fromJson(dynamic json) {
    _complaintTypeCode = json['ComplaintTypeCode'];
    _complaintTypeName = json['ComplaintTypeName'];
    _complaintReasonCode = json['ComplaintReasonCode'];
    _complaintReasonName = json['ComplaintReasonName'];
  }
  num? _complaintTypeCode;
  String? _complaintTypeName;
  num? _complaintReasonCode;
  String? _complaintReasonName;
MItem2 copyWith({  num? complaintTypeCode,
  String? complaintTypeName,
  num? complaintReasonCode,
  String? complaintReasonName,
}) => MItem2(  complaintTypeCode: complaintTypeCode ?? _complaintTypeCode,
  complaintTypeName: complaintTypeName ?? _complaintTypeName,
  complaintReasonCode: complaintReasonCode ?? _complaintReasonCode,
  complaintReasonName: complaintReasonName ?? _complaintReasonName,
);
  num? get complaintTypeCode => _complaintTypeCode;
  String? get complaintTypeName => _complaintTypeName;
  num? get complaintReasonCode => _complaintReasonCode;
  String? get complaintReasonName => _complaintReasonName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ComplaintTypeCode'] = _complaintTypeCode;
    map['ComplaintTypeName'] = _complaintTypeName;
    map['ComplaintReasonCode'] = _complaintReasonCode;
    map['ComplaintReasonName'] = _complaintReasonName;
    return map;
  }

}

/// ResponseCode : "200"
/// ResponseType : "Success"
/// Description : "47Complaints Found"

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