class TankerBookedHistoryGetModel {
  MItem1? mItem1;
  List<TankersHistoryContent>? mItem2;

  TankerBookedHistoryGetModel({this.mItem1, this.mItem2});

  TankerBookedHistoryGetModel.fromJson(Map<String, dynamic> json) {
    mItem1 =
    json['m_Item1'] != null ? new MItem1.fromJson(json['m_Item1']) : null;
    if (json['m_Item2'] != null) {
      mItem2 = <TankersHistoryContent>[];
      json['m_Item2'].forEach((v) {
        mItem2!.add(TankersHistoryContent.fromJson(v));
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

class TankersHistoryContent {
  String? can;
  String? complaintNo;
  String? bookedFrom;
  String? bookingDate;
  String? requiredDate;
  String? rectifiedDate;
  String? vehicleNo;
  int? grievStatus;
  String? name;
  String? address;
  String? pINNo;
  String? contactNo;
  String? tankerQty;
  String? bookingStatus;

  TankersHistoryContent(
      {this.can,
        this.complaintNo,
        this.bookedFrom,
        this.bookingDate,
        this.requiredDate,
        this.rectifiedDate,
        this.vehicleNo,
        this.grievStatus,
        this.name,
        this.address,
        this.pINNo,
        this.contactNo,
        this.tankerQty,
        this.bookingStatus});

  TankersHistoryContent.fromJson(Map<String, dynamic> json) {
    can = json['Can'];
    complaintNo = json['ComplaintNo'];
    bookedFrom = json['BookedFrom'];
    bookingDate = json['BookingDate'];
    requiredDate = json['RequiredDate'];
    rectifiedDate = json['RectifiedDate'];
    vehicleNo = json['VehicleNo'];
    grievStatus = json['GrievStatus'];
    name = json['Name'];
    address = json['Address'];
    pINNo = json['PINNo'];
    contactNo = json['ContactNo'];
    tankerQty = json['TankerQty'];
    bookingStatus = json['BookingStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Can'] = this.can;
    data['ComplaintNo'] = this.complaintNo;
    data['BookedFrom'] = this.bookedFrom;
    data['BookingDate'] = this.bookingDate;
    data['RequiredDate'] = this.requiredDate;
    data['RectifiedDate'] = this.rectifiedDate;
    data['VehicleNo'] = this.vehicleNo;
    data['GrievStatus'] = this.grievStatus;
    data['Name'] = this.name;
    data['Address'] = this.address;
    data['PINNo'] = this.pINNo;
    data['ContactNo'] = this.contactNo;
    data['TankerQty'] = this.tankerQty;
    data['BookingStatus'] = this.bookingStatus;
    return data;
  }
}
