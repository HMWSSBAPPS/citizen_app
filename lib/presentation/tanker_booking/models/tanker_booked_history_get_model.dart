class TankerBookedHistoryGetModel {
  MItem1? mItem1;
  List<TankersHistoryContent>? mItem2;

  TankerBookedHistoryGetModel({this.mItem1, this.mItem2});

  TankerBookedHistoryGetModel.fromJson(Map<String, dynamic> json) {
    mItem1 = json['m_Item1'] != null ? MItem1.fromJson(json['m_Item1']) : null;
    if (json['m_Item2'] != null) {
      mItem2 = <TankersHistoryContent>[];
      json['m_Item2'].forEach((v) {
        mItem2!.add(TankersHistoryContent.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (mItem1 != null) {
      data['m_Item1'] = mItem1!.toJson();
    }
    if (mItem2 != null) {
      data['m_Item2'] = mItem2!.map((v) => v.toJson()).toList();
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

class TankersHistoryContent {
  String? cAN;
  String? cOMPLAINTNO;
  String? bOOKEDFROM;
  String? bOOKINGDATE;
  String? rEQUIREDDATE;
  String? rECTIFIEDDATE;
  String? vEHICLENO;
  double? gRIEVSTATUS;
  String? nAME;
  String? aDDRESS;
  String? pINNO;
  String? cONTACTNO;
  String? tANKERQTY;
  String? bOOKINGSTATUS;

  TankersHistoryContent(
      {this.cAN,
      this.cOMPLAINTNO,
      this.bOOKEDFROM,
      this.bOOKINGDATE,
      this.rEQUIREDDATE,
      this.rECTIFIEDDATE,
      this.vEHICLENO,
      this.gRIEVSTATUS,
      this.nAME,
      this.aDDRESS,
      this.pINNO,
      this.cONTACTNO,
      this.tANKERQTY,
      this.bOOKINGSTATUS});

  TankersHistoryContent.fromJson(Map<String, dynamic> json) {
    cAN = json['CAN'];
    cOMPLAINTNO = json['COMPLAINTNO'];
    bOOKEDFROM = json['BOOKEDFROM'];
    bOOKINGDATE = json['BOOKINGDATE'];
    rEQUIREDDATE = json['REQUIREDDATE'];
    rECTIFIEDDATE = json['RECTIFIEDDATE'];
    vEHICLENO = json['VEHICLENO'];
    gRIEVSTATUS = json['GRIEVSTATUS'];
    nAME = json['NAME'];
    aDDRESS = json['ADDRESS'];
    pINNO = json['PINNO'];
    cONTACTNO = json['CONTACTNO'];
    tANKERQTY = json['TANKERQTY'];
    bOOKINGSTATUS = json['BOOKINGSTATUS'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['CAN'] = cAN;
    data['COMPLAINTNO'] = cOMPLAINTNO;
    data['BOOKEDFROM'] = bOOKEDFROM;
    data['BOOKINGDATE'] = bOOKINGDATE;
    data['REQUIREDDATE'] = rEQUIREDDATE;
    data['RECTIFIEDDATE'] = rECTIFIEDDATE;
    data['VEHICLENO'] = vEHICLENO;
    data['GRIEVSTATUS'] = gRIEVSTATUS;
    data['NAME'] = nAME;
    data['ADDRESS'] = aDDRESS;
    data['PINNO'] = pINNO;
    data['CONTACTNO'] = cONTACTNO;
    data['TANKERQTY'] = tANKERQTY;
    data['BOOKINGSTATUS'] = bOOKINGSTATUS;
    return data;
  }
}
