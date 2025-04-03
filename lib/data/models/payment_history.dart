// m_Item1 : {"ResponseCode":"302","ResponseType":"Parameter validation","Description":"Invalid CAN - 62055727"}
// m_Item2 : [{"CAN":"620557270","TransactionDate":"2023-04-07T00:00:00","TransactionNumber":"138171124","TransactionType":"WaterBillDemand","MeterCategory":"D","FromMonth":"MAR-23","ToMonth":"MAR-23","MeterStatus":"M","ReadingDate":"0001-01-01T00:00:00","CurrentReading":375,"ChargedQty":15.0,"Consumption":0,"TransactionAmount":242.50,"CreditAmount":0.00,"DebitAmount":242.50,"IsCreditTransaction":false,"OtherCharges":0.0,"BalanceAmount":0.0,"WaterCess":0.0,"SewCess":0.0,"ServiceCharges":0.0,"ChequeDate":"0001-01-01T00:00:00","NoOfMonths":"1","MeterReadingDate":"07/04/2023","PDFlink":"https://test3.hyderabadwater.gov.in/DownloadBills/042023/620557270.pdf","FWSTOTALREBATE":0.0}]

class PaymentHistory {
  PaymentHistory({
      MItem1? mItem1, 
      List<MItem2>? mItem2,}){
    _mItem1 = mItem1;
    _mItem2 = mItem2;
}

  PaymentHistory.fromJson(dynamic json) {
    _mItem1 = json['m_Item1'] != null ? MItem1.fromJson(json['m_Item1']) : null;
    if (json['m_Item2'] != null) {
      _mItem2 = [];
      json['m_Item2'].forEach((v) {
        _mItem2?.add(MItem2.fromJson(v));
      });
    }
  }
  MItem1? _mItem1;
  List<MItem2>? _mItem2;
PaymentHistory copyWith({  MItem1? mItem1,
  List<MItem2>? mItem2,
}) => PaymentHistory(  mItem1: mItem1 ?? _mItem1,
  mItem2: mItem2 ?? _mItem2,
);
  MItem1? get mItem1 => _mItem1;
  List<MItem2>? get mItem2 => _mItem2;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_mItem1 != null) {
      map['m_Item1'] = _mItem1?.toJson();
    }
    if (_mItem2 != null) {
      map['m_Item2'] = _mItem2?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// CAN : "620557270"
/// TransactionDate : "2023-04-07T00:00:00"
/// TransactionNumber : "138171124"
/// TransactionType : "WaterBillDemand"
/// MeterCategory : "D"
/// FromMonth : "MAR-23"
/// ToMonth : "MAR-23"
/// MeterStatus : "M"
/// ReadingDate : "0001-01-01T00:00:00"
/// CurrentReading : 375
/// ChargedQty : 15.0
/// Consumption : 0
/// TransactionAmount : 242.50
/// CreditAmount : 0.00
/// DebitAmount : 242.50
/// IsCreditTransaction : false
/// OtherCharges : 0.0
/// BalanceAmount : 0.0
/// WaterCess : 0.0
/// SewCess : 0.0
/// ServiceCharges : 0.0
/// ChequeDate : "0001-01-01T00:00:00"
/// NoOfMonths : "1"
/// MeterReadingDate : "07/04/2023"
/// PDFlink : "https://test3.hyderabadwater.gov.in/DownloadBills/042023/620557270.pdf"
/// FWSTOTALREBATE : 0.0

class MItem2 {
  MItem2({
      String? can, 
      String? transactionDate, 
      String? transactionNumber, 
      String? transactionType, 
      String? meterCategory, 
      String? fromMonth, 
      String? toMonth, 
      String? meterStatus, 
      String? readingDate, 
      num? currentReading, 
      num? chargedQty, 
      num? consumption, 
      num? transactionAmount, 
      num? creditAmount, 
      num? debitAmount, 
      bool? isCreditTransaction, 
      num? otherCharges, 
      num? balanceAmount, 
      num? waterCess, 
      num? sewCess, 
      num? serviceCharges, 
      String? chequeDate, 
      String? noOfMonths, 
      String? meterReadingDate, 
      String? pDFlink, 
      num? fwstotalrebate,}){
    _can = can;
    _transactionDate = transactionDate;
    _transactionNumber = transactionNumber;
    _transactionType = transactionType;
    _meterCategory = meterCategory;
    _fromMonth = fromMonth;
    _toMonth = toMonth;
    _meterStatus = meterStatus;
    _readingDate = readingDate;
    _currentReading = currentReading;
    _chargedQty = chargedQty;
    _consumption = consumption;
    _transactionAmount = transactionAmount;
    _creditAmount = creditAmount;
    _debitAmount = debitAmount;
    _isCreditTransaction = isCreditTransaction;
    _otherCharges = otherCharges;
    _balanceAmount = balanceAmount;
    _waterCess = waterCess;
    _sewCess = sewCess;
    _serviceCharges = serviceCharges;
    _chequeDate = chequeDate;
    _noOfMonths = noOfMonths;
    _meterReadingDate = meterReadingDate;
    _pDFlink = pDFlink;
    _fwstotalrebate = fwstotalrebate;
}

  MItem2.fromJson(dynamic json) {
    _can = json['CAN'];
    _transactionDate = json['TransactionDate'];
    _transactionNumber = json['TransactionNumber'];
    _transactionType = json['TransactionType'];
    _meterCategory = json['MeterCategory'];
    _fromMonth = json['FromMonth'];
    _toMonth = json['ToMonth'];
    _meterStatus = json['MeterStatus'];
    _readingDate = json['ReadingDate'];
    _currentReading = json['CurrentReading'];
    _chargedQty = json['ChargedQty'];
    _consumption = json['Consumption'];
    _transactionAmount = json['TransactionAmount'];
    _creditAmount = json['CreditAmount'];
    _debitAmount = json['DebitAmount'];
    _isCreditTransaction = json['IsCreditTransaction'];
    _otherCharges = json['OtherCharges'];
    _balanceAmount = json['BalanceAmount'];
    _waterCess = json['WaterCess'];
    _sewCess = json['SewCess'];
    _serviceCharges = json['ServiceCharges'];
    _chequeDate = json['ChequeDate'];
    _noOfMonths = json['NoOfMonths'];
    _meterReadingDate = json['MeterReadingDate'];
    _pDFlink = json['PDFlink'];
    _fwstotalrebate = json['FWSTOTALREBATE'];
  }
  String? _can;
  String? _transactionDate;
  String? _transactionNumber;
  String? _transactionType;
  String? _meterCategory;
  String? _fromMonth;
  String? _toMonth;
  String? _meterStatus;
  String? _readingDate;
  num? _currentReading;
  num? _chargedQty;
  num? _consumption;
  num? _transactionAmount;
  num? _creditAmount;
  num? _debitAmount;
  bool? _isCreditTransaction;
  num? _otherCharges;
  num? _balanceAmount;
  num? _waterCess;
  num? _sewCess;
  num? _serviceCharges;
  String? _chequeDate;
  String? _noOfMonths;
  String? _meterReadingDate;
  String? _pDFlink;
  num? _fwstotalrebate;
MItem2 copyWith({  String? can,
  String? transactionDate,
  String? transactionNumber,
  String? transactionType,
  String? meterCategory,
  String? fromMonth,
  String? toMonth,
  String? meterStatus,
  String? readingDate,
  num? currentReading,
  num? chargedQty,
  num? consumption,
  num? transactionAmount,
  num? creditAmount,
  num? debitAmount,
  bool? isCreditTransaction,
  num? otherCharges,
  num? balanceAmount,
  num? waterCess,
  num? sewCess,
  num? serviceCharges,
  String? chequeDate,
  String? noOfMonths,
  String? meterReadingDate,
  String? pDFlink,
  num? fwstotalrebate,
}) => MItem2(  can: can ?? _can,
  transactionDate: transactionDate ?? _transactionDate,
  transactionNumber: transactionNumber ?? _transactionNumber,
  transactionType: transactionType ?? _transactionType,
  meterCategory: meterCategory ?? _meterCategory,
  fromMonth: fromMonth ?? _fromMonth,
  toMonth: toMonth ?? _toMonth,
  meterStatus: meterStatus ?? _meterStatus,
  readingDate: readingDate ?? _readingDate,
  currentReading: currentReading ?? _currentReading,
  chargedQty: chargedQty ?? _chargedQty,
  consumption: consumption ?? _consumption,
  transactionAmount: transactionAmount ?? _transactionAmount,
  creditAmount: creditAmount ?? _creditAmount,
  debitAmount: debitAmount ?? _debitAmount,
  isCreditTransaction: isCreditTransaction ?? _isCreditTransaction,
  otherCharges: otherCharges ?? _otherCharges,
  balanceAmount: balanceAmount ?? _balanceAmount,
  waterCess: waterCess ?? _waterCess,
  sewCess: sewCess ?? _sewCess,
  serviceCharges: serviceCharges ?? _serviceCharges,
  chequeDate: chequeDate ?? _chequeDate,
  noOfMonths: noOfMonths ?? _noOfMonths,
  meterReadingDate: meterReadingDate ?? _meterReadingDate,
  pDFlink: pDFlink ?? _pDFlink,
  fwstotalrebate: fwstotalrebate ?? _fwstotalrebate,
);
  String? get can => _can;
  String? get transactionDate => _transactionDate;
  String? get transactionNumber => _transactionNumber;
  String? get transactionType => _transactionType;
  String? get meterCategory => _meterCategory;
  String? get fromMonth => _fromMonth;
  String? get toMonth => _toMonth;
  String? get meterStatus => _meterStatus;
  String? get readingDate => _readingDate;
  num? get currentReading => _currentReading;
  num? get chargedQty => _chargedQty;
  num? get consumption => _consumption;
  num? get transactionAmount => _transactionAmount;
  num? get creditAmount => _creditAmount;
  num? get debitAmount => _debitAmount;
  bool? get isCreditTransaction => _isCreditTransaction;
  num? get otherCharges => _otherCharges;
  num? get balanceAmount => _balanceAmount;
  num? get waterCess => _waterCess;
  num? get sewCess => _sewCess;
  num? get serviceCharges => _serviceCharges;
  String? get chequeDate => _chequeDate;
  String? get noOfMonths => _noOfMonths;
  String? get meterReadingDate => _meterReadingDate;
  String? get pDFlink => _pDFlink;
  num? get fwstotalrebate => _fwstotalrebate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['CAN'] = _can;
    map['TransactionDate'] = _transactionDate;
    map['TransactionNumber'] = _transactionNumber;
    map['TransactionType'] = _transactionType;
    map['MeterCategory'] = _meterCategory;
    map['FromMonth'] = _fromMonth;
    map['ToMonth'] = _toMonth;
    map['MeterStatus'] = _meterStatus;
    map['ReadingDate'] = _readingDate;
    map['CurrentReading'] = _currentReading;
    map['ChargedQty'] = _chargedQty;
    map['Consumption'] = _consumption;
    map['TransactionAmount'] = _transactionAmount;
    map['CreditAmount'] = _creditAmount;
    map['DebitAmount'] = _debitAmount;
    map['IsCreditTransaction'] = _isCreditTransaction;
    map['OtherCharges'] = _otherCharges;
    map['BalanceAmount'] = _balanceAmount;
    map['WaterCess'] = _waterCess;
    map['SewCess'] = _sewCess;
    map['ServiceCharges'] = _serviceCharges;
    map['ChequeDate'] = _chequeDate;
    map['NoOfMonths'] = _noOfMonths;
    map['MeterReadingDate'] = _meterReadingDate;
    map['PDFlink'] = _pDFlink;
    map['FWSTOTALREBATE'] = _fwstotalrebate;
    return map;
  }

}

/// ResponseCode : "302"
/// ResponseType : "Parameter validation"
/// Description : "Invalid CAN - 62055727"

class MItem1 {
  MItem1({
      String? responseCode, 
      String? responseType, 
      String? description,}){
    _responseCode = responseCode;
    _responseType = responseType;
    _description = description;
}

  MItem1.fromJson(dynamic json) {
    _responseCode = json['ResponseCode'];
    _responseType = json['ResponseType'];
    _description = json['Description'];
  }
  String? _responseCode;
  String? _responseType;
  String? _description;
MItem1 copyWith({  String? responseCode,
  String? responseType,
  String? description,
}) => MItem1(  responseCode: responseCode ?? _responseCode,
  responseType: responseType ?? _responseType,
  description: description ?? _description,
);
  String? get responseCode => _responseCode;
  String? get responseType => _responseType;
  String? get description => _description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ResponseCode'] = _responseCode;
    map['ResponseType'] = _responseType;
    map['Description'] = _description;
    return map;
  }

}