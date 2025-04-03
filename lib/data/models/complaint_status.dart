// m_Item1 : {"ResponseCode":"200","ResponseType":"Success","Description":"Grievance Information Found"}
// m_Item2 : [{"CAN":"061307890","ComplaintNumber":"2492","ComplStatus":"Pending","ComplaintReason":"DIAL-A-TANKER","RecievedDate":"4/6/2024 4:34 PM","ContactNo":"9866787069"}]

class ComplaintStatus {
  ComplaintStatus({
      MItem1? mItem1, 
      List<MItem2>? mItem2,}){
    _mItem1 = mItem1;
    _mItem2 = mItem2;
}

  ComplaintStatus.fromJson(dynamic json) {
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
ComplaintStatus copyWith({  MItem1? mItem1,
  List<MItem2>? mItem2,
}) => ComplaintStatus(  mItem1: mItem1 ?? _mItem1,
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

/// CAN : "061307890"
/// ComplaintNumber : "2492"
/// ComplStatus : "Pending"
/// ComplaintReason : "DIAL-A-TANKER"
/// RecievedDate : "4/6/2024 4:34 PM"
/// ContactNo : "9866787069"

class MItem2 {
  MItem2({
      String? can, 
      String? complaintNumber, 
      String? complStatus, 
      String? complaintReason, 
      String? recievedDate, 
      String? contactNo,}){
    _can = can;
    _complaintNumber = complaintNumber;
    _complStatus = complStatus;
    _complaintReason = complaintReason;
    _recievedDate = recievedDate;
    _contactNo = contactNo;
}

  MItem2.fromJson(dynamic json) {
    _can = json['CAN'];
    _complaintNumber = json['ComplaintNumber'];
    _complStatus = json['ComplStatus'];
    _complaintReason = json['ComplaintReason'];
    _recievedDate = json['RecievedDate'];
    _contactNo = json['ContactNo'];
  }
  String? _can;
  String? _complaintNumber;
  String? _complStatus;
  String? _complaintReason;
  String? _recievedDate;
  String? _contactNo;
MItem2 copyWith({  String? can,
  String? complaintNumber,
  String? complStatus,
  String? complaintReason,
  String? recievedDate,
  String? contactNo,
}) => MItem2(  can: can ?? _can,
  complaintNumber: complaintNumber ?? _complaintNumber,
  complStatus: complStatus ?? _complStatus,
  complaintReason: complaintReason ?? _complaintReason,
  recievedDate: recievedDate ?? _recievedDate,
  contactNo: contactNo ?? _contactNo,
);
  String? get can => _can;
  String? get complaintNumber => _complaintNumber;
  String? get complStatus => _complStatus;
  String? get complaintReason => _complaintReason;
  String? get recievedDate => _recievedDate;
  String? get contactNo => _contactNo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['CAN'] = _can;
    map['ComplaintNumber'] = _complaintNumber;
    map['ComplStatus'] = _complStatus;
    map['ComplaintReason'] = _complaintReason;
    map['RecievedDate'] = _recievedDate;
    map['ContactNo'] = _contactNo;
    return map;
  }

}

/// ResponseCode : "200"
/// ResponseType : "Success"
/// Description : "Grievance Information Found"

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