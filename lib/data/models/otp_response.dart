// m_Item1 : {"ResponseCode":"200","ResponseType":"OTP","Description":"OTP is :626188"}
// m_Item2 : "626188"

class OtpResponse {
  OtpResponse({
    MItem1? mItem1,
    String? mItem2,
    // z,
  }) {
    _mItem1 = mItem1;
    _mItem2 = mItem2;
  }

  OtpResponse.fromJson(dynamic json) {
    _mItem1 = json['m_Item1'] != null ? MItem1.fromJson(json['m_Item1']) : null;
    _mItem2 = json['m_Item2'];
  }
  MItem1? _mItem1;
  String? _mItem2;
  OtpResponse copyWith({
    MItem1? mItem1,
    String? mItem2,
  }) =>
      OtpResponse(
        mItem1: mItem1 ?? _mItem1,
        mItem2: mItem2 ?? _mItem2,
      );
  MItem1? get mItem1 => _mItem1;
  String? get mItem2 => _mItem2;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_mItem1 != null) {
      map['m_Item1'] = _mItem1?.toJson();
    }
    map['m_Item2'] = _mItem2;
    return map;
  }
}

/// ResponseCode : "200"
/// ResponseType : "OTP"
/// Description : "OTP is :626188"

class MItem1 {
  MItem1({
    String? responseCode,
    String? responseType,
    String? description,
  }) {
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
  MItem1 copyWith({
    String? responseCode,
    String? responseType,
    String? description,
  }) =>
      MItem1(
        responseCode: responseCode ?? _responseCode,
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
