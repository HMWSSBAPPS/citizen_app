class cansbymobilenew {
  MItem1? mItem1;
  List<MItem2>? mItem2;

  cansbymobilenew({this.mItem1, this.mItem2});

  cansbymobilenew.fromJson(Map<String, dynamic> json) {
    mItem1 =
    json['m_Item1'] != null ? new MItem1.fromJson(json['m_Item1']) : null;
    if (json['m_Item2'] != null) {
      mItem2 = <MItem2>[];
      json['m_Item2'].forEach((v) {
        mItem2!.add(new MItem2.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.mItem1 != null) {
      data['m_Item1'] = this.mItem1!.toJson();
    }
    if (this.mItem2 != null) {
      data['m_Item2'] = this.mItem2!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ResponseCode'] = this.responseCode;
    data['ResponseType'] = this.responseType;
    data['Description'] = this.description;
    return data;
  }
}

class MItem2 {
  int? pKey;
  int? serConnPKey;
  String? can;
  String? meterNo;
  int? meterSize;
  String? meterAgency;
  String? meterManufacturedBy;
  String? meterManufacturedDate;
  String? makeWarrantyDate;
  String? makeIssuedDate;
  String? meterFixedDate;
  String? initialReading;
  String? capturedBy;
  String? capturedDate;
  bool? approved;
  String? approvedBy;
  String? approvedDate;
  String? meterPhotoURL;
  String? sourceChannel;
  String? consumerName;
  String? dateofConnection;
  String? mRCode;
  double? latitude;
  double? longitude;
  String? lastBillDate;
  String? divisionCode;
  String? buildingPhotoURL;
  int? mDMeterType;
  String? technology;
  String? amrAgency;
  String? meterNoticePhotoURL;

  MItem2(
      {this.pKey,
        this.serConnPKey,
        this.can,
        this.meterNo,
        this.meterSize,
        this.meterAgency,
        this.meterManufacturedBy,
        this.meterManufacturedDate,
        this.makeWarrantyDate,
        this.makeIssuedDate,
        this.meterFixedDate,
        this.initialReading,
        this.capturedBy,
        this.capturedDate,
        this.approved,
        this.approvedBy,
        this.approvedDate,
        this.meterPhotoURL,
        this.sourceChannel,
        this.consumerName,
        this.dateofConnection,
        this.mRCode,
        this.latitude,
        this.longitude,
        this.lastBillDate,
        this.divisionCode,
        this.buildingPhotoURL,
        this.mDMeterType,
        this.technology,
        this.amrAgency,
        this.meterNoticePhotoURL});

  MItem2.fromJson(Map<String, dynamic> json) {
    pKey = json['PKey'];
    serConnPKey = json['SerConnPKey'];
    can = json['Can'];
    meterNo = json['MeterNo'];
    meterSize = json['MeterSize'];
    meterAgency = json['MeterAgency'];
    meterManufacturedBy = json['MeterManufacturedBy'];
    meterManufacturedDate = json['MeterManufacturedDate'];
    makeWarrantyDate = json['MakeWarrantyDate'];
    makeIssuedDate = json['MakeIssuedDate'];
    meterFixedDate = json['MeterFixedDate'];
    initialReading = json['InitialReading'];
    capturedBy = json['CapturedBy'];
    capturedDate = json['CapturedDate'];
    approved = json['Approved'];
    approvedBy = json['ApprovedBy'];
    approvedDate = json['ApprovedDate'];
    meterPhotoURL = json['MeterPhotoURL'];
    sourceChannel = json['SourceChannel'];
    consumerName = json['ConsumerName'];
    dateofConnection = json['DateofConnection'];
    mRCode = json['MRCode'];
    latitude = json['Latitude'];
    longitude = json['Longitude'];
    lastBillDate = json['LastBillDate'];
    divisionCode = json['DivisionCode'];
    buildingPhotoURL = json['BuildingPhotoURL'];
    mDMeterType = json['MDMeterType'];
    technology = json['Technology'];
    amrAgency = json['AmrAgency'];
    meterNoticePhotoURL = json['MeterNoticePhotoURL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PKey'] = this.pKey;
    data['SerConnPKey'] = this.serConnPKey;
    data['Can'] = this.can;
    data['MeterNo'] = this.meterNo;
    data['MeterSize'] = this.meterSize;
    data['MeterAgency'] = this.meterAgency;
    data['MeterManufacturedBy'] = this.meterManufacturedBy;
    data['MeterManufacturedDate'] = this.meterManufacturedDate;
    data['MakeWarrantyDate'] = this.makeWarrantyDate;
    data['MakeIssuedDate'] = this.makeIssuedDate;
    data['MeterFixedDate'] = this.meterFixedDate;
    data['InitialReading'] = this.initialReading;
    data['CapturedBy'] = this.capturedBy;
    data['CapturedDate'] = this.capturedDate;
    data['Approved'] = this.approved;
    data['ApprovedBy'] = this.approvedBy;
    data['ApprovedDate'] = this.approvedDate;
    data['MeterPhotoURL'] = this.meterPhotoURL;
    data['SourceChannel'] = this.sourceChannel;
    data['ConsumerName'] = this.consumerName;
    data['DateofConnection'] = this.dateofConnection;
    data['MRCode'] = this.mRCode;
    data['Latitude'] = this.latitude;
    data['Longitude'] = this.longitude;
    data['LastBillDate'] = this.lastBillDate;
    data['DivisionCode'] = this.divisionCode;
    data['BuildingPhotoURL'] = this.buildingPhotoURL;
    data['MDMeterType'] = this.mDMeterType;
    data['Technology'] = this.technology;
    data['AmrAgency'] = this.amrAgency;
    data['MeterNoticePhotoURL'] = this.meterNoticePhotoURL;
    return data;
  }
}
