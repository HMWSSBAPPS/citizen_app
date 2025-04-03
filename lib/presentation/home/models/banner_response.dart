// m_Item1 : {"ResponseCode":"200","ResponseType":"Success","Description":"Details Fetched Sucessfully"}
// m_Item2 : [{"Pkey":1,"Image":"https://test3.hyderabadwater.gov.in/DownloadBills/BANNERIMAGES/Desert.jpg","Url":"https://erp.hyderabadwater.gov.in/HMWSSBONLINENEW/#/HmwssbSwcApplication"},{"Pkey":2,"Image":"https://test3.hyderabadwater.gov.in/DownloadBills/BANNERIMAGES/Hydrangeas.jpg","Url":"https://erp.hyderabadwater.gov.in/HMWSSBONLINENEW/#/Hmwssbswcuploaddocuments"}]

class BannerResponse {
  BannerResponse({
      MItem1? mItem1, 
      List<MItem>? mItem2,}){
    _mItem1 = mItem1;
    _mItem2 = mItem2;
}

  BannerResponse.fromJson(dynamic json) {
    _mItem1 = json['m_Item1'] != null ? MItem1.fromJson(json['m_Item1']) : null;
    if (json['m_Item2'] != null) {
      _mItem2 = [];
      json['m_Item2'].forEach((v) {
        _mItem2?.add(MItem.fromJson(v));
      });
    }
  }
  MItem1? _mItem1;
  List<MItem>? _mItem2;
BannerResponse copyWith({  MItem1? mItem1,
  List<MItem>? mItem2,
}) => BannerResponse(  mItem1: mItem1 ?? _mItem1,
  mItem2: mItem2 ?? _mItem2,
);
  MItem1? get mItem1 => _mItem1;
  List<MItem>? get mItem2 => _mItem2;

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

/// Pkey : 1
/// Image : "https://test3.hyderabadwater.gov.in/DownloadBills/BANNERIMAGES/Desert.jpg"
/// Url : "https://erp.hyderabadwater.gov.in/HMWSSBONLINENEW/#/HmwssbSwcApplication"

class MItem {
  MItem({
      num? pkey, 
      String? image, 
      String? url,}){
    _pkey = pkey;
    _image = image;
    _url = url;
}

  MItem.fromJson(dynamic json) {
    _pkey = json['Pkey'];
    _image = json['Image'];
    _url = json['Url'];
  }
  num? _pkey;
  String? _image;
  String? _url;
MItem copyWith({  num? pkey,
  String? image,
  String? url,
}) => MItem(  pkey: pkey ?? _pkey,
  image: image ?? _image,
  url: url ?? _url,
);
  num? get pkey => _pkey;
  String? get image => _image;
  String? get url => _url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Pkey'] = _pkey;
    map['Image'] = _image;
    map['Url'] = _url;
    return map;
  }

}

/// ResponseCode : "200"
/// ResponseType : "Success"
/// Description : "Details Fetched Sucessfully"

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