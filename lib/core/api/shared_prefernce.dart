import 'dart:developer';

import 'package:hmwssb/core/api/sharekey.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum LocalSaveType {
  isLoggedIn,
  isFirstLogin,
  isConsumer,
  name,
  mobileNumber,
  role,
  designation,
  officerType,
  otp,
  consumerName,
  pipeSize,
  address,
  latitude,
  longitude,
  movablelatitude,
  movablelongitude,
  canno,
  consumerNumber,
  key,
  divisions,
  isAmr,
  rwhFlag,
  latLongEdit,
  token,
}

class LocalStorages {
  static SharedPreferences? _prefs;

  ///INTIALIZE THE SHARED PREFERENCE STATE
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  ///SAVE THE USER DATA
  static dynamic saveUserData(
      {required LocalSaveType localSaveType, dynamic value}) async {
    dynamic val = value ??
        (localSaveType == LocalSaveType.isLoggedIn ||
                localSaveType == LocalSaveType.isFirstLogin ||
                localSaveType == LocalSaveType.isAmr ||
                localSaveType == LocalSaveType.isConsumer ||
                localSaveType == LocalSaveType.movablelongitude ||
                localSaveType == LocalSaveType.movablelongitude
            ? false
            : '');
    log("local save $localSaveType and $val");

    switch (localSaveType) {
      case LocalSaveType.isLoggedIn:
        await _prefs?.setBool(ShareKey.ISLOGGEDIN, val);
        break;
      case LocalSaveType.isFirstLogin:
        await _prefs?.setBool(ShareKey.ISFIRSTLOGIN, val);
        break;
      case LocalSaveType.isConsumer:
        await _prefs?.setBool(ShareKey.ISCONSUMER, val);
        break;
      case LocalSaveType.isAmr:
        await _prefs?.setBool(ShareKey.ISAMR, val);
        break;
      case LocalSaveType.name:
        await _prefs?.setString(ShareKey.NAME, val);
        break;
      case LocalSaveType.mobileNumber:
        await _prefs?.setString(ShareKey.MOBILE_NUMBER, val);
        break;
      case LocalSaveType.role:
        await _prefs?.setString(ShareKey.ROLE, val);
        break;
      case LocalSaveType.designation:
        await _prefs?.setString(ShareKey.DESIGNATION, val);
        break;
      case LocalSaveType.officerType:
        await _prefs?.setString(ShareKey.OFFICER_TYPE, val);
        break;
      case LocalSaveType.otp:
        await _prefs?.setString(ShareKey.OTP, val);
        break;
      case LocalSaveType.consumerName:
        await _prefs?.setString(ShareKey.CONSUMERNAME, val);
        break;
      case LocalSaveType.pipeSize:
        await _prefs?.setString(ShareKey.PIPESIZE, val);
        break;
      case LocalSaveType.address:
        await _prefs?.setString(ShareKey.ADDRESS, val);
        break;
      case LocalSaveType.latitude:
        await _prefs?.setString(ShareKey.LATITUDE, val);
        break;
      case LocalSaveType.longitude:
        await _prefs?.setString(ShareKey.LONGITUDE, val);
        break;
      case LocalSaveType.movablelatitude:
        await _prefs?.setString(ShareKey.MOVABLELATITUDE, val);
        break;
      case LocalSaveType.movablelongitude:
        await _prefs?.setString(ShareKey.MOVABLELONGITUDE, val);
        break;
      case LocalSaveType.canno:
        await _prefs?.setString(ShareKey.CANNO, val);
        break;
      case LocalSaveType.consumerNumber:
        await _prefs?.setString(ShareKey.CONSUMERNUMBER, val);
        break;
      case LocalSaveType.rwhFlag:
        await _prefs?.setInt(ShareKey.RWHFLAG, val);
        break;
      case LocalSaveType.latLongEdit:
        await _prefs?.setInt(ShareKey.LATLONGEDITIBLE, val);
        break;
      case LocalSaveType.key:
        await _prefs?.setString(ShareKey.KEY, val);
        break;
      case LocalSaveType.divisions:
        await _prefs?.setString(ShareKey.DIVISIONS, val);
        break;

      case LocalSaveType.token:
        await _prefs?.setString(ShareKey.TOKEN, val);
        break;
    }
  }

  ///GET THE USER DATA

  ///GET IS LOGGED IN
  static dynamic getIsLoggedIn() =>
      _prefs?.getBool(ShareKey.ISLOGGEDIN) ?? false;

  ///GET IS FIRST TIME LOGGED IN
  static dynamic getIsFirstLogin() =>
      _prefs?.getBool(ShareKey.ISFIRSTLOGIN) ?? false;

  ///GET IS CONSUMER
  static dynamic getIsConsumer() =>
      _prefs?.getBool(ShareKey.ISCONSUMER) ?? false;

  ///GET NAME
  static dynamic getName() => _prefs?.getString(ShareKey.NAME) ?? '';

  ///GET MOBILE NUMBER
  static dynamic getMobileNumber() =>
      _prefs?.getString(ShareKey.MOBILE_NUMBER) ?? '';

  ///GET MOBILE
  // static dynamic getMobile() => _prefs?.getString(ShareKey.MOBILE);

  ///GET ROLE
  static dynamic getRole() => _prefs?.getString(ShareKey.ROLE) ?? '';

  ///GET DESIGNATION
  static dynamic getDesignation() =>
      _prefs?.getString(ShareKey.DESIGNATION) ?? '';

  ///GET OFFICER TYPE
  static dynamic getOfficerType() =>
      _prefs?.getString(ShareKey.OFFICER_TYPE) ?? '';

  ///GET OTP
  static dynamic getOtp() => _prefs?.getString(ShareKey.OTP) ?? '';

  ///GET CONSUMER NAME
  static dynamic getConsumerName() =>
      _prefs?.getString(ShareKey.CONSUMERNAME) ?? '';

  ///GET CONSUMER NUMBER
  static dynamic getConsumerNumber() =>
      _prefs?.getString(ShareKey.CONSUMERNUMBER) ?? '';

  ///GET RWHFLAG
  static dynamic getRwhFlag() => _prefs?.getInt(ShareKey.RWHFLAG) ?? '';

  ///GET LATLONGEDITIBLE
  static dynamic getLatLongEdit() =>
      _prefs?.getInt(ShareKey.LATLONGEDITIBLE) ?? '';

  ///GET PIPESIZE
  static dynamic getPipesize() => _prefs?.getString(ShareKey.PIPESIZE) ?? '';

  ///GET ADDRESS
  static dynamic getAddress() => _prefs?.getString(ShareKey.ADDRESS) ?? '';

  ///GET LATITUDE
  static dynamic getLatitude() => _prefs?.getString(ShareKey.LATITUDE) ?? '0.0';

  ///GET LONGITUDE
  static dynamic getLongitude() =>
      _prefs?.getString(ShareKey.LONGITUDE) ?? '0.0';

  ///GET MOVLATITUDE
  static dynamic getMovLatitude() =>
      _prefs?.getString(ShareKey.MOVABLELATITUDE) ?? '0.0';

  ///GET MovLONGITUDE
  static dynamic getMovLongitude() =>
      _prefs?.getString(ShareKey.MOVABLELONGITUDE) ?? '0.0';

  ///GET CANNO
  static dynamic getCanno() => _prefs?.getString(ShareKey.CANNO) ?? '';

  ///GET KEY
  static dynamic getKey() => _prefs?.getString(ShareKey.KEY) ?? '';

  ///GET DIVISION
  static dynamic getDivisions() => _prefs?.getString(ShareKey.DIVISIONS) ?? '';

  static bool isAmrCan() => _prefs?.getBool(ShareKey.ISAMR) ?? false;

  ///GET TOKEN
  static String getToken() => _prefs?.getString(ShareKey.TOKEN) ?? '';

  static Future<dynamic> logOutUser() async {
    /* _prefs?.setBool(ShareKey.ISLOGGEDIN, false);
    _prefs?.setBool(ShareKey.ISFIRSTLOGIN, false);
    _prefs?.setBool(ShareKey.ISCONSUMER, false);
    _prefs?.setBool(ShareKey.ISAMR, false);
    _prefs?.setString(ShareKey.NAME, '');
    _prefs?.setString(ShareKey.MOBILE_NUMBER, '');
    // _prefs?.setString(ShareKey.MOBILE, '');
    _prefs?.setString(ShareKey.ROLE, '');
    _prefs?.setString(ShareKey.DESIGNATION, '');
    _prefs?.setString(ShareKey.OFFICER_TYPE, '');
    _prefs?.setString(ShareKey.OTP, '');
    _prefs?.setString(ShareKey.CONSUMERNAME, '');
    _prefs?.setString(ShareKey.PIPESIZE, '');
    _prefs?.setString(ShareKey.ADDRESS, '');
    _prefs?.setString(ShareKey.LATITUDE, '');
    _prefs?.setString(ShareKey.LONGITUDE, '');
    _prefs?.setString(ShareKey.CANNO, '');
    _prefs?.setString(ShareKey.CONSUMERNUMBER, '');
    _prefs?.setInt(ShareKey.RWHFLAG, 0);
    _prefs?.setInt(ShareKey.LATLONGEDITIBLE, 0);
    _prefs?.setString(ShareKey.KEY, '');
    _prefs?.setString(ShareKey.DIVISIONS, '');
    _prefs?.setString(ShareKey.TOKEN, '');*/
    await _prefs?.remove(ShareKey.ISLOGGEDIN);
    await _prefs?.remove(ShareKey.ISFIRSTLOGIN);
    await _prefs?.remove(ShareKey.ISCONSUMER);
    await _prefs?.remove(ShareKey.ISAMR);
    await _prefs?.remove(ShareKey.NAME);
    await _prefs?.remove(ShareKey.MOBILE_NUMBER);
    await _prefs?.remove(ShareKey.ROLE);
    await _prefs?.remove(ShareKey.DESIGNATION);
    await _prefs?.remove(ShareKey.OFFICER_TYPE);
    await _prefs?.remove(ShareKey.OTP);
    await _prefs?.remove(ShareKey.CONSUMERNAME);
    await _prefs?.remove(ShareKey.PIPESIZE);
    await _prefs?.remove(ShareKey.ADDRESS);
    await _prefs?.remove(ShareKey.LATITUDE);
    await _prefs?.remove(ShareKey.LONGITUDE);
    await _prefs?.remove(ShareKey.MOVABLELONGITUDE);
    await _prefs?.remove(ShareKey.MOVABLELATITUDE);
    await _prefs?.remove(ShareKey.CANNO);
    await _prefs?.remove(ShareKey.CONSUMERNUMBER);
    await _prefs?.remove(ShareKey.RWHFLAG);
    await _prefs?.remove(ShareKey.LATLONGEDITIBLE);
    await _prefs?.remove(ShareKey.KEY);
    await _prefs?.remove(ShareKey.DIVISIONS);
    await _prefs?.remove(ShareKey.TOKEN);
    // _clearAllStorage();
    await _prefs?.clear();
  }

  // static dynamic _clearAllStorage() => _prefs?.clear();
}
