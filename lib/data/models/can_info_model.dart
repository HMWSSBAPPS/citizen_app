class CanInfoModel {
  MItem1? mItem1;
  MItem2? mItem2;

  CanInfoModel({this.mItem1, this.mItem2});

  CanInfoModel.fromJson(Map<String, dynamic> json) {
    mItem1 = json['m_Item1'] != null ? MItem1.fromJson(json['m_Item1']) : null;
    mItem2 = json['m_Item2'] != null ? MItem2.fromJson(json['m_Item2']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (mItem1 != null) {
      data['m_Item1'] = mItem1!.toJson();
    }
    if (mItem2 != null) {
      data['m_Item2'] = mItem2!.toJson();
    }
    return data;
  }
}

class MItem1 {
  String? responseCode;
  String? responseType;
  String? description;

  MItem1({this.responseCode, this.responseType, this.description});

  MItem1.fromJson(Map<String, dynamic> json) {
    responseCode = json['ResponseCode'];
    responseType = json['ResponseType'];
    description = json['Description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ResponseCode'] = responseCode;
    data['ResponseType'] = responseType;
    data['Description'] = description;
    return data;
  }
}

class MItem2 {
  String? cAN;
  String? name;
  String? address;
  String? category;
  String? waterPipesizeInMM;
  num? outstandingAmount;
  String? mobileno;
  String? email;
  num? currentmonthavgdemand;
  num? fwTotalRebate;
  num? noOfMonths;
  String? sANMsg;
  String? latitude;
  String? longitude;
  bool? iSAMR;
  int? consumption;
  int? rWHFlag;
  int? isLatLongEditible;

  MItem2(
      {this.cAN,
      this.name,
      this.address,
      this.category,
      this.waterPipesizeInMM,
      this.outstandingAmount,
      this.mobileno,
      this.email,
      this.currentmonthavgdemand,
      this.fwTotalRebate,
      this.noOfMonths,
      this.sANMsg,
      this.latitude,
      this.longitude,
      this.iSAMR,
      this.consumption,
      this.rWHFlag,
      this.isLatLongEditible});

  MItem2.fromJson(Map<String, dynamic> json) {
    cAN = json['CAN'];
    name = json['Name'];
    address = json['Address'];
    category = json['Category'];
    waterPipesizeInMM = json['WaterPipesizeInMM'];
    outstandingAmount = json['OutstandingAmount'];
    mobileno = json['Mobileno'];
    email = json['Email'];
    currentmonthavgdemand = json['Currentmonthavgdemand'];
    fwTotalRebate = json['FwTotalRebate'];
    noOfMonths = json['NoOfMonths'];
    sANMsg = json['SANMsg'];
    latitude = json['Latitude'];
    longitude = json['Longitude'];
    iSAMR = json['ISAMR'];
    consumption = json['Consumption'];
    rWHFlag = json['RWHFlag'];
    isLatLongEditible = json['IsLatLongEditible'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['CAN'] = cAN;
    data['Name'] = name;
    data['Address'] = address;
    data['Category'] = category;
    data['WaterPipesizeInMM'] = waterPipesizeInMM;
    data['OutstandingAmount'] = outstandingAmount;
    data['Mobileno'] = mobileno;
    data['Email'] = email;
    data['Currentmonthavgdemand'] = currentmonthavgdemand;
    data['FwTotalRebate'] = fwTotalRebate;
    data['NoOfMonths'] = noOfMonths;
    data['SANMsg'] = sANMsg;
    data['Latitude'] = latitude;
    data['Longitude'] = longitude;
    data['ISAMR'] = iSAMR;
    data['Consumption'] = consumption;
    data['RWHFlag'] = rWHFlag;
    data['IsLatLongEditible'] = isLatLongEditible;
    return data;
  }
}
