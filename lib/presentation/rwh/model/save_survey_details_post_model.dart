class RWHSurveyDetailsPostModel {
  String? canNumber;
  String? plotArea;
  String? houseType;
  double? latitude;
  double? longitude;
  int? noOfBorewells;
  int? noOfBorewellsWorking;
  int? borewellMinDepth;
  int? borewellMaxDepth;
  int? noOfTankersRequired;
  int? tankersBooked;
  // String? bookedByYou;
  String? rwhExists;
  int? noOfPits;
  String? buildingImage;

  RWHSurveyDetailsPostModel({
   required this.canNumber,
   required this.plotArea,
   required this.houseType,
   required this.latitude,
   required this.longitude,
   required this.noOfBorewells,
   required this.noOfBorewellsWorking,
   required this.borewellMinDepth,
   required this.borewellMaxDepth,
   required this.noOfTankersRequired,
   required this.tankersBooked,
  //  required this.bookedByYou,
   required this.rwhExists,
   required this.noOfPits,
   required this.buildingImage,
  });

  RWHSurveyDetailsPostModel.fromJson(Map<String, dynamic> json) {
    canNumber = json['can_number'];
    plotArea = json['plot_area'];
    houseType = json['house_type'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    noOfBorewells = json['no_of_borewells'];
    noOfBorewellsWorking = json['no_of_borewells_working'];
    borewellMinDepth = json['borewell_min_depth'];
    borewellMaxDepth = json['borewell_max_depth'];
    noOfTankersRequired = json['no_of_tankers_required'];
    tankersBooked = json['tankers_booked'];
    // bookedByYou = json['booked_by_you'];
    rwhExists = json['rwh_exists'];
    noOfPits = json['no_of_pits'];
    buildingImage = json['building_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['can_number'] = canNumber;
    data['plot_area'] = plotArea;
    data['house_type'] = houseType;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['no_of_borewells'] = noOfBorewells;
    data['no_of_borewells_working'] = noOfBorewellsWorking;
    data['borewell_min_depth'] = borewellMinDepth;
    data['borewell_max_depth'] = borewellMaxDepth;
    data['no_of_tankers_required'] = noOfTankersRequired;
    data['tankers_booked'] = tankersBooked;
    // data['booked_by_you'] = bookedByYou;
    data['rwh_exists'] = rwhExists;
    data['no_of_pits'] = noOfPits;
    data['building_image'] = buildingImage;
    return data;
  }
}
