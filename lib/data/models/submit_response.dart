// error : 0
// message : "Saved successsfully"

class SubmitResponse {
  SubmitResponse({
      num? error, 
      String? message,}){
    _error = error;
    _message = message;
}

  SubmitResponse.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
  }
  num? _error;
  String? _message;
SubmitResponse copyWith({  num? error,
  String? message,
}) => SubmitResponse(  error: error ?? _error,
  message: message ?? _message,
);
  num? get error => _error;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    map['message'] = _message;
    return map;
  }

}