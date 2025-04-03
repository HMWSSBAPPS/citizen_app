// m_Item1 : {"ResponseCode":"200","ResponseType":"Success","Description":"ConsumerInformation Found"}
// m_Item2 : {"CAN":"620557270","Name":"SAYAKONDA ANJAMMA","Address":"PLOT.NO:88,RADHA KRISHNA COLONY, PEERZADIGUDA,PEERJADIGUDA","Category":"D","WaterPipesizeInMM":"15","OutstandingAmount":0.0,"Mobileno":"8686863442","Email":"","Currentmonthavgdemand":0.0,"FwTotalRebate":0.0,"NoOfMonths":0,"SANMsg":""}

class ConsumerInfoData {
  ConsumerInfoData({
    MItem1? mItem1,
    MItem2? mItem2,
    GetConsumerInfoByCanMItem3? mItem3,
  }) {
    _mItem1 = mItem1;
    _mItem2 = mItem2;
    _mItem3 = mItem3;
  }

  ConsumerInfoData.fromJson(dynamic json) {
    _mItem1 = json['m_Item1'] != null ? MItem1.fromJson(json['m_Item1']) : null;
    _mItem2 = json['m_Item2'] != null ? MItem2.fromJson(json['m_Item2']) : null;
    _mItem3 = json['m_Item3'] != null
        ? GetConsumerInfoByCanMItem3.fromJson(json['m_Item3'])
        : null;
  }
  MItem1? _mItem1;
  MItem2? _mItem2;
  GetConsumerInfoByCanMItem3? _mItem3;
  ConsumerInfoData copyWith({
    MItem1? mItem1,
    MItem2? mItem2,
    GetConsumerInfoByCanMItem3? mItem3,
  }) =>
      ConsumerInfoData(
        mItem1: mItem1 ?? _mItem1,
        mItem2: mItem2 ?? _mItem2,
        mItem3: mItem3 ?? _mItem3,
      );
  MItem1? get mItem1 => _mItem1;
  MItem2? get mItem2 => _mItem2;
  GetConsumerInfoByCanMItem3? get mItem3 => _mItem3;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_mItem1 != null) {
      map['m_Item1'] = _mItem1?.toJson();
    }
    if (_mItem2 != null) {
      map['m_Item2'] = _mItem2?.toJson();
    }
    if (_mItem3 != null) {
      map['m_Item3'] = _mItem3?.toJson();
    }
    return map;
  }
}

/// CAN : "620557270"
/// Name : "SAYAKONDA ANJAMMA"
/// Address : "PLOT.NO:88,RADHA KRISHNA COLONY, PEERZADIGUDA,PEERJADIGUDA"
/// Category : "D"
/// WaterPipesizeInMM : "15"
/// OutstandingAmount : 0.0
/// Mobileno : "8686863442"
/// Email : ""
/// Currentmonthavgdemand : 0.0
/// FwTotalRebate : 0.0
/// NoOfMonths : 0
/// SANMsg : ""

class MItem2 {
  MItem2({
    String? can,
    String? name,
    String? address,
    String? category,
    String? waterPipesizeInMM,
    num? outstandingAmount,
    String? mobileno,
    String? email,
    num? currentmonthavgdemand,
    num? fwTotalRebate,
    num? noOfMonths,
    String? sANMsg,
    num? consumption,
  }) {
    _can = can;
    _name = name;
    _address = address;
    _category = category;
    _waterPipesizeInMM = waterPipesizeInMM;
    _outstandingAmount = outstandingAmount;
    _mobileno = mobileno;
    _email = email;
    _currentmonthavgdemand = currentmonthavgdemand;
    _fwTotalRebate = fwTotalRebate;
    _noOfMonths = noOfMonths;
    _sANMsg = sANMsg;
    _consumption = consumption;
  }

  MItem2.fromJson(dynamic json) {
    _can = json['CAN'];
    _name = json['Name'];
    _address = json['Address'];
    _category = json['Category'];
    _waterPipesizeInMM = json['WaterPipesizeInMM'];
    _outstandingAmount = json['OutstandingAmount'];
    _mobileno = json['Mobileno'];
    _email = json['Email'];
    _currentmonthavgdemand = json['Currentmonthavgdemand'];
    _fwTotalRebate = json['FwTotalRebate'];
    _noOfMonths = json['NoOfMonths'];
    _sANMsg = json['SANMsg'];
    _consumption = json['Consumption'];
  }
  String? _can;
  String? _name;
  String? _address;
  String? _category;
  String? _waterPipesizeInMM;
  num? _outstandingAmount;
  String? _mobileno;
  String? _email;
  num? _currentmonthavgdemand;
  num? _fwTotalRebate;
  num? _noOfMonths;
  String? _sANMsg;
  num? _consumption;

  MItem2 copyWith({
    String? can,
    String? name,
    String? address,
    String? category,
    String? waterPipesizeInMM,
    num? outstandingAmount,
    String? mobileno,
    String? email,
    num? currentmonthavgdemand,
    num? fwTotalRebate,
    num? noOfMonths,
    String? sANMsg,
    num? consumption,
  }) =>
      MItem2(
        can: can ?? _can,
        name: name ?? _name,
        address: address ?? _address,
        category: category ?? _category,
        waterPipesizeInMM: waterPipesizeInMM ?? _waterPipesizeInMM,
        outstandingAmount: outstandingAmount ?? _outstandingAmount,
        mobileno: mobileno ?? _mobileno,
        email: email ?? _email,
        currentmonthavgdemand: currentmonthavgdemand ?? _currentmonthavgdemand,
        fwTotalRebate: fwTotalRebate ?? _fwTotalRebate,
        noOfMonths: noOfMonths ?? _noOfMonths,
        sANMsg: sANMsg ?? _sANMsg,
        consumption: consumption ?? _consumption,
      );
  String? get can => _can;
  String? get name => _name;
  String? get address => _address;
  String? get category => _category;
  String? get waterPipesizeInMM => _waterPipesizeInMM;
  num? get outstandingAmount => _outstandingAmount;
  String? get mobileno => _mobileno;
  String? get email => _email;
  num? get currentmonthavgdemand => _currentmonthavgdemand;
  num? get fwTotalRebate => _fwTotalRebate;
  num? get noOfMonths => _noOfMonths;
  String? get sANMsg => _sANMsg;
  num? get consumption => _consumption;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['CAN'] = _can;
    map['Name'] = _name;
    map['Address'] = _address;
    map['Category'] = _category;
    map['WaterPipesizeInMM'] = _waterPipesizeInMM;
    map['OutstandingAmount'] = _outstandingAmount;
    map['Mobileno'] = _mobileno;
    map['Email'] = _email;
    map['Currentmonthavgdemand'] = _currentmonthavgdemand;
    map['FwTotalRebate'] = _fwTotalRebate;
    map['NoOfMonths'] = _noOfMonths;
    map['SANMsg'] = _sANMsg;
    map['Consumption'] = _consumption;
    return map;
  }
}

class GetConsumerInfoByCanMItem3 {
  GetConsumerInfoByCanMItem3({
    double? minAmountPay,
    double? maxAmountPay,
  }) {
    _minAmountPay = minAmountPay;
    _maxAmountPay = maxAmountPay;
  }

  GetConsumerInfoByCanMItem3.fromJson(dynamic json) {
    _minAmountPay = json['minAmountPay'];
    _maxAmountPay = json['maxAmountPay'];
  }

  double? _minAmountPay;
  double? _maxAmountPay;

  GetConsumerInfoByCanMItem3 copyWith({double? minAmountPay, double? maxAmountPay}) =>
      GetConsumerInfoByCanMItem3(
        minAmountPay: minAmountPay ?? _minAmountPay,
        maxAmountPay: maxAmountPay ?? _maxAmountPay,
      );
  double? get minAmountPay => _minAmountPay;
  double? get maxAmountPay => _maxAmountPay;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['minAmountPay'] = _minAmountPay;
    map['maxAmountPay'] = _maxAmountPay;
    return map;
  }
}

/// ResponseCode : "200"
/// ResponseType : "Success"
/// Description : "ConsumerInformation Found"

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
