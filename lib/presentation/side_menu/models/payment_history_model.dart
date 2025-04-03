// // m_Item1 : {"ResponseCode":"200","ResponseType":"Success","Description":"Bills Found - 12"}
// // m_Item2 : [{"CAN":"011248732","BillMonth":"Apr-2023","Demand":603.07,"Collection":0.0,"Adjustments":0.0},{"CAN":"011248732","BillMonth":"Mar-2023","Demand":599.04,"Collection":0.0,"Adjustments":0.0},{"CAN":"011248732","BillMonth":"Feb-2023","Demand":595.01,"Collection":0.0,"Adjustments":0.0},{"CAN":"011248732","BillMonth":"Jan-2023","Demand":590.98,"Collection":0.0,"Adjustments":0.0},{"CAN":"011248732","BillMonth":"Dec-2022","Demand":586.95,"Collection":0.0,"Adjustments":0.0},{"CAN":"011248732","BillMonth":"Nov-2022","Demand":582.92,"Collection":0.0,"Adjustments":0.0},{"CAN":"011248732","BillMonth":"Oct-2022","Demand":578.89,"Collection":0.0,"Adjustments":0.0},{"CAN":"011248732","BillMonth":"Sep-2022","Demand":574.86,"Collection":0.0,"Adjustments":0.0},{"CAN":"011248732","BillMonth":"Aug-2022","Demand":571.17,"Collection":0.0,"Adjustments":0.0},{"CAN":"011248732","BillMonth":"Jul-2022","Demand":811.76,"Collection":0.0,"Adjustments":0.0},{"CAN":"011248732","BillMonth":"May-2022","Demand":559.03,"Collection":0.0,"Adjustments":0.0},{"CAN":"011248732","BillMonth":"Apr-2022","Demand":555.0,"Collection":0.0,"Adjustments":0.0}]

// class PaymentHistoryModel {
//   PaymentHistoryModel({
//     MItem1? mItem1,
//     List<MItem2>? mItem2,
//   }) {
//     _mItem1 = mItem1;
//     _mItem2 = mItem2;
//   }

//   PaymentHistoryModel.fromJson(dynamic json) {
//     _mItem1 = json['m_Item1'] != null ? MItem1.fromJson(json['m_Item1']) : null;
//     if (json['m_Item2'] != null) {
//       _mItem2 = [];
//       json['m_Item2'].forEach((v) {
//         _mItem2?.add(MItem2.fromJson(v));
//       });
//     }
//   }
//   MItem1? _mItem1;
//   List<MItem2>? _mItem2;
//   PaymentHistoryModel copyWith({
//     MItem1? mItem1,
//     List<MItem2>? mItem2,
//   }) =>
//       PaymentHistoryModel(
//         mItem1: mItem1 ?? _mItem1,
//         mItem2: mItem2 ?? _mItem2,
//       );
//   MItem1? get mItem1 => _mItem1;
//   List<MItem2>? get mItem2 => _mItem2;

//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     if (_mItem1 != null) {
//       map['m_Item1'] = _mItem1?.toJson();
//     }
//     if (_mItem2 != null) {
//       map['m_Item2'] = _mItem2?.map((v) => v.toJson()).toList();
//     }
//     return map;
//   }
// }

// /// CAN : "011248732"
// /// BillMonth : "Apr-2023"
// /// Demand : 603.07
// /// Collection : 0.0
// /// Adjustments : 0.0

// class MItem2 {
//   MItem2({
//     String? can,
//     String? billMonth,
//     num? demand,
//     num? rebate,
//     num? collection,
//     num? adjustments,
//   }) {
//     _can = can;
//     _billMonth = billMonth;
//     _demand = demand;
//     _rebate = rebate;
//     _collection = collection;
//     _adjustments = adjustments;
//   }

//   MItem2.fromJson(dynamic json) {
//     _can = json['CAN'];
//     _billMonth = json['BillMonth'];
//     _demand = json['Demand'];
//     _rebate = json['Rebate'];
//     _collection = json['Collection'];
//     _adjustments = json['Adjustments'];
//   }
//   String? _can;
//   String? _billMonth;
//   num? _demand;
//   num? _collection;
//   num? _adjustments;
//   num? _rebate;
//   MItem2 copyWith({
//     String? can,
//     String? billMonth,
//     num? demand,
//     num? collection,
//     num? adjustments,
//     num? rebate,
//   }) =>
//       MItem2(
//         can: can ?? _can,
//         billMonth: billMonth ?? _billMonth,
//         demand: demand ?? _demand,
//         collection: collection ?? _collection,
//         adjustments: adjustments ?? _adjustments,
//         rebate: rebate ?? _rebate,
//       );
//   String? get can => _can;
//   String? get billMonth => _billMonth;
//   num? get demand => _demand;
//   num? get collection => _collection;
//   num? get adjustments => _adjustments;
//   num? get rebate => _rebate;

//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['CAN'] = _can;
//     map['BillMonth'] = _billMonth;
//     map['Demand'] = _demand;
//     map['Collection'] = _collection;
//     map['Adjustments'] = _adjustments;
//     map['Rebate'] = _rebate;
//     return map;
//   }
// }

// /// ResponseCode : "200"
// /// ResponseType : "Success"
// /// Description : "Bills Found - 12"

// class MItem1 {
//   MItem1({
//     String? responseCode,
//     String? responseType,
//     String? description,
//   }) {
//     _responseCode = responseCode;
//     _responseType = responseType;
//     _description = description;
//   }

//   MItem1.fromJson(dynamic json) {
//     _responseCode = json['ResponseCode'];
//     _responseType = json['ResponseType'];
//     _description = json['Description'];
//   }
//   String? _responseCode;
//   String? _responseType;
//   String? _description;
//   MItem1 copyWith({
//     String? responseCode,
//     String? responseType,
//     String? description,
//   }) =>
//       MItem1(
//         responseCode: responseCode ?? _responseCode,
//         responseType: responseType ?? _responseType,
//         description: description ?? _description,
//       );
//   String? get responseCode => _responseCode;
//   String? get responseType => _responseType;
//   String? get description => _description;

//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['ResponseCode'] = _responseCode;
//     map['ResponseType'] = _responseType;
//     map['Description'] = _description;
//     return map;
//   }
// }

class PaymentHistoryModel {
  MItem1? mItem1;
  List<MItem2>? mItem2;

  PaymentHistoryModel({this.mItem1, this.mItem2});

  PaymentHistoryModel.fromJson(Map<String, dynamic> json) {
    mItem1 = json['m_Item1'] != null ? MItem1.fromJson(json['m_Item1']) : null;
    if (json['m_Item2'] != null) {
      mItem2 = <MItem2>[];
      json['m_Item2'].forEach((v) {
        mItem2!.add(MItem2.fromJson(v));
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

class MItem2 {
  String? cAN;
  String? billMonth;
  double? demand;
  double? rebate;
  double? collection;
  double? adjustments;
  String? billDate;
  String? collectionDate;

  MItem2({
    this.cAN,
    this.billMonth,
    this.demand,
    this.rebate,
    this.collection,
    this.adjustments,
    this.billDate,
    this.collectionDate,
  });

  MItem2.fromJson(Map<String, dynamic> json) {
    cAN = json['CAN'];
    billMonth = json['BillMonth'];
    demand = json['Demand'];
    rebate = json['Rebate'];
    collection = json['Collection'];
    adjustments = json['Adjustments'];
    billDate = json['BillDate'];
    collectionDate = json['Collectiondate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['CAN'] = cAN;
    data['BillMonth'] = billMonth;
    data['Demand'] = demand;
    data['Rebate'] = rebate;
    data['Collection'] = collection;
    data['Adjustments'] = adjustments;
    data['BillDate'] = billDate;
    data['Collectiondate'] = collectionDate;
    return data;
  }
}
