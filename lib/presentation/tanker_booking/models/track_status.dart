// error : 0
// booking : {"id":7409,"consumer_name":null,"latitude":null,"longitude":null,"bookingdate":null,"requireddate":"26-04-2024 12:00:00 AM","token_number":4440,"pin_number":9657,"booking_status":4,"queue_number":null,"vehicle_no":"TS07UB3530","driver_name":"Rajpoot Bhagvan Singh","driver_phone":"7670984050","last_latitude":"17.4456514","last_longitude":"78.382862"}

class TrackStatus {
  TrackStatus({
    num? error,
    Booking? booking,
    String? virtualNumber,
  }) {
    _error = error;
    _booking = booking;
    _virtualNumber = virtualNumber;
  }

  TrackStatus.fromJson(dynamic json) {
    _error = json['error'];
    _booking =
        json['booking'] != null ? Booking.fromJson(json['booking']) : null;
    _virtualNumber = json['virtual_number'];
  }
  num? _error;
  Booking? _booking;
  String? _virtualNumber;
  TrackStatus copyWith({
    num? error,
    Booking? booking,
    String? virtualNumber,
  }) =>
      TrackStatus(
        error: error ?? _error,
        booking: booking ?? _booking,
        virtualNumber: virtualNumber ?? _virtualNumber,
      );
  num? get error => _error;
  Booking? get booking => _booking;
  String? get virtualNumber => _virtualNumber;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    if (_booking != null) {
      map['booking'] = _booking?.toJson();
    }
    map['virtual_number'] = _virtualNumber;
    return map;
  }
}

/// id : 7409
/// consumer_name : null
/// latitude : null
/// longitude : null
/// bookingdate : null
/// requireddate : "26-04-2024 12:00:00 AM"
/// token_number : 4440
/// pin_number : 9657
/// booking_status : 4
/// queue_number : null
/// vehicle_no : "TS07UB3530"
/// driver_name : "Rajpoot Bhagvan Singh"
/// driver_phone : "7670984050"
/// last_latitude : "17.4456514"
/// last_longitude : "78.382862"

class Booking {
  Booking({
    num? id,
    dynamic consumerName,
    dynamic latitude,
    dynamic longitude,
    dynamic bookingdate,
    String? requireddate,
    String? tokenNumber,
    String? pinNumber,
    num? bookingStatus,
    dynamic queueNumber,
    String? vehicleNo,
    String? driverName,
    String? driverPhone,
    String? lastLatitude,
    String? lastLongitude,
    String? bearing,
    String? fillingStationName,
    String? fillingStationLatitude,
    String? fillingStationLongitude,
    String? customerCopyUrl,
  }) {
    _id = id;
    _consumerName = consumerName;
    _latitude = latitude;
    _longitude = longitude;
    _bookingdate = bookingdate;
    _requireddate = requireddate;
    _tokenNumber = tokenNumber;
    _pinNumber = pinNumber;
    _bookingStatus = bookingStatus;
    _queueNumber = queueNumber;
    _vehicleNo = vehicleNo;
    _driverName = driverName;
    _driverPhone = driverPhone;
    _lastLatitude = lastLatitude;
    _lastLongitude = lastLongitude;
    _bearing = bearing;
    _fillingStationName = fillingStationName;
    _fillingStationLatitude = fillingStationLatitude;
    _fillingStationLongitude = fillingStationLongitude;
    _customerCopyUrl = customerCopyUrl;
  }

  Booking.fromJson(dynamic json) {
    _id = json['id'];
    _consumerName = json['consumer_name'].toString();
    _latitude = json['latitude'].toString();
    _longitude = json['longitude'].toString();
    _bookingdate = json['bookingdate'].toString();
    _requireddate = json['requireddate'].toString();
    _tokenNumber = json['token_number'].toString();
    _pinNumber = json['pin_number'].toString();
    _bookingStatus = json['booking_status'];
    _queueNumber = json['queue_number'].toString();
    _vehicleNo = json['vehicle_no'].toString();
    _driverName = json['driver_name'].toString();
    _driverPhone = json['driver_phone'].toString();
    _lastLatitude = json['last_latitude'].toString();
    _lastLongitude = json['last_longitude'].toString();
    _bearing = json['bearing'].toString();
    _fillingStationName = json['filling_station_name'].toString();
    _fillingStationLatitude = json['filling_station_latitude'].toString();
    _fillingStationLongitude = json['filling_station_longitude'].toString();
    _customerCopyUrl = json['customer_copy_url'];
  }
  num? _id;
  dynamic _consumerName;
  dynamic _latitude;
  dynamic _longitude;
  dynamic _bookingdate;
  String? _requireddate;
  String? _tokenNumber;
  String? _pinNumber;
  num? _bookingStatus;
  dynamic _queueNumber;
  String? _vehicleNo;
  String? _driverName;
  String? _driverPhone;
  String? _lastLatitude;
  String? _lastLongitude;
  String? _bearing;
  String? _fillingStationName;
  String? _fillingStationLatitude;
  String? _fillingStationLongitude;
  String? _customerCopyUrl;

  Booking copyWith({
    num? id,
    dynamic consumerName,
    dynamic latitude,
    dynamic longitude,
    dynamic bookingdate,
    String? requireddate,
    String? tokenNumber,
    String? pinNumber,
    num? bookingStatus,
    dynamic queueNumber,
    String? vehicleNo,
    String? driverName,
    String? driverPhone,
    String? lastLatitude,
    String? lastLongitude,
    String? bearing,
    String? fillingStationName,
    String? fillingStationLatitude,
    String? fillingStationLongitude,
    String? customerCopyUrl,
  }) =>
      Booking(
        id: id ?? _id,
        consumerName: consumerName ?? _consumerName,
        latitude: latitude ?? _latitude,
        longitude: longitude ?? _longitude,
        bookingdate: bookingdate ?? _bookingdate,
        requireddate: requireddate ?? _requireddate,
        tokenNumber: tokenNumber ?? _tokenNumber,
        pinNumber: pinNumber ?? _pinNumber,
        bookingStatus: bookingStatus ?? _bookingStatus,
        queueNumber: queueNumber ?? _queueNumber,
        vehicleNo: vehicleNo ?? _vehicleNo,
        driverName: driverName ?? _driverName,
        driverPhone: driverPhone ?? _driverPhone,
        lastLatitude: lastLatitude ?? _lastLatitude,
        lastLongitude: lastLongitude ?? _lastLongitude,
        bearing: bearing ?? _bearing,
        fillingStationName: fillingStationName ?? _fillingStationName,
        fillingStationLatitude:
            fillingStationLatitude ?? _fillingStationLatitude,
        fillingStationLongitude:
            fillingStationLongitude ?? _fillingStationLongitude,
        customerCopyUrl: customerCopyUrl ?? _customerCopyUrl,
      );
  num? get id => _id;
  dynamic get consumerName => _consumerName;
  dynamic get latitude => _latitude;
  dynamic get longitude => _longitude;
  dynamic get bookingdate => _bookingdate;
  String? get requireddate => _requireddate;
  String? get tokenNumber => _tokenNumber;
  String? get pinNumber => _pinNumber;
  num? get bookingStatus => _bookingStatus;
  dynamic get queueNumber => _queueNumber;
  String? get vehicleNo => _vehicleNo;
  String? get driverName => _driverName;
  String? get driverPhone => _driverPhone;
  String? get lastLatitude => _lastLatitude;
  String? get lastLongitude => _lastLongitude;
  String? get bearing => _bearing;
  String? get fillingStationName => _fillingStationName;
  String? get fillingStationLatitude => _fillingStationLatitude;
  String? get fillingStationLongitude => _fillingStationLongitude;
  String? get customerCopyUrl => _customerCopyUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['consumer_name'] = _consumerName;
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;
    map['bookingdate'] = _bookingdate;
    map['requireddate'] = _requireddate;
    map['token_number'] = _tokenNumber;
    map['pin_number'] = _pinNumber;
    map['booking_status'] = _bookingStatus;
    map['queue_number'] = _queueNumber;
    map['vehicle_no'] = _vehicleNo;
    map['driver_name'] = _driverName;
    map['driver_phone'] = _driverPhone;
    map['last_latitude'] = _lastLatitude;
    map['last_longitude'] = _lastLongitude;
    map['bearing'] = _bearing;
    map['filling_station_name'] = _fillingStationName;
    map['filling_station_latitude'] = fillingStationLatitude;
    map['filling_station_longitude'] = fillingStationLongitude;
    map['customer_copy_url'] = _customerCopyUrl;
    return map;
  }
}
