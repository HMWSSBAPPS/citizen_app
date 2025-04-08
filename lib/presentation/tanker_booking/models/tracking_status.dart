class Status {
  Result? result;
  List<ResultArray>? resultArray;

  Status({this.result, this.resultArray});

  Status.fromJson(Map<String, dynamic> json) {
    result =
    json['Result'] != null ? new Result.fromJson(json['Result']) : null;
    if (json['ResultArray'] != null) {
      resultArray = <ResultArray>[];
      json['ResultArray'].forEach((v) {
        resultArray!.add(new ResultArray.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['Result'] = this.result!.toJson();
    }
    if (this.resultArray != null) {
      data['ResultArray'] = this.resultArray!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  String? response;
  String? responseType;

  Result({this.response, this.responseType});

  Result.fromJson(Map<String, dynamic> json) {
    response = json['Response'];
    responseType = json['ResponseType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Response'] = this.response;
    data['ResponseType'] = this.responseType;
    return data;
  }
}

class ResultArray {
  String? fILLSTATIONNAME;
  int? gRIEVSTATUS;
  int? tOKENNO;
  int? dIFFHOURS;
  String? cAN;
  int? sEQNUM;
  String? rECVDDATE;
  String? mOBILE;
  String? lASTDSSTIME;
  String? vEHICLENO;
  String? rECTIFIEDDATE;
  String? nAME;
  String? rEMARKS;
  String? tANKERQTY;
  int? pINNO;
  int? gRIEVPKEY;

  ResultArray(
      {this.fILLSTATIONNAME,
        this.gRIEVSTATUS,
        this.tOKENNO,
        this.dIFFHOURS,
        this.cAN,
        this.sEQNUM,
        this.rECVDDATE,
        this.mOBILE,
        this.lASTDSSTIME,
        this.vEHICLENO,
        this.rECTIFIEDDATE,
        this.nAME,
        this.rEMARKS,
        this.tANKERQTY,
        this.pINNO,
        this.gRIEVPKEY});

  ResultArray.fromJson(Map<String, dynamic> json) {
    fILLSTATIONNAME = json['FILLSTATION_NAME'];
    gRIEVSTATUS = json['GRIEVSTATUS'];
    tOKENNO = json['TOKENNO'];
    dIFFHOURS = json['DIFF_HOURS'];
    cAN = json['CAN'];
    sEQNUM = json['SEQNUM'];
    rECVDDATE = json['RECVDDATE'];
    mOBILE = json['MOBILE'];
    lASTDSSTIME = json['LAST_DSS_TIME'];
    vEHICLENO = json['VEHICLENO'];
    rECTIFIEDDATE = json['RECTIFIEDDATE'];
    nAME = json['NAME'];
    rEMARKS = json['REMARKS'];
    tANKERQTY = json['TANKERQTY'];
    pINNO = json['PINNO'];
    gRIEVPKEY = json['GRIEVPKEY'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['FILLSTATION_NAME'] = this.fILLSTATIONNAME;
    data['GRIEVSTATUS'] = this.gRIEVSTATUS;
    data['TOKENNO'] = this.tOKENNO;
    data['DIFF_HOURS'] = this.dIFFHOURS;
    data['CAN'] = this.cAN;
    data['SEQNUM'] = this.sEQNUM;
    data['RECVDDATE'] = this.rECVDDATE;
    data['MOBILE'] = this.mOBILE;
    data['LAST_DSS_TIME'] = this.lASTDSSTIME;
    data['VEHICLENO'] = this.vEHICLENO;
    data['RECTIFIEDDATE'] = this.rECTIFIEDDATE;
    data['NAME'] = this.nAME;
    data['REMARKS'] = this.rEMARKS;
    data['TANKERQTY'] = this.tANKERQTY;
    data['PINNO'] = this.pINNO;
    data['GRIEVPKEY'] = this.gRIEVPKEY;
    return data;
  }
}
