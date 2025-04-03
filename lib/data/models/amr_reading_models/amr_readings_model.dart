class AmrReadingsGetModel {
  int? error;
  List<CanReadings>? canReadings;

  AmrReadingsGetModel({this.error, this.canReadings});

  AmrReadingsGetModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    if (json['can_readings'] != null) {
      canReadings = <CanReadings>[];
      json['can_readings'].forEach((v) {
        canReadings!.add(CanReadings.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['error'] = error;
    if (canReadings != null) {
      data['can_readings'] = canReadings!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CanReadings {
  double? reading;
  String? readingDate;

  CanReadings({this.reading, this.readingDate});

  CanReadings.fromJson(Map<String, dynamic> json) {
    // reading = json['reading'];
    // Explicitly convert reading to double
    reading = (json['reading'] as num).toDouble();
    readingDate = json['reading_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['reading'] = reading;
    data['reading_date'] = readingDate;
    return data;
  }
}
