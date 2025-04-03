class LastPaymentPdfGetModel {
  MItem1? mItem1;
  MItem2? mItem2;

  LastPaymentPdfGetModel({this.mItem1, this.mItem2});

  LastPaymentPdfGetModel.fromJson(Map<String, dynamic> json) {
    mItem1 =
        json['m_Item1'] != null ? MItem1.fromJson(json['m_Item1']) : null;
    mItem2 =
        json['m_Item2'] != null ? MItem2.fromJson(json['m_Item2']) : null;
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
  String? receiptPdfLink;

  MItem2({this.receiptPdfLink});

  MItem2.fromJson(Map<String, dynamic> json) {
    receiptPdfLink = json['receiptPdfLink'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['receiptPdfLink'] = receiptPdfLink;
    return data;
  }
}
