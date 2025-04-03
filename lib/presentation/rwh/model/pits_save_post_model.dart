class RWHPitsDetailsPostModel {
  String? canNumber;
  List<SurveyPits>? surveyPits;

  RWHPitsDetailsPostModel({this.canNumber, this.surveyPits});

  RWHPitsDetailsPostModel.fromJson(Map<String, dynamic> json) {
    canNumber = json['can_number'];
    if (json['survey_pits'] != null) {
      surveyPits = <SurveyPits>[];
      json['survey_pits'].forEach((v) {
        surveyPits!.add(SurveyPits.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['can_number'] = canNumber;
    if (surveyPits != null) {
      data['survey_pits'] = surveyPits!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SurveyPits {
  int? rwhLength;
  int? rwhBreadth;
  int? rwhDepth;
  String? rwhWorkingStatus;
  double? latitude;
  double? longitude;
  String? image;

  SurveyPits({
    required this.rwhLength,
    required this.rwhBreadth,
    required this.rwhDepth,
    required this.rwhWorkingStatus,
    required this.latitude,
    required this.longitude,
    required this.image,
  });

  SurveyPits.fromJson(Map<String, dynamic> json) {
    rwhLength = json['rwh_length'];
    rwhBreadth = json['rwh_breadth'];
    rwhDepth = json['rwh_depth'];
    rwhWorkingStatus = json['rwh_working_status'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rwh_length'] = rwhLength;
    data['rwh_breadth'] = rwhBreadth;
    data['rwh_depth'] = rwhDepth;
    data['rwh_working_status'] = rwhWorkingStatus;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['image'] = image;
    return data;
  }
}
