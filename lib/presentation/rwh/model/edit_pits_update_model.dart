class RWHPitsDetailsUpdateModel {
  int? id;
  int? rwhLength;
  int? rwhBreadth;
  int? rwhDepth;
  String? rwhWorkingStatus;
  double? latitude;
  double? longitude;
  String? updateReason;
  String? image;

  RWHPitsDetailsUpdateModel({
    required this.id,
    required this.rwhLength,
    required this.rwhBreadth,
    required this.rwhDepth,
    required this.rwhWorkingStatus,
    required this.latitude,
    required this.longitude,
    required this.updateReason,
    required this.image,
  });

  RWHPitsDetailsUpdateModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rwhLength = json['rwh_length'];
    rwhBreadth = json['rwh_breadth'];
    rwhDepth = json['rwh_depth'];
    rwhWorkingStatus = json['rwh_working_status'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    updateReason = json['update_reason'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['rwh_length'] = rwhLength;
    data['rwh_breadth'] = rwhBreadth;
    data['rwh_depth'] = rwhDepth;
    data['rwh_working_status'] = rwhWorkingStatus;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['update_reason'] = updateReason;
    data['image'] = image;
    return data;
  }
}
