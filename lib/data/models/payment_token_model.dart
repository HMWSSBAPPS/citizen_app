// objectid : "order"
// orderid : "ORD20240521083839"
// bdorderid : "OAJP19XTT9IBI3"
// mercid : "BDUATV2APT"
// order_date : "2024-05-21T14:08:39+05:30"
// amount : "200"
// currency : "356"
// ru : "https://merchant.com/payment/process"
// additional_info : {"additional_info1":"Details1","additional_info2":"Details2","additional_info3":"NA","additional_info4":"NA","additional_info5":"NA","additional_info6":"NA","additional_info7":"NA","additional_info8":"NA","additional_info9":"NA","additional_info10":"NA"}
// itemcode : "DIRECT"
// createdon : "2024-05-21T14:08:42+05:30"
// next_step : "redirect"
// links : [{"href":"https://uat1.billdesk.com/u2/web/v1_2/embeddedsdk","rel":"redirect","method":"POST","parameters":{"mercid":"BDUATV2APT","bdorderid":"OAJP19XTT9IBI3","rdata":"e272886e28f0a81a87780f617004d7cca3582ce986441fd52f691b2f7370fcfc3713e99124554927a34cd458fa65521112d34b41cabc1554fc77babf7f4c40b526.7561746b657931"},"valid_date":"2024-05-21T14:38:42+05:30","headers":{"authorization":"OToken 91c4e8b8baafecda14d5b5362101e01c276eb4d46355a0d3a2c8954f2e3324f0c13953249835ef469b70137e22f1d60a25626b309c77a3cfb5f7e84337e673377d069a803c927d40c3905f0dba6d7e073d0de1656da949f1eba6ec7a496954ba5d136e0e85a06a8ddd19ddb47d8f72cd2b0f7193ab1c4b4918fa10d647761774cd4f9c4e66471c68638c4f18dffc7e519bfac3cd6f20ba658a18f2.4145535f55415431"}}]
// status : "ACTIVE"

class PaymentTokenModel {
  PaymentTokenModel({
      String? objectid, 
      String? orderid, 
      String? bdorderid, 
      String? mercid, 
      String? orderDate, 
      String? amount, 
      String? currency, 
      String? ru, 
      AdditionalInfo? additionalInfo, 
      String? itemcode, 
      String? createdon, 
      String? nextStep, 
      List<Links>? links, 
      String? status,}){
    _objectid = objectid;
    _orderid = orderid;
    _bdorderid = bdorderid;
    _mercid = mercid;
    _orderDate = orderDate;
    _amount = amount;
    _currency = currency;
    _ru = ru;
    _additionalInfo = additionalInfo;
    _itemcode = itemcode;
    _createdon = createdon;
    _nextStep = nextStep;
    _links = links;
    _status = status;
}

  PaymentTokenModel.fromJson(dynamic json) {
    _objectid = json['objectid'];
    _orderid = json['orderid'];
    _bdorderid = json['bdorderid'];
    _mercid = json['mercid'];
    _orderDate = json['order_date'];
    _amount = json['amount'];
    _currency = json['currency'];
    _ru = json['ru'];
    _additionalInfo = json['additional_info'] != null ? AdditionalInfo.fromJson(json['additional_info']) : null;
    _itemcode = json['itemcode'];
    _createdon = json['createdon'];
    _nextStep = json['next_step'];
    if (json['links'] != null) {
      _links = [];
      json['links'].forEach((v) {
        _links?.add(Links.fromJson(v));
      });
    }
    _status = json['status'];
  }
  String? _objectid;
  String? _orderid;
  String? _bdorderid;
  String? _mercid;
  String? _orderDate;
  String? _amount;
  String? _currency;
  String? _ru;
  AdditionalInfo? _additionalInfo;
  String? _itemcode;
  String? _createdon;
  String? _nextStep;
  List<Links>? _links;
  String? _status;
PaymentTokenModel copyWith({  String? objectid,
  String? orderid,
  String? bdorderid,
  String? mercid,
  String? orderDate,
  String? amount,
  String? currency,
  String? ru,
  AdditionalInfo? additionalInfo,
  String? itemcode,
  String? createdon,
  String? nextStep,
  List<Links>? links,
  String? status,
}) => PaymentTokenModel(  objectid: objectid ?? _objectid,
  orderid: orderid ?? _orderid,
  bdorderid: bdorderid ?? _bdorderid,
  mercid: mercid ?? _mercid,
  orderDate: orderDate ?? _orderDate,
  amount: amount ?? _amount,
  currency: currency ?? _currency,
  ru: ru ?? _ru,
  additionalInfo: additionalInfo ?? _additionalInfo,
  itemcode: itemcode ?? _itemcode,
  createdon: createdon ?? _createdon,
  nextStep: nextStep ?? _nextStep,
  links: links ?? _links,
  status: status ?? _status,
);
  String? get objectid => _objectid;
  String? get orderid => _orderid;
  String? get bdorderid => _bdorderid;
  String? get mercid => _mercid;
  String? get orderDate => _orderDate;
  String? get amount => _amount;
  String? get currency => _currency;
  String? get ru => _ru;
  AdditionalInfo? get additionalInfo => _additionalInfo;
  String? get itemcode => _itemcode;
  String? get createdon => _createdon;
  String? get nextStep => _nextStep;
  List<Links>? get links => _links;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['objectid'] = _objectid;
    map['orderid'] = _orderid;
    map['bdorderid'] = _bdorderid;
    map['mercid'] = _mercid;
    map['order_date'] = _orderDate;
    map['amount'] = _amount;
    map['currency'] = _currency;
    map['ru'] = _ru;
    if (_additionalInfo != null) {
      map['additional_info'] = _additionalInfo?.toJson();
    }
    map['itemcode'] = _itemcode;
    map['createdon'] = _createdon;
    map['next_step'] = _nextStep;
    if (_links != null) {
      map['links'] = _links?.map((v) => v.toJson()).toList();
    }
    map['status'] = _status;
    return map;
  }

}

/// href : "https://uat1.billdesk.com/u2/web/v1_2/embeddedsdk"
/// rel : "redirect"
/// method : "POST"
/// parameters : {"mercid":"BDUATV2APT","bdorderid":"OAJP19XTT9IBI3","rdata":"e272886e28f0a81a87780f617004d7cca3582ce986441fd52f691b2f7370fcfc3713e99124554927a34cd458fa65521112d34b41cabc1554fc77babf7f4c40b526.7561746b657931"}
/// valid_date : "2024-05-21T14:38:42+05:30"
/// headers : {"authorization":"OToken 91c4e8b8baafecda14d5b5362101e01c276eb4d46355a0d3a2c8954f2e3324f0c13953249835ef469b70137e22f1d60a25626b309c77a3cfb5f7e84337e673377d069a803c927d40c3905f0dba6d7e073d0de1656da949f1eba6ec7a496954ba5d136e0e85a06a8ddd19ddb47d8f72cd2b0f7193ab1c4b4918fa10d647761774cd4f9c4e66471c68638c4f18dffc7e519bfac3cd6f20ba658a18f2.4145535f55415431"}

class Links {
  Links({
      String? href, 
      String? rel, 
      String? method, 
      Parameters? parameters, 
      String? validDate, 
      Headers? headers,}){
    _href = href;
    _rel = rel;
    _method = method;
    _parameters = parameters;
    _validDate = validDate;
    _headers = headers;
}

  Links.fromJson(dynamic json) {
    _href = json['href'];
    _rel = json['rel'];
    _method = json['method'];
    _parameters = json['parameters'] != null ? Parameters.fromJson(json['parameters']) : null;
    _validDate = json['valid_date'];
    _headers = json['headers'] != null ? Headers.fromJson(json['headers']) : null;
  }
  String? _href;
  String? _rel;
  String? _method;
  Parameters? _parameters;
  String? _validDate;
  Headers? _headers;
Links copyWith({  String? href,
  String? rel,
  String? method,
  Parameters? parameters,
  String? validDate,
  Headers? headers,
}) => Links(  href: href ?? _href,
  rel: rel ?? _rel,
  method: method ?? _method,
  parameters: parameters ?? _parameters,
  validDate: validDate ?? _validDate,
  headers: headers ?? _headers,
);
  String? get href => _href;
  String? get rel => _rel;
  String? get method => _method;
  Parameters? get parameters => _parameters;
  String? get validDate => _validDate;
  Headers? get headers => _headers;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['href'] = _href;
    map['rel'] = _rel;
    map['method'] = _method;
    if (_parameters != null) {
      map['parameters'] = _parameters?.toJson();
    }
    map['valid_date'] = _validDate;
    if (_headers != null) {
      map['headers'] = _headers?.toJson();
    }
    return map;
  }

}

/// authorization : "OToken 91c4e8b8baafecda14d5b5362101e01c276eb4d46355a0d3a2c8954f2e3324f0c13953249835ef469b70137e22f1d60a25626b309c77a3cfb5f7e84337e673377d069a803c927d40c3905f0dba6d7e073d0de1656da949f1eba6ec7a496954ba5d136e0e85a06a8ddd19ddb47d8f72cd2b0f7193ab1c4b4918fa10d647761774cd4f9c4e66471c68638c4f18dffc7e519bfac3cd6f20ba658a18f2.4145535f55415431"

class Headers {
  Headers({
      String? authorization,}){
    _authorization = authorization;
}

  Headers.fromJson(dynamic json) {
    _authorization = json['authorization'];
  }
  String? _authorization;
Headers copyWith({  String? authorization,
}) => Headers(  authorization: authorization ?? _authorization,
);
  String? get authorization => _authorization;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['authorization'] = _authorization;
    return map;
  }

}

/// mercid : "BDUATV2APT"
/// bdorderid : "OAJP19XTT9IBI3"
/// rdata : "e272886e28f0a81a87780f617004d7cca3582ce986441fd52f691b2f7370fcfc3713e99124554927a34cd458fa65521112d34b41cabc1554fc77babf7f4c40b526.7561746b657931"

class Parameters {
  Parameters({
      String? mercid, 
      String? bdorderid, 
      String? rdata,}){
    _mercid = mercid;
    _bdorderid = bdorderid;
    _rdata = rdata;
}

  Parameters.fromJson(dynamic json) {
    _mercid = json['mercid'];
    _bdorderid = json['bdorderid'];
    _rdata = json['rdata'];
  }
  String? _mercid;
  String? _bdorderid;
  String? _rdata;
Parameters copyWith({  String? mercid,
  String? bdorderid,
  String? rdata,
}) => Parameters(  mercid: mercid ?? _mercid,
  bdorderid: bdorderid ?? _bdorderid,
  rdata: rdata ?? _rdata,
);
  String? get mercid => _mercid;
  String? get bdorderid => _bdorderid;
  String? get rdata => _rdata;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['mercid'] = _mercid;
    map['bdorderid'] = _bdorderid;
    map['rdata'] = _rdata;
    return map;
  }

}

/// additional_info1 : "Details1"
/// additional_info2 : "Details2"
/// additional_info3 : "NA"
/// additional_info4 : "NA"
/// additional_info5 : "NA"
/// additional_info6 : "NA"
/// additional_info7 : "NA"
/// additional_info8 : "NA"
/// additional_info9 : "NA"
/// additional_info10 : "NA"

class AdditionalInfo {
  AdditionalInfo({
      String? additionalInfo1, 
      String? additionalInfo2, 
      String? additionalInfo3, 
      String? additionalInfo4, 
      String? additionalInfo5, 
      String? additionalInfo6, 
      String? additionalInfo7, 
      String? additionalInfo8, 
      String? additionalInfo9, 
      String? additionalInfo10,}){
    _additionalInfo1 = additionalInfo1;
    _additionalInfo2 = additionalInfo2;
    _additionalInfo3 = additionalInfo3;
    _additionalInfo4 = additionalInfo4;
    _additionalInfo5 = additionalInfo5;
    _additionalInfo6 = additionalInfo6;
    _additionalInfo7 = additionalInfo7;
    _additionalInfo8 = additionalInfo8;
    _additionalInfo9 = additionalInfo9;
    _additionalInfo10 = additionalInfo10;
}

  AdditionalInfo.fromJson(dynamic json) {
    _additionalInfo1 = json['additional_info1'];
    _additionalInfo2 = json['additional_info2'];
    _additionalInfo3 = json['additional_info3'];
    _additionalInfo4 = json['additional_info4'];
    _additionalInfo5 = json['additional_info5'];
    _additionalInfo6 = json['additional_info6'];
    _additionalInfo7 = json['additional_info7'];
    _additionalInfo8 = json['additional_info8'];
    _additionalInfo9 = json['additional_info9'];
    _additionalInfo10 = json['additional_info10'];
  }
  String? _additionalInfo1;
  String? _additionalInfo2;
  String? _additionalInfo3;
  String? _additionalInfo4;
  String? _additionalInfo5;
  String? _additionalInfo6;
  String? _additionalInfo7;
  String? _additionalInfo8;
  String? _additionalInfo9;
  String? _additionalInfo10;
AdditionalInfo copyWith({  String? additionalInfo1,
  String? additionalInfo2,
  String? additionalInfo3,
  String? additionalInfo4,
  String? additionalInfo5,
  String? additionalInfo6,
  String? additionalInfo7,
  String? additionalInfo8,
  String? additionalInfo9,
  String? additionalInfo10,
}) => AdditionalInfo(  additionalInfo1: additionalInfo1 ?? _additionalInfo1,
  additionalInfo2: additionalInfo2 ?? _additionalInfo2,
  additionalInfo3: additionalInfo3 ?? _additionalInfo3,
  additionalInfo4: additionalInfo4 ?? _additionalInfo4,
  additionalInfo5: additionalInfo5 ?? _additionalInfo5,
  additionalInfo6: additionalInfo6 ?? _additionalInfo6,
  additionalInfo7: additionalInfo7 ?? _additionalInfo7,
  additionalInfo8: additionalInfo8 ?? _additionalInfo8,
  additionalInfo9: additionalInfo9 ?? _additionalInfo9,
  additionalInfo10: additionalInfo10 ?? _additionalInfo10,
);
  String? get additionalInfo1 => _additionalInfo1;
  String? get additionalInfo2 => _additionalInfo2;
  String? get additionalInfo3 => _additionalInfo3;
  String? get additionalInfo4 => _additionalInfo4;
  String? get additionalInfo5 => _additionalInfo5;
  String? get additionalInfo6 => _additionalInfo6;
  String? get additionalInfo7 => _additionalInfo7;
  String? get additionalInfo8 => _additionalInfo8;
  String? get additionalInfo9 => _additionalInfo9;
  String? get additionalInfo10 => _additionalInfo10;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['additional_info1'] = _additionalInfo1;
    map['additional_info2'] = _additionalInfo2;
    map['additional_info3'] = _additionalInfo3;
    map['additional_info4'] = _additionalInfo4;
    map['additional_info5'] = _additionalInfo5;
    map['additional_info6'] = _additionalInfo6;
    map['additional_info7'] = _additionalInfo7;
    map['additional_info8'] = _additionalInfo8;
    map['additional_info9'] = _additionalInfo9;
    map['additional_info10'] = _additionalInfo10;
    return map;
  }

}