class ApiMessageAndCodeException implements Exception {
  final String errorMessage;
  String? errorStatusCode;

  ApiMessageAndCodeException(
      {required this.errorMessage, this.errorStatusCode});

  //@override
  Map toError() => {"message": errorMessage, "code": errorStatusCode};

  @override
  String toString() => errorMessage;
}

class ApiMessageException implements Exception {
  final String errorMessage;

  ApiMessageException({required this.errorMessage});

  @override
  String toString() => errorMessage;
}

class Api {
   // static String baseUrl = "https://test3.hyderabadwater.gov.in/HMWSSBAPI/";
   static String baseUrl = "https://local.hyderabadwater.gov.in/HMWSSBAPI/";
  // static String paymentBaseUrl = "http://210.212.216.67/HMWSSBBilldeskAPI/";
  // static String baseurlRwh =
  //     "https://rwh.hyderabadwater.gov.in/mobile-apis/save-consumer-survey.json";
  static String baseUrlTanker =
      //"https://tankerstage.amigotechno.com/consumer-apis/get-tracking.json";
      "https://tanker.amigotechno.com/apis/get-tracking.json";
  static String app247InAppCalling =
      "https://app.office24by7.com/v1/common/API/addcalldata";

  static String mdmBaseUrl = "https://mdm.hyderabadwater.gov.in/";

  static String mobileApp = 'MobileApp/';
  static String baseWithMobileApp = '$baseUrl$mobileApp';

  static String generateTokenUrl = "${baseWithMobileApp}GenerateToken";
  static String bannerImages = "${baseWithMobileApp}GetBannerImagesandURL";
  static String canInfoByMobile =
      "${baseWithMobileApp}GetConsumerInfoByMobileNo";
  static String sendLoginOtp = "${baseWithMobileApp}SendLoginOTP";
  static String canInfoByMobileandCan =
      "${baseWithMobileApp}GetConsumerInfoByCANandMobileNo";
  static String getComplaintMaster = "${baseWithMobileApp}GetComplaintMaster";
  static String registerGrievance =
      "${baseWithMobileApp}RegisterGrievanceFromMobileApp";
  static String registerIllegalConnection =
      "${baseWithMobileApp}RegisterIllegalConnectionInfo";
  static String registerManHole =
      "${baseWithMobileApp}RegisterNonConsumerGrievanceInMobileApp";
  static String getSectioncode = "${baseWithMobileApp}Illegal_Section";
  static String getComplaintsStatus =
      "${baseWithMobileApp}GetGrievanceInfoByCAN";
  static String getNonComplaintsStatus =
      "${baseWithMobileApp}GetNonConsumerGrievanceInfoForMobileApp";
  static String getConsumerInfo = "${baseWithMobileApp}GetConsumerInfoByCAN";
  static String updateEmail =
      "${baseWithMobileApp}UpdateEmailIDForConsumerInMobileApp";
  static String getPaymentHitory =
      "${baseWithMobileApp}GetLedgerBillHistroyforCAN";
  static String getWaterBill =
      "${baseWithMobileApp}GetWaterBillDetailsBasedOnCANforMobileApp";
  static String getOtpBooking =
      "${baseWithMobileApp}VerifyCANMobileNoForOTPTankerBookingInMobileApp";
  static String bookTanker =
      "${baseWithMobileApp}RegisterTankerRequestFromMobileApp";
  static String canTankerBook =
      "${baseWithMobileApp}VerifyCANForTankerBookingInMobileApp";
  static String linkCan =
      "${baseWithMobileApp}LinkorUpdateCANMobileNoInMobileApp";

  static String paymentToken = "${baseWithMobileApp}BillDeskPaymentCreateOrder";
  static String paymentStatus =
      "${baseWithMobileApp}UpdatePaymentRequestStatus";
  // static String saveAppLoginDetailsUrl =
  //     '${baseWithMobileApp}SaveAppLoginDetails';
  static String getTransactionReceiptPDFUrl =
      '${baseWithMobileApp}GetTransactionReceiptPDF';
  static String getCanDtlsWthtSecFltrUrl =
      '${baseUrl}GetCanDetailsbyWithoutSectionfilter';
  static String getAppVersionUrl = '${baseUrl}GetCitizensAppLatestVersionNo';
  static String getTankersHistoryUrl =
      '${baseWithMobileApp}GetTankersBookingHistory';

  static String noticesListUrl = '${mdmBaseUrl}apis/noticeList.json';
  static String replyNoticeUrl = '${mdmBaseUrl}apis/replyNotice.json';
  static String amrReadingsUrl = '${mdmBaseUrl}apis/can-details.json';

  static String rwhBaseUrl = 'https://rwh.hyderabadwater.gov.in/mobile-apis';
  static String saveSurveyUrl = '$rwhBaseUrl/save-consumer-survey.json';
  static String saveSurveyPitsUrl =
      '$rwhBaseUrl/save-consumer-survey-pits.json';
  static String editSurveyPitsUrl =
      '$rwhBaseUrl/edit-consumer-pit-details.json';
  static String getSurveyUrl = '$rwhBaseUrl/get-consumer-survey-details.json';
}
