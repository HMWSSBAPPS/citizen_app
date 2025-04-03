class RWHPitsDetailsGetModel {
  int? error;
  Survey? survey;

  RWHPitsDetailsGetModel({this.error, this.survey});

  RWHPitsDetailsGetModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    survey = json['survey'] != null ? Survey.fromJson(json['survey']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['error'] = error;
    if (survey != null) {
      data['survey'] = survey!.toJson();
    }
    return data;
  }
}

class Survey {
  int? id;
  String? canNumber;
  // Null? type;
  // Null? ulbName;
  // Null? ulbWard;
  // Null? propertyTaxNumber;
  // Null? electricityNumber;
  // Null? name;
  // Null? hNo;
  // Null? location;
  // Null? ward;
  String? plotArea;
  String? houseType;
  String? rwhExists;
  // Null? contactName;
  // Null? contactNo;
  String? latitude;
  String? longitude;
  String? buildingImagePath;
  String? noOfTankersRequired;
  String? noOfBorewells;
  String? borewellMinDepth;
  String? borewellMaxDepth;
  String? noOfBorewellsWorking;
  // Null? noOfBorewellsNotWorking;
  String? tankersBooked;
  // Null? bookedByYou;
  int? noOfPits;
  // Null? remarks;
  int? createdId;
  String? created;
  // Null? modifiedId;
  String? modified;
  List<GetSurveyPits>? surveyPits;

  Survey({
    this.id,
    this.canNumber,
    // this.type,
    // this.ulbName,
    // this.ulbWard,
    // this.propertyTaxNumber,
    // this.electricityNumber,
    // this.name,
    // this.hNo,
    // this.location,
    // this.ward,
    this.plotArea,
    this.houseType,
    this.rwhExists,
    // this.contactName,
    // this.contactNo,
    this.latitude,
    this.longitude,
    this.buildingImagePath,
    this.noOfTankersRequired,
    this.noOfBorewells,
    this.borewellMinDepth,
    this.borewellMaxDepth,
    this.noOfBorewellsWorking,
    // this.noOfBorewellsNotWorking,
    this.tankersBooked,
    // this.bookedByYou,
    this.noOfPits,
    // this.remarks,
    this.createdId,
    this.created,
    // this.modifiedId,
    this.modified,
    this.surveyPits,
  });

  Survey.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    canNumber = json['can_number'];
    // type = json['type'];
    // ulbName = json['ulb_name'];
    // ulbWard = json['ulb_ward'];
    // propertyTaxNumber = json['property_tax_number'];
    // electricityNumber = json['electricity_number'];
    // name = json['name'];
    // hNo = json['h_no'];
    // location = json['location'];
    // ward = json['ward'];
    plotArea = json['plot_area'];
    houseType = json['house_type'];
    rwhExists = json['rwh_exists'];
    // contactName = json['contact_name'];
    // contactNo = json['contact_no'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    buildingImagePath = json['building_image_path'];
    noOfTankersRequired = json['no_of_tankers_required'];
    noOfBorewells = json['no_of_borewells'];
    borewellMinDepth = json['borewell_min_depth'];
    borewellMaxDepth = json['borewell_max_depth'];
    noOfBorewellsWorking = json['no_of_borewells_working'];
    // noOfBorewellsNotWorking = json['no_of_borewells_not_working'];
    tankersBooked = json['tankers_booked'];
    // bookedByYou = json['booked_by_you'];
    noOfPits = json['no_of_pits'];
    // remarks = json['remarks'];
    createdId = json['created_id'];
    created = json['created'];
    // modifiedId = json['modified_id'];
    modified = json['modified'];
    if (json['survey_pits'] != null) {
      surveyPits = <GetSurveyPits>[];
      json['survey_pits'].forEach((v) {
        surveyPits!.add(GetSurveyPits.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['can_number'] = canNumber;
    // data['type'] = type;
    // data['ulb_name'] = ulbName;
    // data['ulb_ward'] = ulbWard;
    // data['property_tax_number'] = propertyTaxNumber;
    // data['electricity_number'] = electricityNumber;
    // data['name'] = name;
    // data['h_no'] = hNo;
    // data['location'] = location;
    // data['ward'] = ward;
    data['plot_area'] = plotArea;
    data['house_type'] = houseType;
    data['rwh_exists'] = rwhExists;
    // data['contact_name'] = contactName;
    // data['contact_no'] = contactNo;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['building_image_path'] = buildingImagePath;
    data['no_of_tankers_required'] = noOfTankersRequired;
    data['no_of_borewells'] = noOfBorewells;
    data['borewell_min_depth'] = borewellMinDepth;
    data['borewell_max_depth'] = borewellMaxDepth;
    data['no_of_borewells_working'] = noOfBorewellsWorking;
    // data['no_of_borewells_not_working'] = noOfBorewellsNotWorking;
    data['tankers_booked'] = tankersBooked;
    // data['booked_by_you'] = bookedByYou;
    data['no_of_pits'] = noOfPits;
    // data['remarks'] = remarks;
    data['created_id'] = createdId;
    data['created'] = created;
    // data['modified_id'] = modifiedId;
    data['modified'] = modified;
    if (surveyPits != null) {
      data['survey_pits'] = surveyPits!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetSurveyPits {
  int? id;
  int? surveyId;
  int? rwhNo;
  String? rwhNumber;
  String? rwhLength;
  String? rwhBreadth;
  String? rwhDepth;
  String? rwhWorkingStatus;
  String? updateReason;
  String? imagePath;
  String? latitude;
  String? longitude;
  int? createdId;
  String? created;
  dynamic modifiedId;
  String? modified;
  int? recapture;

  GetSurveyPits({
    this.id,
    this.surveyId,
    this.rwhNo,
    this.rwhNumber,
    this.rwhLength,
    this.rwhBreadth,
    this.rwhDepth,
    this.rwhWorkingStatus,
    this.updateReason,
    this.imagePath,
    this.latitude,
    this.longitude,
    this.createdId,
    this.created,
    this.modifiedId,
    this.modified,
    this.recapture,
  });

  GetSurveyPits.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    surveyId = json['survey_id'];
    rwhNo = json['rwh_no'];
    rwhNumber = json['rwh_number'];
    rwhLength = json['rwh_length'];
    rwhBreadth = json['rwh_breadth'];
    rwhDepth = json['rwh_depth'];
    rwhWorkingStatus = json['rwh_working_status'];
    updateReason = json['update_reason'];
    imagePath = json['image_path'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    createdId = json['created_id'];
    created = json['created'];
    modifiedId = json['modified_id'];
    modified = json['modified'];
    recapture = json['recapture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['survey_id'] = surveyId;
    data['rwh_no'] = rwhNo;
    data['rwh_number'] = rwhNumber;
    data['rwh_length'] = rwhLength;
    data['rwh_breadth'] = rwhBreadth;
    data['rwh_depth'] = rwhDepth;
    data['rwh_working_status'] = rwhWorkingStatus;
    data['update_reason'] = updateReason;
    data['image_path'] = imagePath;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['created_id'] = createdId;
    data['created'] = created;
    data['modified_id'] = modifiedId;
    data['modified'] = modified;
    data['recapture'] = recapture;
    return data;
  }
}
