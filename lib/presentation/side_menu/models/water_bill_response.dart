// m_Item1 : {"ResponseCode":"200","ResponseType":"Success","Description":""}
// m_Item2 : {"lastReadingBillMonth":"0001-01-01T00:00:00","previousReading":212,"lessConsumptionDueTo":0,"Can":"612665633","SAN":"612665633","CustomerName":"T.INDIRA","Address":"2-22-143/3,SUBHODYA COLONY,KUKATPALLY,KUKATPALLY,500054","MeterReaderCode":"30224","BillNo":138072050,"BillDate":"2023-04-04T00:00:00","DueDate":"2023-04-18T00:00:00","BillTime":"072743","SectionCode":"0917","DivisionCode":"9","SectionName":"BHAGYANAGAR","DateOfConnection":"0001-01-01T00:00:00","TariffCategoryCode":"D","TariffCategoryDescription":"DOMESTIC","MisCategoryCode":"","NoOfFlatsForMSB":0,"LastReadingBillMonth":"0001-01-01T00:00:00","PreviousReadingDate":"2023-03-04T00:00:00","LastReadingAverageConsumption":0,"PreviousBillAverageConsumption":31,"AvgConsumption":0,"AvgConsumptionForLinkedCan":0,"MonthlyAvgConsumption":0.0,"PreviousBillType":"\u0000","PreviousBillMonth":"0001-01-01T00:00:00","OriginalMeterStatus":"\u0000","FromMonth":"202303","ToMonth":"202303","NoOfMonths":1,"NoOfDays":0,"PipeSizeDescription":"15","MeterFixedDate":"0001-01-01T00:00:00","MeterNo":"","BillType":"M","PreviousReading":212,"PresentReadingDate":"2023-04-04T00:00:00","PresentReading":243,"IsSewerageApply":false,"IsMeterRepairSurhargeApply":false,"IsWaterSupply":false,"IsRebateApply":false,"Is24SurchargeApply":false,"ConsumedUnits":31,"ChargedUnits":31,"RolloverReading":0,"WaterCess":352.0,"SewerageCess":123.20,"ServiceChrge":40.0,"SurCharge24":0.0,"MeterRepairSurcharge":0.0,"Total":515.20,"ReversalAmount":0.0,"WaterCessReversalAmount":0.0,"SewerageCessReversalAmount":0.0,"ServicechargeReversalAmount":0.0,"RebateAmount":0.0,"LatePaymentFee":10.0,"MeterCost":0.0,"MeterRepairCharge":0.0,"OtherCharges":0.0,"VatAmount":0.0,"MeterCostInstMent":0.0,"ConnectionCharges":0.0,"ArrearInstllment":0.0,"AdditionalCharges":0.0,"CurrentMonthDemand":515.20,"Arrears":1391.73,"ArrearIntrest":20.27,"NetPay":1653.70,"LessConsumptionDueTo":0,"AgreedQuantity":0,"FullAdress":"T.INDIRA,\r\n,2-22-143/3,SUBHODYA COLONY,KUKATPALLY,KUKATPALLY,500054","GeneratedBy":"SBM-MR-30224","IsReversed":false,"NonWorkingDays":0,"MeterCondition":"M","upToMonth":"202303","IsMeterFixed":false,"SewTariffCategoryCode":"","SewTariffCategoryDescription":"","PlinthAreaInSqMts":0.0,"NoOfRoomsorBeds":0,"MobileNo":"8919092548","ExternalBillNo":"D000000164","IsConnectionOutsideGHMC":false,"SewerageRebateAmount":0.0,"SewerageRebatePercentage":0.0,"OCNotSubmitted":false,"OCPenaltyToDt":"0001-01-01T00:00:00","OCChargedFromDt":"0001-01-01T00:00:00","OCChargedToDt":"0001-01-01T00:00:00","NoofMthsbilledUnderOC":0,"OCWaterCess":0.0,"OCSewerageCess":0.0,"OCChargedUnits":0.0,"OCPenaltyIncludedInDemand":false,"ModeOfBilling":0,"MtrRprOrUnmtrdPenaltyAmount":0.0,"RprOrUnmtrdNoticeAckDt":"0001-01-01T00:00:00","MtrTamperPenaltyAmount":0.0,"HasAMRMeter":false,"IsAnyCourtCasePending":false,"CaseNo":"","CourtOrderDt":"0001-01-01T00:00:00","IsBoostingChargesApplicable":false,"BoostingCharges":0.0,"EmailId":"swethateetla@gmail.com","IsmtrDscntAplcble":false,"MeterDiscount":0.0,"RebateAmountFor20KLFreeWater":283.50,"PayableTotal":0.0,"PayableWaterCess":0.0,"PayableSewerageCess":0.0,"PayableServiceChrg":0.0,"FWSWaterCess":0.0,"FWSSewerageCess":0.0,"FWSServiceChrg":0.0,"FWSBoostingChrg":0.0,"FWSMtrRprORUnMtdPenaltyAmt":0.0,"ConnStatus":0,"ConnType":0,"IsGovtCAN":false,"BilledMonths":0.0,"BilledDays":0.0,"LastBillDate":"0001-01-01T00:00:00","NoOfFlatsRegForAadhar":0,"InitialReading":0,"TotalRebatePeriod":0.0,"AadharRegDate":"0001-01-01T00:00:00","IsProvisionalCAN":false,"FwsInstallmentarrears":0.0,"ArrearPriortofws":0.0,"NoOfFWSMonths":0,"NoOfNoneFWSMonths":0,"FWSInstallmentAmount":0.0,"FwsNetPayableAmount":0.0,"ISFwsInstallmentApply":0,"ReportReversalAmount":0.0,"SBMReversalAmount":0.0,"IsZeroBilling":false,"CurrentMonthDate":"0001-01-01T00:00:00","FWSPreDemand":0.0,"FWSTotalPreDemand":0.0,"FWSPreRebateAmount":0.0,"FWSTotalPreRebateAmount":0.0,"FWSCLLNAmount":0.0,"NonFWSTotalRebate":0.0,"NonFWSRebateWaterCess":0.0,"NonFWSRebateSewerageCess":0.0,"NonFWSRebateServiceChrg":0.0,"NonFWSTotalDemand":0.0,"NonFWSWaterCess":0.0,"NonFWSSewerageCess":0.0,"NonFWSServiceChrg":0.0,"PipeSizeWaterCess":0.0,"PipeSizeQuantityInKL":0.0,"IsSpecialBillingCan":false,"DomesticWaterCess":0.0,"CommercialPercantage":0}

class WaterBillResponse {
  WaterBillResponse({
    MItem1? mItem1,
    MItem2? mItem2,
  }) {
    _mItem1 = mItem1;
    _mItem2 = mItem2;
  }

  WaterBillResponse.fromJson(dynamic json) {
    _mItem1 = json['m_Item1'] != null ? MItem1.fromJson(json['m_Item1']) : null;
    _mItem2 = json['m_Item2'] != null ? MItem2.fromJson(json['m_Item2']) : null;
  }
  MItem1? _mItem1;
  MItem2? _mItem2;
  WaterBillResponse copyWith({
    MItem1? mItem1,
    MItem2? mItem2,
  }) =>
      WaterBillResponse(
        mItem1: mItem1 ?? _mItem1,
        mItem2: mItem2 ?? _mItem2,
      );
  MItem1? get mItem1 => _mItem1;
  MItem2? get mItem2 => _mItem2;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_mItem1 != null) {
      map['m_Item1'] = _mItem1?.toJson();
    }
    if (_mItem2 != null) {
      map['m_Item2'] = _mItem2?.toJson();
    }
    return map;
  }
}

/// lastReadingBillMonth : "0001-01-01T00:00:00"
/// previousReading : 212
/// lessConsumptionDueTo : 0
/// Can : "612665633"
/// SAN : "612665633"
/// CustomerName : "T.INDIRA"
/// Address : "2-22-143/3,SUBHODYA COLONY,KUKATPALLY,KUKATPALLY,500054"
/// MeterReaderCode : "30224"
/// BillNo : 138072050
/// BillDate : "2023-04-04T00:00:00"
/// DueDate : "2023-04-18T00:00:00"
/// BillTime : "072743"
/// SectionCode : "0917"
/// DivisionCode : "9"
/// SectionName : "BHAGYANAGAR"
/// DateOfConnection : "0001-01-01T00:00:00"
/// TariffCategoryCode : "D"
/// TariffCategoryDescription : "DOMESTIC"
/// MisCategoryCode : ""
/// NoOfFlatsForMSB : 0
/// LastReadingBillMonth : "0001-01-01T00:00:00"
/// PreviousReadingDate : "2023-03-04T00:00:00"
/// LastReadingAverageConsumption : 0
/// PreviousBillAverageConsumption : 31
/// AvgConsumption : 0
/// AvgConsumptionForLinkedCan : 0
/// MonthlyAvgConsumption : 0.0
/// PreviousBillType : "\u0000"
/// PreviousBillMonth : "0001-01-01T00:00:00"
/// OriginalMeterStatus : "\u0000"
/// FromMonth : "202303"
/// ToMonth : "202303"
/// NoOfMonths : 1
/// NoOfDays : 0
/// PipeSizeDescription : "15"
/// MeterFixedDate : "0001-01-01T00:00:00"
/// MeterNo : ""
/// BillType : "M"
/// PreviousReading : 212
/// PresentReadingDate : "2023-04-04T00:00:00"
/// PresentReading : 243
/// IsSewerageApply : false
/// IsMeterRepairSurhargeApply : false
/// IsWaterSupply : false
/// IsRebateApply : false
/// Is24SurchargeApply : false
/// ConsumedUnits : 31
/// ChargedUnits : 31
/// RolloverReading : 0
/// WaterCess : 352.0
/// SewerageCess : 123.20
/// ServiceChrge : 40.0
/// SurCharge24 : 0.0
/// MeterRepairSurcharge : 0.0
/// Total : 515.20
/// ReversalAmount : 0.0
/// WaterCessReversalAmount : 0.0
/// SewerageCessReversalAmount : 0.0
/// ServicechargeReversalAmount : 0.0
/// RebateAmount : 0.0
/// LatePaymentFee : 10.0
/// MeterCost : 0.0
/// MeterRepairCharge : 0.0
/// OtherCharges : 0.0
/// VatAmount : 0.0
/// MeterCostInstMent : 0.0
/// ConnectionCharges : 0.0
/// ArrearInstllment : 0.0
/// AdditionalCharges : 0.0
/// CurrentMonthDemand : 515.20
/// Arrears : 1391.73
/// ArrearIntrest : 20.27
/// NetPay : 1653.70
/// LessConsumptionDueTo : 0
/// AgreedQuantity : 0
/// FullAdress : "T.INDIRA,\r\n,2-22-143/3,SUBHODYA COLONY,KUKATPALLY,KUKATPALLY,500054"
/// GeneratedBy : "SBM-MR-30224"
/// IsReversed : false
/// NonWorkingDays : 0
/// MeterCondition : "M"
/// upToMonth : "202303"
/// IsMeterFixed : false
/// SewTariffCategoryCode : ""
/// SewTariffCategoryDescription : ""
/// PlinthAreaInSqMts : 0.0
/// NoOfRoomsorBeds : 0
/// MobileNo : "8919092548"
/// ExternalBillNo : "D000000164"
/// IsConnectionOutsideGHMC : false
/// SewerageRebateAmount : 0.0
/// SewerageRebatePercentage : 0.0
/// OCNotSubmitted : false
/// OCPenaltyToDt : "0001-01-01T00:00:00"
/// OCChargedFromDt : "0001-01-01T00:00:00"
/// OCChargedToDt : "0001-01-01T00:00:00"
/// NoofMthsbilledUnderOC : 0
/// OCWaterCess : 0.0
/// OCSewerageCess : 0.0
/// OCChargedUnits : 0.0
/// OCPenaltyIncludedInDemand : false
/// ModeOfBilling : 0
/// MtrRprOrUnmtrdPenaltyAmount : 0.0
/// RprOrUnmtrdNoticeAckDt : "0001-01-01T00:00:00"
/// MtrTamperPenaltyAmount : 0.0
/// HasAMRMeter : false
/// IsAnyCourtCasePending : false
/// CaseNo : ""
/// CourtOrderDt : "0001-01-01T00:00:00"
/// IsBoostingChargesApplicable : false
/// BoostingCharges : 0.0
/// EmailId : "swethateetla@gmail.com"
/// IsmtrDscntAplcble : false
/// MeterDiscount : 0.0
/// RebateAmountFor20KLFreeWater : 283.50
/// PayableTotal : 0.0
/// PayableWaterCess : 0.0
/// PayableSewerageCess : 0.0
/// PayableServiceChrg : 0.0
/// FWSWaterCess : 0.0
/// FWSSewerageCess : 0.0
/// FWSServiceChrg : 0.0
/// FWSBoostingChrg : 0.0
/// FWSMtrRprORUnMtdPenaltyAmt : 0.0
/// ConnStatus : 0
/// ConnType : 0
/// IsGovtCAN : false
/// BilledMonths : 0.0
/// BilledDays : 0.0
/// LastBillDate : "0001-01-01T00:00:00"
/// NoOfFlatsRegForAadhar : 0
/// InitialReading : 0
/// TotalRebatePeriod : 0.0
/// AadharRegDate : "0001-01-01T00:00:00"
/// IsProvisionalCAN : false
/// FwsInstallmentarrears : 0.0
/// ArrearPriortofws : 0.0
/// NoOfFWSMonths : 0
/// NoOfNoneFWSMonths : 0
/// FWSInstallmentAmount : 0.0
/// FwsNetPayableAmount : 0.0
/// ISFwsInstallmentApply : 0
/// ReportReversalAmount : 0.0
/// SBMReversalAmount : 0.0
/// IsZeroBilling : false
/// CurrentMonthDate : "0001-01-01T00:00:00"
/// FWSPreDemand : 0.0
/// FWSTotalPreDemand : 0.0
/// FWSPreRebateAmount : 0.0
/// FWSTotalPreRebateAmount : 0.0
/// FWSCLLNAmount : 0.0
/// NonFWSTotalRebate : 0.0
/// NonFWSRebateWaterCess : 0.0
/// NonFWSRebateSewerageCess : 0.0
/// NonFWSRebateServiceChrg : 0.0
/// NonFWSTotalDemand : 0.0
/// NonFWSWaterCess : 0.0
/// NonFWSSewerageCess : 0.0
/// NonFWSServiceChrg : 0.0
/// PipeSizeWaterCess : 0.0
/// PipeSizeQuantityInKL : 0.0
/// IsSpecialBillingCan : false
/// DomesticWaterCess : 0.0
/// CommercialPercantage : 0

class MItem2 {
  MItem2({
    String? lastReadingBillMonth,
    num? previousReading,
    num? lessConsumptionDueTo,
    String? can,
    String? san,
    String? customerName,
    String? address,
    String? meterReaderCode,
    num? billNo,
    String? billDate,
    String? dueDate,
    String? billTime,
    String? sectionCode,
    String? divisionCode,
    String? sectionName,
    String? dateOfConnection,
    String? tariffCategoryCode,
    String? tariffCategoryDescription,
    String? misCategoryCode,
    num? noOfFlatsForMSB,
    String? previousReadingDate,
    num? lastReadingAverageConsumption,
    num? previousBillAverageConsumption,
    num? avgConsumption,
    num? avgConsumptionForLinkedCan,
    num? monthlyAvgConsumption,
    String? previousBillType,
    String? previousBillMonth,
    String? originalMeterStatus,
    String? fromMonth,
    String? toMonth,
    num? noOfMonths,
    num? noOfDays,
    String? pipeSizeDescription,
    String? meterFixedDate,
    String? meterNo,
    String? billType,
    String? presentReadingDate,
    num? presentReading,
    bool? isSewerageApply,
    bool? isMeterRepairSurhargeApply,
    bool? isWaterSupply,
    bool? isRebateApply,
    bool? is24SurchargeApply,
    num? consumedUnits,
    num? chargedUnits,
    num? rolloverReading,
    num? waterCess,
    num? sewerageCess,
    num? serviceChrge,
    num? surCharge24,
    num? meterRepairSurcharge,
    num? total,
    num? reversalAmount,
    num? waterCessReversalAmount,
    num? sewerageCessReversalAmount,
    num? servicechargeReversalAmount,
    num? rebateAmount,
    num? latePaymentFee,
    num? meterCost,
    num? meterRepairCharge,
    num? otherCharges,
    num? vatAmount,
    num? meterCostInstMent,
    num? connectionCharges,
    num? arrearInstllment,
    num? additionalCharges,
    num? currentMonthDemand,
    num? arrears,
    num? arrearIntrest,
    num? netPay,
    num? agreedQuantity,
    String? fullAdress,
    String? generatedBy,
    bool? isReversed,
    num? nonWorkingDays,
    String? meterCondition,
    String? upToMonth,
    bool? isMeterFixed,
    String? sewTariffCategoryCode,
    String? sewTariffCategoryDescription,
    num? plinthAreaInSqMts,
    num? noOfRoomsorBeds,
    String? mobileNo,
    String? externalBillNo,
    bool? isConnectionOutsideGHMC,
    num? sewerageRebateAmount,
    num? sewerageRebatePercentage,
    bool? oCNotSubmitted,
    String? oCPenaltyToDt,
    String? oCChargedFromDt,
    String? oCChargedToDt,
    num? noofMthsbilledUnderOC,
    num? oCWaterCess,
    num? oCSewerageCess,
    num? oCChargedUnits,
    bool? oCPenaltyIncludedInDemand,
    num? modeOfBilling,
    num? mtrRprOrUnmtrdPenaltyAmount,
    String? rprOrUnmtrdNoticeAckDt,
    num? mtrTamperPenaltyAmount,
    bool? hasAMRMeter,
    bool? isAnyCourtCasePending,
    String? caseNo,
    String? courtOrderDt,
    bool? isBoostingChargesApplicable,
    num? boostingCharges,
    String? emailId,
    bool? ismtrDscntAplcble,
    num? meterDiscount,
    num? rebateAmountFor20KLFreeWater,
    num? payableTotal,
    num? payableWaterCess,
    num? payableSewerageCess,
    num? payableServiceChrg,
    num? fWSWaterCess,
    num? fWSSewerageCess,
    num? fWSServiceChrg,
    num? fWSBoostingChrg,
    num? fWSMtrRprORUnMtdPenaltyAmt,
    num? connStatus,
    num? connType,
    bool? isGovtCAN,
    num? billedMonths,
    num? billedDays,
    String? lastBillDate,
    num? noOfFlatsRegForAadhar,
    num? initialReading,
    num? totalRebatePeriod,
    String? aadharRegDate,
    bool? isProvisionalCAN,
    num? fwsInstallmentarrears,
    num? arrearPriortofws,
    num? noOfFWSMonths,
    num? noOfNoneFWSMonths,
    num? fWSInstallmentAmount,
    num? fwsNetPayableAmount,
    num? iSFwsInstallmentApply,
    num? reportReversalAmount,
    num? sBMReversalAmount,
    bool? isZeroBilling,
    String? currentMonthDate,
    num? fWSPreDemand,
    num? fWSTotalPreDemand,
    num? fWSPreRebateAmount,
    num? fWSTotalPreRebateAmount,
    num? fWSCLLNAmount,
    num? nonFWSTotalRebate,
    num? nonFWSRebateWaterCess,
    num? nonFWSRebateSewerageCess,
    num? nonFWSRebateServiceChrg,
    num? nonFWSTotalDemand,
    num? nonFWSWaterCess,
    num? nonFWSSewerageCess,
    num? nonFWSServiceChrg,
    num? pipeSizeWaterCess,
    num? pipeSizeQuantityInKL,
    bool? isSpecialBillingCan,
    num? domesticWaterCess,
    num? commercialPercantage,
  }) {
    _lastReadingBillMonth = lastReadingBillMonth;
    _previousReading = previousReading;
    _lessConsumptionDueTo = lessConsumptionDueTo;
    _can = can;
    _san = san;
    _customerName = customerName;
    _address = address;
    _meterReaderCode = meterReaderCode;
    _billNo = billNo;
    _billDate = billDate;
    _dueDate = dueDate;
    _billTime = billTime;
    _sectionCode = sectionCode;
    _divisionCode = divisionCode;
    _sectionName = sectionName;
    _dateOfConnection = dateOfConnection;
    _tariffCategoryCode = tariffCategoryCode;
    _tariffCategoryDescription = tariffCategoryDescription;
    _misCategoryCode = misCategoryCode;
    _noOfFlatsForMSB = noOfFlatsForMSB;
    _lastReadingBillMonth = lastReadingBillMonth;
    _previousReadingDate = previousReadingDate;
    _lastReadingAverageConsumption = lastReadingAverageConsumption;
    _previousBillAverageConsumption = previousBillAverageConsumption;
    _avgConsumption = avgConsumption;
    _avgConsumptionForLinkedCan = avgConsumptionForLinkedCan;
    _monthlyAvgConsumption = monthlyAvgConsumption;
    _previousBillType = previousBillType;
    _previousBillMonth = previousBillMonth;
    _originalMeterStatus = originalMeterStatus;
    _fromMonth = fromMonth;
    _toMonth = toMonth;
    _noOfMonths = noOfMonths;
    _noOfDays = noOfDays;
    _pipeSizeDescription = pipeSizeDescription;
    _meterFixedDate = meterFixedDate;
    _meterNo = meterNo;
    _billType = billType;
    _previousReading = previousReading;
    _presentReadingDate = presentReadingDate;
    _presentReading = presentReading;
    _isSewerageApply = isSewerageApply;
    _isMeterRepairSurhargeApply = isMeterRepairSurhargeApply;
    _isWaterSupply = isWaterSupply;
    _isRebateApply = isRebateApply;
    _is24SurchargeApply = is24SurchargeApply;
    _consumedUnits = consumedUnits;
    _chargedUnits = chargedUnits;
    _rolloverReading = rolloverReading;
    _waterCess = waterCess;
    _sewerageCess = sewerageCess;
    _serviceChrge = serviceChrge;
    _surCharge24 = surCharge24;
    _meterRepairSurcharge = meterRepairSurcharge;
    _total = total;
    _reversalAmount = reversalAmount;
    _waterCessReversalAmount = waterCessReversalAmount;
    _sewerageCessReversalAmount = sewerageCessReversalAmount;
    _servicechargeReversalAmount = servicechargeReversalAmount;
    _rebateAmount = rebateAmount;
    _latePaymentFee = latePaymentFee;
    _meterCost = meterCost;
    _meterRepairCharge = meterRepairCharge;
    _otherCharges = otherCharges;
    _vatAmount = vatAmount;
    _meterCostInstMent = meterCostInstMent;
    _connectionCharges = connectionCharges;
    _arrearInstllment = arrearInstllment;
    _additionalCharges = additionalCharges;
    _currentMonthDemand = currentMonthDemand;
    _arrears = arrears;
    _arrearIntrest = arrearIntrest;
    _netPay = netPay;
    _lessConsumptionDueTo = lessConsumptionDueTo;
    _agreedQuantity = agreedQuantity;
    _fullAdress = fullAdress;
    _generatedBy = generatedBy;
    _isReversed = isReversed;
    _nonWorkingDays = nonWorkingDays;
    _meterCondition = meterCondition;
    _upToMonth = upToMonth;
    _isMeterFixed = isMeterFixed;
    _sewTariffCategoryCode = sewTariffCategoryCode;
    _sewTariffCategoryDescription = sewTariffCategoryDescription;
    _plinthAreaInSqMts = plinthAreaInSqMts;
    _noOfRoomsorBeds = noOfRoomsorBeds;
    _mobileNo = mobileNo;
    _externalBillNo = externalBillNo;
    _isConnectionOutsideGHMC = isConnectionOutsideGHMC;
    _sewerageRebateAmount = sewerageRebateAmount;
    _sewerageRebatePercentage = sewerageRebatePercentage;
    _oCNotSubmitted = oCNotSubmitted;
    _oCPenaltyToDt = oCPenaltyToDt;
    _oCChargedFromDt = oCChargedFromDt;
    _oCChargedToDt = oCChargedToDt;
    _noofMthsbilledUnderOC = noofMthsbilledUnderOC;
    _oCWaterCess = oCWaterCess;
    _oCSewerageCess = oCSewerageCess;
    _oCChargedUnits = oCChargedUnits;
    _oCPenaltyIncludedInDemand = oCPenaltyIncludedInDemand;
    _modeOfBilling = modeOfBilling;
    _mtrRprOrUnmtrdPenaltyAmount = mtrRprOrUnmtrdPenaltyAmount;
    _rprOrUnmtrdNoticeAckDt = rprOrUnmtrdNoticeAckDt;
    _mtrTamperPenaltyAmount = mtrTamperPenaltyAmount;
    _hasAMRMeter = hasAMRMeter;
    _isAnyCourtCasePending = isAnyCourtCasePending;
    _caseNo = caseNo;
    _courtOrderDt = courtOrderDt;
    _isBoostingChargesApplicable = isBoostingChargesApplicable;
    _boostingCharges = boostingCharges;
    _emailId = emailId;
    _ismtrDscntAplcble = ismtrDscntAplcble;
    _meterDiscount = meterDiscount;
    _rebateAmountFor20KLFreeWater = rebateAmountFor20KLFreeWater;
    _payableTotal = payableTotal;
    _payableWaterCess = payableWaterCess;
    _payableSewerageCess = payableSewerageCess;
    _payableServiceChrg = payableServiceChrg;
    _fWSWaterCess = fWSWaterCess;
    _fWSSewerageCess = fWSSewerageCess;
    _fWSServiceChrg = fWSServiceChrg;
    _fWSBoostingChrg = fWSBoostingChrg;
    _fWSMtrRprORUnMtdPenaltyAmt = fWSMtrRprORUnMtdPenaltyAmt;
    _connStatus = connStatus;
    _connType = connType;
    _isGovtCAN = isGovtCAN;
    _billedMonths = billedMonths;
    _billedDays = billedDays;
    _lastBillDate = lastBillDate;
    _noOfFlatsRegForAadhar = noOfFlatsRegForAadhar;
    _initialReading = initialReading;
    _totalRebatePeriod = totalRebatePeriod;
    _aadharRegDate = aadharRegDate;
    _isProvisionalCAN = isProvisionalCAN;
    _fwsInstallmentarrears = fwsInstallmentarrears;
    _arrearPriortofws = arrearPriortofws;
    _noOfFWSMonths = noOfFWSMonths;
    _noOfNoneFWSMonths = noOfNoneFWSMonths;
    _fWSInstallmentAmount = fWSInstallmentAmount;
    _fwsNetPayableAmount = fwsNetPayableAmount;
    _iSFwsInstallmentApply = iSFwsInstallmentApply;
    _reportReversalAmount = reportReversalAmount;
    _sBMReversalAmount = sBMReversalAmount;
    _isZeroBilling = isZeroBilling;
    _currentMonthDate = currentMonthDate;
    _fWSPreDemand = fWSPreDemand;
    _fWSTotalPreDemand = fWSTotalPreDemand;
    _fWSPreRebateAmount = fWSPreRebateAmount;
    _fWSTotalPreRebateAmount = fWSTotalPreRebateAmount;
    _fWSCLLNAmount = fWSCLLNAmount;
    _nonFWSTotalRebate = nonFWSTotalRebate;
    _nonFWSRebateWaterCess = nonFWSRebateWaterCess;
    _nonFWSRebateSewerageCess = nonFWSRebateSewerageCess;
    _nonFWSRebateServiceChrg = nonFWSRebateServiceChrg;
    _nonFWSTotalDemand = nonFWSTotalDemand;
    _nonFWSWaterCess = nonFWSWaterCess;
    _nonFWSSewerageCess = nonFWSSewerageCess;
    _nonFWSServiceChrg = nonFWSServiceChrg;
    _pipeSizeWaterCess = pipeSizeWaterCess;
    _pipeSizeQuantityInKL = pipeSizeQuantityInKL;
    _isSpecialBillingCan = isSpecialBillingCan;
    _domesticWaterCess = domesticWaterCess;
    _commercialPercantage = commercialPercantage;
  }

  MItem2.fromJson(dynamic json) {
    _lastReadingBillMonth = json['lastReadingBillMonth'];
    _previousReading = json['previousReading'];
    _lessConsumptionDueTo = json['lessConsumptionDueTo'];
    _can = json['Can'];
    _san = json['SAN'];
    _customerName = json['CustomerName'];
    _address = json['Address'];
    _meterReaderCode = json['MeterReaderCode'];
    _billNo = json['BillNo'];
    _billDate = json['BillDate'];
    _dueDate = json['DueDate'];
    _billTime = json['BillTime'];
    _sectionCode = json['SectionCode'];
    _divisionCode = json['DivisionCode'];
    _sectionName = json['SectionName'];
    _dateOfConnection = json['DateOfConnection'];
    _tariffCategoryCode = json['TariffCategoryCode'];
    _tariffCategoryDescription = json['TariffCategoryDescription'];
    _misCategoryCode = json['MisCategoryCode'];
    _noOfFlatsForMSB = json['NoOfFlatsForMSB'];
    _lastReadingBillMonth = json['LastReadingBillMonth'];
    _previousReadingDate = json['PreviousReadingDate'];
    _lastReadingAverageConsumption = json['LastReadingAverageConsumption'];
    _previousBillAverageConsumption = json['PreviousBillAverageConsumption'];
    _avgConsumption = json['AvgConsumption'];
    _avgConsumptionForLinkedCan = json['AvgConsumptionForLinkedCan'];
    _monthlyAvgConsumption = json['MonthlyAvgConsumption'];
    _previousBillType = json['PreviousBillType'];
    _previousBillMonth = json['PreviousBillMonth'];
    _originalMeterStatus = json['OriginalMeterStatus'];
    _fromMonth = json['FromMonth'];
    _toMonth = json['ToMonth'];
    _noOfMonths = json['NoOfMonths'];
    _noOfDays = json['NoOfDays'];
    _pipeSizeDescription = json['PipeSizeDescription'];
    _meterFixedDate = json['MeterFixedDate'];
    _meterNo = json['MeterNo'];
    _billType = json['BillType'];
    _previousReading = json['PreviousReading'];
    _presentReadingDate = json['PresentReadingDate'];
    _presentReading = json['PresentReading'];
    _isSewerageApply = json['IsSewerageApply'];
    _isMeterRepairSurhargeApply = json['IsMeterRepairSurhargeApply'];
    _isWaterSupply = json['IsWaterSupply'];
    _isRebateApply = json['IsRebateApply'];
    _is24SurchargeApply = json['Is24SurchargeApply'];
    _consumedUnits = json['ConsumedUnits'];
    _chargedUnits = json['ChargedUnits'];
    _rolloverReading = json['RolloverReading'];
    _waterCess = json['WaterCess'];
    _sewerageCess = json['SewerageCess'];
    _serviceChrge = json['ServiceChrge'];
    _surCharge24 = json['SurCharge24'];
    _meterRepairSurcharge = json['MeterRepairSurcharge'];
    _total = json['Total'];
    _reversalAmount = json['ReversalAmount'];
    _waterCessReversalAmount = json['WaterCessReversalAmount'];
    _sewerageCessReversalAmount = json['SewerageCessReversalAmount'];
    _servicechargeReversalAmount = json['ServicechargeReversalAmount'];
    _rebateAmount = json['RebateAmount'];
    _latePaymentFee = json['LatePaymentFee'];
    _meterCost = json['MeterCost'];
    _meterRepairCharge = json['MeterRepairCharge'];
    _otherCharges = json['OtherCharges'];
    _vatAmount = json['VatAmount'];
    _meterCostInstMent = json['MeterCostInstMent'];
    _connectionCharges = json['ConnectionCharges'];
    _arrearInstllment = json['ArrearInstllment'];
    _additionalCharges = json['AdditionalCharges'];
    _currentMonthDemand = json['CurrentMonthDemand'];
    _arrears = json['Arrears'];
    _arrearIntrest = json['ArrearIntrest'];
    _netPay = json['NetPay'];
    _lessConsumptionDueTo = json['LessConsumptionDueTo'];
    _agreedQuantity = json['AgreedQuantity'];
    _fullAdress = json['FullAdress'];
    _generatedBy = json['GeneratedBy'];
    _isReversed = json['IsReversed'];
    _nonWorkingDays = json['NonWorkingDays'];
    _meterCondition = json['MeterCondition'];
    _upToMonth = json['upToMonth'];
    _isMeterFixed = json['IsMeterFixed'];
    _sewTariffCategoryCode = json['SewTariffCategoryCode'];
    _sewTariffCategoryDescription = json['SewTariffCategoryDescription'];
    _plinthAreaInSqMts = json['PlinthAreaInSqMts'];
    _noOfRoomsorBeds = json['NoOfRoomsorBeds'];
    _mobileNo = json['MobileNo'];
    _externalBillNo = json['ExternalBillNo'];
    _isConnectionOutsideGHMC = json['IsConnectionOutsideGHMC'];
    _sewerageRebateAmount = json['SewerageRebateAmount'];
    _sewerageRebatePercentage = json['SewerageRebatePercentage'];
    _oCNotSubmitted = json['OCNotSubmitted'];
    _oCPenaltyToDt = json['OCPenaltyToDt'];
    _oCChargedFromDt = json['OCChargedFromDt'];
    _oCChargedToDt = json['OCChargedToDt'];
    _noofMthsbilledUnderOC = json['NoofMthsbilledUnderOC'];
    _oCWaterCess = json['OCWaterCess'];
    _oCSewerageCess = json['OCSewerageCess'];
    _oCChargedUnits = json['OCChargedUnits'];
    _oCPenaltyIncludedInDemand = json['OCPenaltyIncludedInDemand'];
    _modeOfBilling = json['ModeOfBilling'];
    _mtrRprOrUnmtrdPenaltyAmount = json['MtrRprOrUnmtrdPenaltyAmount'];
    _rprOrUnmtrdNoticeAckDt = json['RprOrUnmtrdNoticeAckDt'];
    _mtrTamperPenaltyAmount = json['MtrTamperPenaltyAmount'];
    _hasAMRMeter = json['HasAMRMeter'];
    _isAnyCourtCasePending = json['IsAnyCourtCasePending'];
    _caseNo = json['CaseNo'];
    _courtOrderDt = json['CourtOrderDt'];
    _isBoostingChargesApplicable = json['IsBoostingChargesApplicable'];
    _boostingCharges = json['BoostingCharges'];
    _emailId = json['EmailId'];
    _ismtrDscntAplcble = json['IsmtrDscntAplcble'];
    _meterDiscount = json['MeterDiscount'];
    _rebateAmountFor20KLFreeWater = json['RebateAmountFor20KLFreeWater'];
    _payableTotal = json['PayableTotal'];
    _payableWaterCess = json['PayableWaterCess'];
    _payableSewerageCess = json['PayableSewerageCess'];
    _payableServiceChrg = json['PayableServiceChrg'];
    _fWSWaterCess = json['FWSWaterCess'];
    _fWSSewerageCess = json['FWSSewerageCess'];
    _fWSServiceChrg = json['FWSServiceChrg'];
    _fWSBoostingChrg = json['FWSBoostingChrg'];
    _fWSMtrRprORUnMtdPenaltyAmt = json['FWSMtrRprORUnMtdPenaltyAmt'];
    _connStatus = json['ConnStatus'];
    _connType = json['ConnType'];
    _isGovtCAN = json['IsGovtCAN'];
    _billedMonths = json['BilledMonths'];
    _billedDays = json['BilledDays'];
    _lastBillDate = json['LastBillDate'];
    _noOfFlatsRegForAadhar = json['NoOfFlatsRegForAadhar'];
    _initialReading = json['InitialReading'];
    _totalRebatePeriod = json['TotalRebatePeriod'];
    _aadharRegDate = json['AadharRegDate'];
    _isProvisionalCAN = json['IsProvisionalCAN'];
    _fwsInstallmentarrears = json['FwsInstallmentarrears'];
    _arrearPriortofws = json['ArrearPriortofws'];
    _noOfFWSMonths = json['NoOfFWSMonths'];
    _noOfNoneFWSMonths = json['NoOfNoneFWSMonths'];
    _fWSInstallmentAmount = json['FWSInstallmentAmount'];
    _fwsNetPayableAmount = json['FwsNetPayableAmount'];
    _iSFwsInstallmentApply = json['ISFwsInstallmentApply'];
    _reportReversalAmount = json['ReportReversalAmount'];
    _sBMReversalAmount = json['SBMReversalAmount'];
    _isZeroBilling = json['IsZeroBilling'];
    _currentMonthDate = json['CurrentMonthDate'];
    _fWSPreDemand = json['FWSPreDemand'];
    _fWSTotalPreDemand = json['FWSTotalPreDemand'];
    _fWSPreRebateAmount = json['FWSPreRebateAmount'];
    _fWSTotalPreRebateAmount = json['FWSTotalPreRebateAmount'];
    _fWSCLLNAmount = json['FWSCLLNAmount'];
    _nonFWSTotalRebate = json['NonFWSTotalRebate'];
    _nonFWSRebateWaterCess = json['NonFWSRebateWaterCess'];
    _nonFWSRebateSewerageCess = json['NonFWSRebateSewerageCess'];
    _nonFWSRebateServiceChrg = json['NonFWSRebateServiceChrg'];
    _nonFWSTotalDemand = json['NonFWSTotalDemand'];
    _nonFWSWaterCess = json['NonFWSWaterCess'];
    _nonFWSSewerageCess = json['NonFWSSewerageCess'];
    _nonFWSServiceChrg = json['NonFWSServiceChrg'];
    _pipeSizeWaterCess = json['PipeSizeWaterCess'];
    _pipeSizeQuantityInKL = json['PipeSizeQuantityInKL'];
    _isSpecialBillingCan = json['IsSpecialBillingCan'];
    _domesticWaterCess = json['DomesticWaterCess'];
    _commercialPercantage = json['CommercialPercantage'];
  }
  String? _lastReadingBillMonth;
  num? _previousReading;
  num? _lessConsumptionDueTo;
  String? _can;
  String? _san;
  String? _customerName;
  String? _address;
  String? _meterReaderCode;
  num? _billNo;
  String? _billDate;
  String? _dueDate;
  String? _billTime;
  String? _sectionCode;
  String? _divisionCode;
  String? _sectionName;
  String? _dateOfConnection;
  String? _tariffCategoryCode;
  String? _tariffCategoryDescription;
  String? _misCategoryCode;
  num? _noOfFlatsForMSB;
  String? _previousReadingDate;
  num? _lastReadingAverageConsumption;
  num? _previousBillAverageConsumption;
  num? _avgConsumption;
  num? _avgConsumptionForLinkedCan;
  num? _monthlyAvgConsumption;
  String? _previousBillType;
  String? _previousBillMonth;
  String? _originalMeterStatus;
  String? _fromMonth;
  String? _toMonth;
  num? _noOfMonths;
  num? _noOfDays;
  String? _pipeSizeDescription;
  String? _meterFixedDate;
  String? _meterNo;
  String? _billType;
  String? _presentReadingDate;
  num? _presentReading;
  bool? _isSewerageApply;
  bool? _isMeterRepairSurhargeApply;
  bool? _isWaterSupply;
  bool? _isRebateApply;
  bool? _is24SurchargeApply;
  num? _consumedUnits;
  num? _chargedUnits;
  num? _rolloverReading;
  num? _waterCess;
  num? _sewerageCess;
  num? _serviceChrge;
  num? _surCharge24;
  num? _meterRepairSurcharge;
  num? _total;
  num? _reversalAmount;
  num? _waterCessReversalAmount;
  num? _sewerageCessReversalAmount;
  num? _servicechargeReversalAmount;
  num? _rebateAmount;
  num? _latePaymentFee;
  num? _meterCost;
  num? _meterRepairCharge;
  num? _otherCharges;
  num? _vatAmount;
  num? _meterCostInstMent;
  num? _connectionCharges;
  num? _arrearInstllment;
  num? _additionalCharges;
  num? _currentMonthDemand;
  num? _arrears;
  num? _arrearIntrest;
  num? _netPay;
  num? _agreedQuantity;
  String? _fullAdress;
  String? _generatedBy;
  bool? _isReversed;
  num? _nonWorkingDays;
  String? _meterCondition;
  String? _upToMonth;
  bool? _isMeterFixed;
  String? _sewTariffCategoryCode;
  String? _sewTariffCategoryDescription;
  num? _plinthAreaInSqMts;
  num? _noOfRoomsorBeds;
  String? _mobileNo;
  String? _externalBillNo;
  bool? _isConnectionOutsideGHMC;
  num? _sewerageRebateAmount;
  num? _sewerageRebatePercentage;
  bool? _oCNotSubmitted;
  String? _oCPenaltyToDt;
  String? _oCChargedFromDt;
  String? _oCChargedToDt;
  num? _noofMthsbilledUnderOC;
  num? _oCWaterCess;
  num? _oCSewerageCess;
  num? _oCChargedUnits;
  bool? _oCPenaltyIncludedInDemand;
  num? _modeOfBilling;
  num? _mtrRprOrUnmtrdPenaltyAmount;
  String? _rprOrUnmtrdNoticeAckDt;
  num? _mtrTamperPenaltyAmount;
  bool? _hasAMRMeter;
  bool? _isAnyCourtCasePending;
  String? _caseNo;
  String? _courtOrderDt;
  bool? _isBoostingChargesApplicable;
  num? _boostingCharges;
  String? _emailId;
  bool? _ismtrDscntAplcble;
  num? _meterDiscount;
  num? _rebateAmountFor20KLFreeWater;
  num? _payableTotal;
  num? _payableWaterCess;
  num? _payableSewerageCess;
  num? _payableServiceChrg;
  num? _fWSWaterCess;
  num? _fWSSewerageCess;
  num? _fWSServiceChrg;
  num? _fWSBoostingChrg;
  num? _fWSMtrRprORUnMtdPenaltyAmt;
  num? _connStatus;
  num? _connType;
  bool? _isGovtCAN;
  num? _billedMonths;
  num? _billedDays;
  String? _lastBillDate;
  num? _noOfFlatsRegForAadhar;
  num? _initialReading;
  num? _totalRebatePeriod;
  String? _aadharRegDate;
  bool? _isProvisionalCAN;
  num? _fwsInstallmentarrears;
  num? _arrearPriortofws;
  num? _noOfFWSMonths;
  num? _noOfNoneFWSMonths;
  num? _fWSInstallmentAmount;
  num? _fwsNetPayableAmount;
  num? _iSFwsInstallmentApply;
  num? _reportReversalAmount;
  num? _sBMReversalAmount;
  bool? _isZeroBilling;
  String? _currentMonthDate;
  num? _fWSPreDemand;
  num? _fWSTotalPreDemand;
  num? _fWSPreRebateAmount;
  num? _fWSTotalPreRebateAmount;
  num? _fWSCLLNAmount;
  num? _nonFWSTotalRebate;
  num? _nonFWSRebateWaterCess;
  num? _nonFWSRebateSewerageCess;
  num? _nonFWSRebateServiceChrg;
  num? _nonFWSTotalDemand;
  num? _nonFWSWaterCess;
  num? _nonFWSSewerageCess;
  num? _nonFWSServiceChrg;
  num? _pipeSizeWaterCess;
  num? _pipeSizeQuantityInKL;
  bool? _isSpecialBillingCan;
  num? _domesticWaterCess;
  num? _commercialPercantage;
  MItem2 copyWith({
    String? lastReadingBillMonth,
    num? previousReading,
    num? lessConsumptionDueTo,
    String? can,
    String? san,
    String? customerName,
    String? address,
    String? meterReaderCode,
    num? billNo,
    String? billDate,
    String? dueDate,
    String? billTime,
    String? sectionCode,
    String? divisionCode,
    String? sectionName,
    String? dateOfConnection,
    String? tariffCategoryCode,
    String? tariffCategoryDescription,
    String? misCategoryCode,
    num? noOfFlatsForMSB,
    String? previousReadingDate,
    num? lastReadingAverageConsumption,
    num? previousBillAverageConsumption,
    num? avgConsumption,
    num? avgConsumptionForLinkedCan,
    num? monthlyAvgConsumption,
    String? previousBillType,
    String? previousBillMonth,
    String? originalMeterStatus,
    String? fromMonth,
    String? toMonth,
    num? noOfMonths,
    num? noOfDays,
    String? pipeSizeDescription,
    String? meterFixedDate,
    String? meterNo,
    String? billType,
    String? presentReadingDate,
    num? presentReading,
    bool? isSewerageApply,
    bool? isMeterRepairSurhargeApply,
    bool? isWaterSupply,
    bool? isRebateApply,
    bool? is24SurchargeApply,
    num? consumedUnits,
    num? chargedUnits,
    num? rolloverReading,
    num? waterCess,
    num? sewerageCess,
    num? serviceChrge,
    num? surCharge24,
    num? meterRepairSurcharge,
    num? total,
    num? reversalAmount,
    num? waterCessReversalAmount,
    num? sewerageCessReversalAmount,
    num? servicechargeReversalAmount,
    num? rebateAmount,
    num? latePaymentFee,
    num? meterCost,
    num? meterRepairCharge,
    num? otherCharges,
    num? vatAmount,
    num? meterCostInstMent,
    num? connectionCharges,
    num? arrearInstllment,
    num? additionalCharges,
    num? currentMonthDemand,
    num? arrears,
    num? arrearIntrest,
    num? netPay,
    num? agreedQuantity,
    String? fullAdress,
    String? generatedBy,
    bool? isReversed,
    num? nonWorkingDays,
    String? meterCondition,
    String? upToMonth,
    bool? isMeterFixed,
    String? sewTariffCategoryCode,
    String? sewTariffCategoryDescription,
    num? plinthAreaInSqMts,
    num? noOfRoomsorBeds,
    String? mobileNo,
    String? externalBillNo,
    bool? isConnectionOutsideGHMC,
    num? sewerageRebateAmount,
    num? sewerageRebatePercentage,
    bool? oCNotSubmitted,
    String? oCPenaltyToDt,
    String? oCChargedFromDt,
    String? oCChargedToDt,
    num? noofMthsbilledUnderOC,
    num? oCWaterCess,
    num? oCSewerageCess,
    num? oCChargedUnits,
    bool? oCPenaltyIncludedInDemand,
    num? modeOfBilling,
    num? mtrRprOrUnmtrdPenaltyAmount,
    String? rprOrUnmtrdNoticeAckDt,
    num? mtrTamperPenaltyAmount,
    bool? hasAMRMeter,
    bool? isAnyCourtCasePending,
    String? caseNo,
    String? courtOrderDt,
    bool? isBoostingChargesApplicable,
    num? boostingCharges,
    String? emailId,
    bool? ismtrDscntAplcble,
    num? meterDiscount,
    num? rebateAmountFor20KLFreeWater,
    num? payableTotal,
    num? payableWaterCess,
    num? payableSewerageCess,
    num? payableServiceChrg,
    num? fWSWaterCess,
    num? fWSSewerageCess,
    num? fWSServiceChrg,
    num? fWSBoostingChrg,
    num? fWSMtrRprORUnMtdPenaltyAmt,
    num? connStatus,
    num? connType,
    bool? isGovtCAN,
    num? billedMonths,
    num? billedDays,
    String? lastBillDate,
    num? noOfFlatsRegForAadhar,
    num? initialReading,
    num? totalRebatePeriod,
    String? aadharRegDate,
    bool? isProvisionalCAN,
    num? fwsInstallmentarrears,
    num? arrearPriortofws,
    num? noOfFWSMonths,
    num? noOfNoneFWSMonths,
    num? fWSInstallmentAmount,
    num? fwsNetPayableAmount,
    num? iSFwsInstallmentApply,
    num? reportReversalAmount,
    num? sBMReversalAmount,
    bool? isZeroBilling,
    String? currentMonthDate,
    num? fWSPreDemand,
    num? fWSTotalPreDemand,
    num? fWSPreRebateAmount,
    num? fWSTotalPreRebateAmount,
    num? fWSCLLNAmount,
    num? nonFWSTotalRebate,
    num? nonFWSRebateWaterCess,
    num? nonFWSRebateSewerageCess,
    num? nonFWSRebateServiceChrg,
    num? nonFWSTotalDemand,
    num? nonFWSWaterCess,
    num? nonFWSSewerageCess,
    num? nonFWSServiceChrg,
    num? pipeSizeWaterCess,
    num? pipeSizeQuantityInKL,
    bool? isSpecialBillingCan,
    num? domesticWaterCess,
    num? commercialPercantage,
  }) =>
      MItem2(
        lastReadingBillMonth: lastReadingBillMonth ?? _lastReadingBillMonth,
        previousReading: previousReading ?? _previousReading,
        lessConsumptionDueTo: lessConsumptionDueTo ?? _lessConsumptionDueTo,
        can: can ?? _can,
        san: san ?? _san,
        customerName: customerName ?? _customerName,
        address: address ?? _address,
        meterReaderCode: meterReaderCode ?? _meterReaderCode,
        billNo: billNo ?? _billNo,
        billDate: billDate ?? _billDate,
        dueDate: dueDate ?? _dueDate,
        billTime: billTime ?? _billTime,
        sectionCode: sectionCode ?? _sectionCode,
        divisionCode: divisionCode ?? _divisionCode,
        sectionName: sectionName ?? _sectionName,
        dateOfConnection: dateOfConnection ?? _dateOfConnection,
        tariffCategoryCode: tariffCategoryCode ?? _tariffCategoryCode,
        tariffCategoryDescription:
            tariffCategoryDescription ?? _tariffCategoryDescription,
        misCategoryCode: misCategoryCode ?? _misCategoryCode,
        noOfFlatsForMSB: noOfFlatsForMSB ?? _noOfFlatsForMSB,
        previousReadingDate: previousReadingDate ?? _previousReadingDate,
        lastReadingAverageConsumption:
            lastReadingAverageConsumption ?? _lastReadingAverageConsumption,
        previousBillAverageConsumption:
            previousBillAverageConsumption ?? _previousBillAverageConsumption,
        avgConsumption: avgConsumption ?? _avgConsumption,
        avgConsumptionForLinkedCan:
            avgConsumptionForLinkedCan ?? _avgConsumptionForLinkedCan,
        monthlyAvgConsumption: monthlyAvgConsumption ?? _monthlyAvgConsumption,
        previousBillType: previousBillType ?? _previousBillType,
        previousBillMonth: previousBillMonth ?? _previousBillMonth,
        originalMeterStatus: originalMeterStatus ?? _originalMeterStatus,
        fromMonth: fromMonth ?? _fromMonth,
        toMonth: toMonth ?? _toMonth,
        noOfMonths: noOfMonths ?? _noOfMonths,
        noOfDays: noOfDays ?? _noOfDays,
        pipeSizeDescription: pipeSizeDescription ?? _pipeSizeDescription,
        meterFixedDate: meterFixedDate ?? _meterFixedDate,
        meterNo: meterNo ?? _meterNo,
        billType: billType ?? _billType,
        presentReadingDate: presentReadingDate ?? _presentReadingDate,
        presentReading: presentReading ?? _presentReading,
        isSewerageApply: isSewerageApply ?? _isSewerageApply,
        isMeterRepairSurhargeApply:
            isMeterRepairSurhargeApply ?? _isMeterRepairSurhargeApply,
        isWaterSupply: isWaterSupply ?? _isWaterSupply,
        isRebateApply: isRebateApply ?? _isRebateApply,
        is24SurchargeApply: is24SurchargeApply ?? _is24SurchargeApply,
        consumedUnits: consumedUnits ?? _consumedUnits,
        chargedUnits: chargedUnits ?? _chargedUnits,
        rolloverReading: rolloverReading ?? _rolloverReading,
        waterCess: waterCess ?? _waterCess,
        sewerageCess: sewerageCess ?? _sewerageCess,
        serviceChrge: serviceChrge ?? _serviceChrge,
        surCharge24: surCharge24 ?? _surCharge24,
        meterRepairSurcharge: meterRepairSurcharge ?? _meterRepairSurcharge,
        total: total ?? _total,
        reversalAmount: reversalAmount ?? _reversalAmount,
        waterCessReversalAmount:
            waterCessReversalAmount ?? _waterCessReversalAmount,
        sewerageCessReversalAmount:
            sewerageCessReversalAmount ?? _sewerageCessReversalAmount,
        servicechargeReversalAmount:
            servicechargeReversalAmount ?? _servicechargeReversalAmount,
        rebateAmount: rebateAmount ?? _rebateAmount,
        latePaymentFee: latePaymentFee ?? _latePaymentFee,
        meterCost: meterCost ?? _meterCost,
        meterRepairCharge: meterRepairCharge ?? _meterRepairCharge,
        otherCharges: otherCharges ?? _otherCharges,
        vatAmount: vatAmount ?? _vatAmount,
        meterCostInstMent: meterCostInstMent ?? _meterCostInstMent,
        connectionCharges: connectionCharges ?? _connectionCharges,
        arrearInstllment: arrearInstllment ?? _arrearInstllment,
        additionalCharges: additionalCharges ?? _additionalCharges,
        currentMonthDemand: currentMonthDemand ?? _currentMonthDemand,
        arrears: arrears ?? _arrears,
        arrearIntrest: arrearIntrest ?? _arrearIntrest,
        netPay: netPay ?? _netPay,
        agreedQuantity: agreedQuantity ?? _agreedQuantity,
        fullAdress: fullAdress ?? _fullAdress,
        generatedBy: generatedBy ?? _generatedBy,
        isReversed: isReversed ?? _isReversed,
        nonWorkingDays: nonWorkingDays ?? _nonWorkingDays,
        meterCondition: meterCondition ?? _meterCondition,
        upToMonth: upToMonth ?? _upToMonth,
        isMeterFixed: isMeterFixed ?? _isMeterFixed,
        sewTariffCategoryCode: sewTariffCategoryCode ?? _sewTariffCategoryCode,
        sewTariffCategoryDescription:
            sewTariffCategoryDescription ?? _sewTariffCategoryDescription,
        plinthAreaInSqMts: plinthAreaInSqMts ?? _plinthAreaInSqMts,
        noOfRoomsorBeds: noOfRoomsorBeds ?? _noOfRoomsorBeds,
        mobileNo: mobileNo ?? _mobileNo,
        externalBillNo: externalBillNo ?? _externalBillNo,
        isConnectionOutsideGHMC:
            isConnectionOutsideGHMC ?? _isConnectionOutsideGHMC,
        sewerageRebateAmount: sewerageRebateAmount ?? _sewerageRebateAmount,
        sewerageRebatePercentage:
            sewerageRebatePercentage ?? _sewerageRebatePercentage,
        oCNotSubmitted: oCNotSubmitted ?? _oCNotSubmitted,
        oCPenaltyToDt: oCPenaltyToDt ?? _oCPenaltyToDt,
        oCChargedFromDt: oCChargedFromDt ?? _oCChargedFromDt,
        oCChargedToDt: oCChargedToDt ?? _oCChargedToDt,
        noofMthsbilledUnderOC: noofMthsbilledUnderOC ?? _noofMthsbilledUnderOC,
        oCWaterCess: oCWaterCess ?? _oCWaterCess,
        oCSewerageCess: oCSewerageCess ?? _oCSewerageCess,
        oCChargedUnits: oCChargedUnits ?? _oCChargedUnits,
        oCPenaltyIncludedInDemand:
            oCPenaltyIncludedInDemand ?? _oCPenaltyIncludedInDemand,
        modeOfBilling: modeOfBilling ?? _modeOfBilling,
        mtrRprOrUnmtrdPenaltyAmount:
            mtrRprOrUnmtrdPenaltyAmount ?? _mtrRprOrUnmtrdPenaltyAmount,
        rprOrUnmtrdNoticeAckDt:
            rprOrUnmtrdNoticeAckDt ?? _rprOrUnmtrdNoticeAckDt,
        mtrTamperPenaltyAmount:
            mtrTamperPenaltyAmount ?? _mtrTamperPenaltyAmount,
        hasAMRMeter: hasAMRMeter ?? _hasAMRMeter,
        isAnyCourtCasePending: isAnyCourtCasePending ?? _isAnyCourtCasePending,
        caseNo: caseNo ?? _caseNo,
        courtOrderDt: courtOrderDt ?? _courtOrderDt,
        isBoostingChargesApplicable:
            isBoostingChargesApplicable ?? _isBoostingChargesApplicable,
        boostingCharges: boostingCharges ?? _boostingCharges,
        emailId: emailId ?? _emailId,
        ismtrDscntAplcble: ismtrDscntAplcble ?? _ismtrDscntAplcble,
        meterDiscount: meterDiscount ?? _meterDiscount,
        rebateAmountFor20KLFreeWater:
            rebateAmountFor20KLFreeWater ?? _rebateAmountFor20KLFreeWater,
        payableTotal: payableTotal ?? _payableTotal,
        payableWaterCess: payableWaterCess ?? _payableWaterCess,
        payableSewerageCess: payableSewerageCess ?? _payableSewerageCess,
        payableServiceChrg: payableServiceChrg ?? _payableServiceChrg,
        fWSWaterCess: fWSWaterCess ?? _fWSWaterCess,
        fWSSewerageCess: fWSSewerageCess ?? _fWSSewerageCess,
        fWSServiceChrg: fWSServiceChrg ?? _fWSServiceChrg,
        fWSBoostingChrg: fWSBoostingChrg ?? _fWSBoostingChrg,
        fWSMtrRprORUnMtdPenaltyAmt:
            fWSMtrRprORUnMtdPenaltyAmt ?? _fWSMtrRprORUnMtdPenaltyAmt,
        connStatus: connStatus ?? _connStatus,
        connType: connType ?? _connType,
        isGovtCAN: isGovtCAN ?? _isGovtCAN,
        billedMonths: billedMonths ?? _billedMonths,
        billedDays: billedDays ?? _billedDays,
        lastBillDate: lastBillDate ?? _lastBillDate,
        noOfFlatsRegForAadhar: noOfFlatsRegForAadhar ?? _noOfFlatsRegForAadhar,
        initialReading: initialReading ?? _initialReading,
        totalRebatePeriod: totalRebatePeriod ?? _totalRebatePeriod,
        aadharRegDate: aadharRegDate ?? _aadharRegDate,
        isProvisionalCAN: isProvisionalCAN ?? _isProvisionalCAN,
        fwsInstallmentarrears: fwsInstallmentarrears ?? _fwsInstallmentarrears,
        arrearPriortofws: arrearPriortofws ?? _arrearPriortofws,
        noOfFWSMonths: noOfFWSMonths ?? _noOfFWSMonths,
        noOfNoneFWSMonths: noOfNoneFWSMonths ?? _noOfNoneFWSMonths,
        fWSInstallmentAmount: fWSInstallmentAmount ?? _fWSInstallmentAmount,
        fwsNetPayableAmount: fwsNetPayableAmount ?? _fwsNetPayableAmount,
        iSFwsInstallmentApply: iSFwsInstallmentApply ?? _iSFwsInstallmentApply,
        reportReversalAmount: reportReversalAmount ?? _reportReversalAmount,
        sBMReversalAmount: sBMReversalAmount ?? _sBMReversalAmount,
        isZeroBilling: isZeroBilling ?? _isZeroBilling,
        currentMonthDate: currentMonthDate ?? _currentMonthDate,
        fWSPreDemand: fWSPreDemand ?? _fWSPreDemand,
        fWSTotalPreDemand: fWSTotalPreDemand ?? _fWSTotalPreDemand,
        fWSPreRebateAmount: fWSPreRebateAmount ?? _fWSPreRebateAmount,
        fWSTotalPreRebateAmount:
            fWSTotalPreRebateAmount ?? _fWSTotalPreRebateAmount,
        fWSCLLNAmount: fWSCLLNAmount ?? _fWSCLLNAmount,
        nonFWSTotalRebate: nonFWSTotalRebate ?? _nonFWSTotalRebate,
        nonFWSRebateWaterCess: nonFWSRebateWaterCess ?? _nonFWSRebateWaterCess,
        nonFWSRebateSewerageCess:
            nonFWSRebateSewerageCess ?? _nonFWSRebateSewerageCess,
        nonFWSRebateServiceChrg:
            nonFWSRebateServiceChrg ?? _nonFWSRebateServiceChrg,
        nonFWSTotalDemand: nonFWSTotalDemand ?? _nonFWSTotalDemand,
        nonFWSWaterCess: nonFWSWaterCess ?? _nonFWSWaterCess,
        nonFWSSewerageCess: nonFWSSewerageCess ?? _nonFWSSewerageCess,
        nonFWSServiceChrg: nonFWSServiceChrg ?? _nonFWSServiceChrg,
        pipeSizeWaterCess: pipeSizeWaterCess ?? _pipeSizeWaterCess,
        pipeSizeQuantityInKL: pipeSizeQuantityInKL ?? _pipeSizeQuantityInKL,
        isSpecialBillingCan: isSpecialBillingCan ?? _isSpecialBillingCan,
        domesticWaterCess: domesticWaterCess ?? _domesticWaterCess,
        commercialPercantage: commercialPercantage ?? _commercialPercantage,
      );
  String? get lastReadingBillMonth => _lastReadingBillMonth;
  num? get previousReading => _previousReading;
  num? get lessConsumptionDueTo => _lessConsumptionDueTo;
  String? get can => _can;
  String? get san => _san;
  String? get customerName => _customerName;
  String? get address => _address;
  String? get meterReaderCode => _meterReaderCode;
  num? get billNo => _billNo;
  String? get billDate => _billDate;
  String? get dueDate => _dueDate;
  String? get billTime => _billTime;
  String? get sectionCode => _sectionCode;
  String? get divisionCode => _divisionCode;
  String? get sectionName => _sectionName;
  String? get dateOfConnection => _dateOfConnection;
  String? get tariffCategoryCode => _tariffCategoryCode;
  String? get tariffCategoryDescription => _tariffCategoryDescription;
  String? get misCategoryCode => _misCategoryCode;
  num? get noOfFlatsForMSB => _noOfFlatsForMSB;
  String? get previousReadingDate => _previousReadingDate;
  num? get lastReadingAverageConsumption => _lastReadingAverageConsumption;
  num? get previousBillAverageConsumption => _previousBillAverageConsumption;
  num? get avgConsumption => _avgConsumption;
  num? get avgConsumptionForLinkedCan => _avgConsumptionForLinkedCan;
  num? get monthlyAvgConsumption => _monthlyAvgConsumption;
  String? get previousBillType => _previousBillType;
  String? get previousBillMonth => _previousBillMonth;
  String? get originalMeterStatus => _originalMeterStatus;
  String? get fromMonth => _fromMonth;
  String? get toMonth => _toMonth;
  num? get noOfMonths => _noOfMonths;
  num? get noOfDays => _noOfDays;
  String? get pipeSizeDescription => _pipeSizeDescription;
  String? get meterFixedDate => _meterFixedDate;
  String? get meterNo => _meterNo;
  String? get billType => _billType;
  String? get presentReadingDate => _presentReadingDate;
  num? get presentReading => _presentReading;
  bool? get isSewerageApply => _isSewerageApply;
  bool? get isMeterRepairSurhargeApply => _isMeterRepairSurhargeApply;
  bool? get isWaterSupply => _isWaterSupply;
  bool? get isRebateApply => _isRebateApply;
  bool? get is24SurchargeApply => _is24SurchargeApply;
  num? get consumedUnits => _consumedUnits;
  num? get chargedUnits => _chargedUnits;
  num? get rolloverReading => _rolloverReading;
  num? get waterCess => _waterCess;
  num? get sewerageCess => _sewerageCess;
  num? get serviceChrge => _serviceChrge;
  num? get surCharge24 => _surCharge24;
  num? get meterRepairSurcharge => _meterRepairSurcharge;
  num? get total => _total;
  num? get reversalAmount => _reversalAmount;
  num? get waterCessReversalAmount => _waterCessReversalAmount;
  num? get sewerageCessReversalAmount => _sewerageCessReversalAmount;
  num? get servicechargeReversalAmount => _servicechargeReversalAmount;
  num? get rebateAmount => _rebateAmount;
  num? get latePaymentFee => _latePaymentFee;
  num? get meterCost => _meterCost;
  num? get meterRepairCharge => _meterRepairCharge;
  num? get otherCharges => _otherCharges;
  num? get vatAmount => _vatAmount;
  num? get meterCostInstMent => _meterCostInstMent;
  num? get connectionCharges => _connectionCharges;
  num? get arrearInstllment => _arrearInstllment;
  num? get additionalCharges => _additionalCharges;
  num? get currentMonthDemand => _currentMonthDemand;
  num? get arrears => _arrears;
  num? get arrearIntrest => _arrearIntrest;
  num? get netPay => _netPay;
  num? get agreedQuantity => _agreedQuantity;
  String? get fullAdress => _fullAdress;
  String? get generatedBy => _generatedBy;
  bool? get isReversed => _isReversed;
  num? get nonWorkingDays => _nonWorkingDays;
  String? get meterCondition => _meterCondition;
  String? get upToMonth => _upToMonth;
  bool? get isMeterFixed => _isMeterFixed;
  String? get sewTariffCategoryCode => _sewTariffCategoryCode;
  String? get sewTariffCategoryDescription => _sewTariffCategoryDescription;
  num? get plinthAreaInSqMts => _plinthAreaInSqMts;
  num? get noOfRoomsorBeds => _noOfRoomsorBeds;
  String? get mobileNo => _mobileNo;
  String? get externalBillNo => _externalBillNo;
  bool? get isConnectionOutsideGHMC => _isConnectionOutsideGHMC;
  num? get sewerageRebateAmount => _sewerageRebateAmount;
  num? get sewerageRebatePercentage => _sewerageRebatePercentage;
  bool? get oCNotSubmitted => _oCNotSubmitted;
  String? get oCPenaltyToDt => _oCPenaltyToDt;
  String? get oCChargedFromDt => _oCChargedFromDt;
  String? get oCChargedToDt => _oCChargedToDt;
  num? get noofMthsbilledUnderOC => _noofMthsbilledUnderOC;
  num? get oCWaterCess => _oCWaterCess;
  num? get oCSewerageCess => _oCSewerageCess;
  num? get oCChargedUnits => _oCChargedUnits;
  bool? get oCPenaltyIncludedInDemand => _oCPenaltyIncludedInDemand;
  num? get modeOfBilling => _modeOfBilling;
  num? get mtrRprOrUnmtrdPenaltyAmount => _mtrRprOrUnmtrdPenaltyAmount;
  String? get rprOrUnmtrdNoticeAckDt => _rprOrUnmtrdNoticeAckDt;
  num? get mtrTamperPenaltyAmount => _mtrTamperPenaltyAmount;
  bool? get hasAMRMeter => _hasAMRMeter;
  bool? get isAnyCourtCasePending => _isAnyCourtCasePending;
  String? get caseNo => _caseNo;
  String? get courtOrderDt => _courtOrderDt;
  bool? get isBoostingChargesApplicable => _isBoostingChargesApplicable;
  num? get boostingCharges => _boostingCharges;
  String? get emailId => _emailId;
  bool? get ismtrDscntAplcble => _ismtrDscntAplcble;
  num? get meterDiscount => _meterDiscount;
  num? get rebateAmountFor20KLFreeWater => _rebateAmountFor20KLFreeWater;
  num? get payableTotal => _payableTotal;
  num? get payableWaterCess => _payableWaterCess;
  num? get payableSewerageCess => _payableSewerageCess;
  num? get payableServiceChrg => _payableServiceChrg;
  num? get fWSWaterCess => _fWSWaterCess;
  num? get fWSSewerageCess => _fWSSewerageCess;
  num? get fWSServiceChrg => _fWSServiceChrg;
  num? get fWSBoostingChrg => _fWSBoostingChrg;
  num? get fWSMtrRprORUnMtdPenaltyAmt => _fWSMtrRprORUnMtdPenaltyAmt;
  num? get connStatus => _connStatus;
  num? get connType => _connType;
  bool? get isGovtCAN => _isGovtCAN;
  num? get billedMonths => _billedMonths;
  num? get billedDays => _billedDays;
  String? get lastBillDate => _lastBillDate;
  num? get noOfFlatsRegForAadhar => _noOfFlatsRegForAadhar;
  num? get initialReading => _initialReading;
  num? get totalRebatePeriod => _totalRebatePeriod;
  String? get aadharRegDate => _aadharRegDate;
  bool? get isProvisionalCAN => _isProvisionalCAN;
  num? get fwsInstallmentarrears => _fwsInstallmentarrears;
  num? get arrearPriortofws => _arrearPriortofws;
  num? get noOfFWSMonths => _noOfFWSMonths;
  num? get noOfNoneFWSMonths => _noOfNoneFWSMonths;
  num? get fWSInstallmentAmount => _fWSInstallmentAmount;
  num? get fwsNetPayableAmount => _fwsNetPayableAmount;
  num? get iSFwsInstallmentApply => _iSFwsInstallmentApply;
  num? get reportReversalAmount => _reportReversalAmount;
  num? get sBMReversalAmount => _sBMReversalAmount;
  bool? get isZeroBilling => _isZeroBilling;
  String? get currentMonthDate => _currentMonthDate;
  num? get fWSPreDemand => _fWSPreDemand;
  num? get fWSTotalPreDemand => _fWSTotalPreDemand;
  num? get fWSPreRebateAmount => _fWSPreRebateAmount;
  num? get fWSTotalPreRebateAmount => _fWSTotalPreRebateAmount;
  num? get fWSCLLNAmount => _fWSCLLNAmount;
  num? get nonFWSTotalRebate => _nonFWSTotalRebate;
  num? get nonFWSRebateWaterCess => _nonFWSRebateWaterCess;
  num? get nonFWSRebateSewerageCess => _nonFWSRebateSewerageCess;
  num? get nonFWSRebateServiceChrg => _nonFWSRebateServiceChrg;
  num? get nonFWSTotalDemand => _nonFWSTotalDemand;
  num? get nonFWSWaterCess => _nonFWSWaterCess;
  num? get nonFWSSewerageCess => _nonFWSSewerageCess;
  num? get nonFWSServiceChrg => _nonFWSServiceChrg;
  num? get pipeSizeWaterCess => _pipeSizeWaterCess;
  num? get pipeSizeQuantityInKL => _pipeSizeQuantityInKL;
  bool? get isSpecialBillingCan => _isSpecialBillingCan;
  num? get domesticWaterCess => _domesticWaterCess;
  num? get commercialPercantage => _commercialPercantage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lastReadingBillMonth'] = _lastReadingBillMonth;
    map['previousReading'] = _previousReading;
    map['lessConsumptionDueTo'] = _lessConsumptionDueTo;
    map['Can'] = _can;
    map['SAN'] = _san;
    map['CustomerName'] = _customerName;
    map['Address'] = _address;
    map['MeterReaderCode'] = _meterReaderCode;
    map['BillNo'] = _billNo;
    map['BillDate'] = _billDate;
    map['DueDate'] = _dueDate;
    map['BillTime'] = _billTime;
    map['SectionCode'] = _sectionCode;
    map['DivisionCode'] = _divisionCode;
    map['SectionName'] = _sectionName;
    map['DateOfConnection'] = _dateOfConnection;
    map['TariffCategoryCode'] = _tariffCategoryCode;
    map['TariffCategoryDescription'] = _tariffCategoryDescription;
    map['MisCategoryCode'] = _misCategoryCode;
    map['NoOfFlatsForMSB'] = _noOfFlatsForMSB;
    map['LastReadingBillMonth'] = _lastReadingBillMonth;
    map['PreviousReadingDate'] = _previousReadingDate;
    map['LastReadingAverageConsumption'] = _lastReadingAverageConsumption;
    map['PreviousBillAverageConsumption'] = _previousBillAverageConsumption;
    map['AvgConsumption'] = _avgConsumption;
    map['AvgConsumptionForLinkedCan'] = _avgConsumptionForLinkedCan;
    map['MonthlyAvgConsumption'] = _monthlyAvgConsumption;
    map['PreviousBillType'] = _previousBillType;
    map['PreviousBillMonth'] = _previousBillMonth;
    map['OriginalMeterStatus'] = _originalMeterStatus;
    map['FromMonth'] = _fromMonth;
    map['ToMonth'] = _toMonth;
    map['NoOfMonths'] = _noOfMonths;
    map['NoOfDays'] = _noOfDays;
    map['PipeSizeDescription'] = _pipeSizeDescription;
    map['MeterFixedDate'] = _meterFixedDate;
    map['MeterNo'] = _meterNo;
    map['BillType'] = _billType;
    map['PreviousReading'] = _previousReading;
    map['PresentReadingDate'] = _presentReadingDate;
    map['PresentReading'] = _presentReading;
    map['IsSewerageApply'] = _isSewerageApply;
    map['IsMeterRepairSurhargeApply'] = _isMeterRepairSurhargeApply;
    map['IsWaterSupply'] = _isWaterSupply;
    map['IsRebateApply'] = _isRebateApply;
    map['Is24SurchargeApply'] = _is24SurchargeApply;
    map['ConsumedUnits'] = _consumedUnits;
    map['ChargedUnits'] = _chargedUnits;
    map['RolloverReading'] = _rolloverReading;
    map['WaterCess'] = _waterCess;
    map['SewerageCess'] = _sewerageCess;
    map['ServiceChrge'] = _serviceChrge;
    map['SurCharge24'] = _surCharge24;
    map['MeterRepairSurcharge'] = _meterRepairSurcharge;
    map['Total'] = _total;
    map['ReversalAmount'] = _reversalAmount;
    map['WaterCessReversalAmount'] = _waterCessReversalAmount;
    map['SewerageCessReversalAmount'] = _sewerageCessReversalAmount;
    map['ServicechargeReversalAmount'] = _servicechargeReversalAmount;
    map['RebateAmount'] = _rebateAmount;
    map['LatePaymentFee'] = _latePaymentFee;
    map['MeterCost'] = _meterCost;
    map['MeterRepairCharge'] = _meterRepairCharge;
    map['OtherCharges'] = _otherCharges;
    map['VatAmount'] = _vatAmount;
    map['MeterCostInstMent'] = _meterCostInstMent;
    map['ConnectionCharges'] = _connectionCharges;
    map['ArrearInstllment'] = _arrearInstllment;
    map['AdditionalCharges'] = _additionalCharges;
    map['CurrentMonthDemand'] = _currentMonthDemand;
    map['Arrears'] = _arrears;
    map['ArrearIntrest'] = _arrearIntrest;
    map['NetPay'] = _netPay;
    map['LessConsumptionDueTo'] = _lessConsumptionDueTo;
    map['AgreedQuantity'] = _agreedQuantity;
    map['FullAdress'] = _fullAdress;
    map['GeneratedBy'] = _generatedBy;
    map['IsReversed'] = _isReversed;
    map['NonWorkingDays'] = _nonWorkingDays;
    map['MeterCondition'] = _meterCondition;
    map['upToMonth'] = _upToMonth;
    map['IsMeterFixed'] = _isMeterFixed;
    map['SewTariffCategoryCode'] = _sewTariffCategoryCode;
    map['SewTariffCategoryDescription'] = _sewTariffCategoryDescription;
    map['PlinthAreaInSqMts'] = _plinthAreaInSqMts;
    map['NoOfRoomsorBeds'] = _noOfRoomsorBeds;
    map['MobileNo'] = _mobileNo;
    map['ExternalBillNo'] = _externalBillNo;
    map['IsConnectionOutsideGHMC'] = _isConnectionOutsideGHMC;
    map['SewerageRebateAmount'] = _sewerageRebateAmount;
    map['SewerageRebatePercentage'] = _sewerageRebatePercentage;
    map['OCNotSubmitted'] = _oCNotSubmitted;
    map['OCPenaltyToDt'] = _oCPenaltyToDt;
    map['OCChargedFromDt'] = _oCChargedFromDt;
    map['OCChargedToDt'] = _oCChargedToDt;
    map['NoofMthsbilledUnderOC'] = _noofMthsbilledUnderOC;
    map['OCWaterCess'] = _oCWaterCess;
    map['OCSewerageCess'] = _oCSewerageCess;
    map['OCChargedUnits'] = _oCChargedUnits;
    map['OCPenaltyIncludedInDemand'] = _oCPenaltyIncludedInDemand;
    map['ModeOfBilling'] = _modeOfBilling;
    map['MtrRprOrUnmtrdPenaltyAmount'] = _mtrRprOrUnmtrdPenaltyAmount;
    map['RprOrUnmtrdNoticeAckDt'] = _rprOrUnmtrdNoticeAckDt;
    map['MtrTamperPenaltyAmount'] = _mtrTamperPenaltyAmount;
    map['HasAMRMeter'] = _hasAMRMeter;
    map['IsAnyCourtCasePending'] = _isAnyCourtCasePending;
    map['CaseNo'] = _caseNo;
    map['CourtOrderDt'] = _courtOrderDt;
    map['IsBoostingChargesApplicable'] = _isBoostingChargesApplicable;
    map['BoostingCharges'] = _boostingCharges;
    map['EmailId'] = _emailId;
    map['IsmtrDscntAplcble'] = _ismtrDscntAplcble;
    map['MeterDiscount'] = _meterDiscount;
    map['RebateAmountFor20KLFreeWater'] = _rebateAmountFor20KLFreeWater;
    map['PayableTotal'] = _payableTotal;
    map['PayableWaterCess'] = _payableWaterCess;
    map['PayableSewerageCess'] = _payableSewerageCess;
    map['PayableServiceChrg'] = _payableServiceChrg;
    map['FWSWaterCess'] = _fWSWaterCess;
    map['FWSSewerageCess'] = _fWSSewerageCess;
    map['FWSServiceChrg'] = _fWSServiceChrg;
    map['FWSBoostingChrg'] = _fWSBoostingChrg;
    map['FWSMtrRprORUnMtdPenaltyAmt'] = _fWSMtrRprORUnMtdPenaltyAmt;
    map['ConnStatus'] = _connStatus;
    map['ConnType'] = _connType;
    map['IsGovtCAN'] = _isGovtCAN;
    map['BilledMonths'] = _billedMonths;
    map['BilledDays'] = _billedDays;
    map['LastBillDate'] = _lastBillDate;
    map['NoOfFlatsRegForAadhar'] = _noOfFlatsRegForAadhar;
    map['InitialReading'] = _initialReading;
    map['TotalRebatePeriod'] = _totalRebatePeriod;
    map['AadharRegDate'] = _aadharRegDate;
    map['IsProvisionalCAN'] = _isProvisionalCAN;
    map['FwsInstallmentarrears'] = _fwsInstallmentarrears;
    map['ArrearPriortofws'] = _arrearPriortofws;
    map['NoOfFWSMonths'] = _noOfFWSMonths;
    map['NoOfNoneFWSMonths'] = _noOfNoneFWSMonths;
    map['FWSInstallmentAmount'] = _fWSInstallmentAmount;
    map['FwsNetPayableAmount'] = _fwsNetPayableAmount;
    map['ISFwsInstallmentApply'] = _iSFwsInstallmentApply;
    map['ReportReversalAmount'] = _reportReversalAmount;
    map['SBMReversalAmount'] = _sBMReversalAmount;
    map['IsZeroBilling'] = _isZeroBilling;
    map['CurrentMonthDate'] = _currentMonthDate;
    map['FWSPreDemand'] = _fWSPreDemand;
    map['FWSTotalPreDemand'] = _fWSTotalPreDemand;
    map['FWSPreRebateAmount'] = _fWSPreRebateAmount;
    map['FWSTotalPreRebateAmount'] = _fWSTotalPreRebateAmount;
    map['FWSCLLNAmount'] = _fWSCLLNAmount;
    map['NonFWSTotalRebate'] = _nonFWSTotalRebate;
    map['NonFWSRebateWaterCess'] = _nonFWSRebateWaterCess;
    map['NonFWSRebateSewerageCess'] = _nonFWSRebateSewerageCess;
    map['NonFWSRebateServiceChrg'] = _nonFWSRebateServiceChrg;
    map['NonFWSTotalDemand'] = _nonFWSTotalDemand;
    map['NonFWSWaterCess'] = _nonFWSWaterCess;
    map['NonFWSSewerageCess'] = _nonFWSSewerageCess;
    map['NonFWSServiceChrg'] = _nonFWSServiceChrg;
    map['PipeSizeWaterCess'] = _pipeSizeWaterCess;
    map['PipeSizeQuantityInKL'] = _pipeSizeQuantityInKL;
    map['IsSpecialBillingCan'] = _isSpecialBillingCan;
    map['DomesticWaterCess'] = _domesticWaterCess;
    map['CommercialPercantage'] = _commercialPercantage;
    return map;
  }
}

/// ResponseCode : "200"
/// ResponseType : "Success"
/// Description : ""

class MItem1 {
  MItem1({
    String? responseCode,
    String? responseType,
    String? description,
  }) {
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
  MItem1 copyWith({
    String? responseCode,
    String? responseType,
    String? description,
  }) =>
      MItem1(
        responseCode: responseCode ?? _responseCode,
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
