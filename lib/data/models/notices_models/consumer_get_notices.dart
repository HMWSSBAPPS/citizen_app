class ConsumerGetNoticesModel {
  int? error;
  List<NoticesModel>? notices;

  ConsumerGetNoticesModel({this.error, this.notices});

  ConsumerGetNoticesModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    if (json['notices'] != null) {
      notices = <NoticesModel>[];
      json['notices'].forEach((v) {
        notices!.add(NoticesModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['error'] = error;
    if (notices != null) {
      data['notices'] = notices!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NoticesModel {
  int? id;
  String? canNumber;
  String? agency;
  String? pipeSize;
  String? meterMake;
  String? reading;
  String? generatedDate;
  String? sentDate;
  String? notice;
  String? takeReply;

  NoticesModel(
      {this.id,
      this.canNumber,
      this.agency,
      this.pipeSize,
      this.meterMake,
      this.reading,
      this.generatedDate,
      this.sentDate,
      this.notice,
      this.takeReply});

  NoticesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    canNumber = json['can_number'];
    agency = json['agency'];
    pipeSize = json['pipe_size'];
    meterMake = json['meter_make'];
    reading = json['reading'];
    generatedDate = json['generated_date'];
    sentDate = json['sent_date'];
    notice = json['notice'];
    takeReply = json['take_reply'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['can_number'] = canNumber;
    data['agency'] = agency;
    data['pipe_size'] = pipeSize;
    data['meter_make'] = meterMake;
    data['reading'] = reading;
    data['generated_date'] = generatedDate;
    data['sent_date'] = sentDate;
    data['notice'] = notice;
    data['take_reply'] = takeReply;
    return data;
  }
}
