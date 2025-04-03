import 'package:hmwssb/core/api/api.dart';
import 'package:hmwssb/core/api/network.dart';
import 'package:hmwssb/core/api/shared_prefernce.dart';
import 'package:hmwssb/core/theme/app_color.dart';
import 'package:hmwssb/data/models/get_can_dtls_sec_filter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ContactUsScreenWidget extends StatefulWidget {
  const ContactUsScreenWidget({super.key});

  @override
  State<ContactUsScreenWidget> createState() => _ContactUsScreenWidgetState();
}

class _ContactUsScreenWidgetState extends State<ContactUsScreenWidget> {
  GetCanDetailMItem2Model? getCanDetailMItem2Model;

  @override
  void initState() {
    contactUsApiCall();
    super.initState();
  }

  bool isLoadData = false;

  void loadApiData(bool isload) {
    setState(() {
      isLoadData = isload;
    });
  }

  contactUsApiCall() async {
    loadApiData(true);
    EasyLoading.show(status: "Loading...");

    try {
      var postData = {
        "CAN": "YES",
        "Value": LocalStorages.getCanno() ?? '',
        // "Value": "011100241",
      };
      var response = await NetworkApiService().commonApiCall(
          url: Api.getCanDtlsWthtSecFltrUrl,
          data: postData,
          isTokenNotPassing: true);
      if (response.statusCode == 200) {
        var value = GetCanDetailsWithoutSecFilterModel.fromJson(response.data);
        if (value.mItem1?.responseCode == '200') {
          setState(() {
            getCanDetailMItem2Model = value.mItem2?.first;
          });
        }
      }
      loadApiData(false);
      EasyLoading.dismiss();
    } on DioException catch (ex) {
      loadApiData(false);
      EasyLoading.dismiss();
      showException(ex);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Contact Us',
          style: TextStyle(
            color: white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: isLoadData
          ? const SizedBox.shrink()
          : getCanDetailMItem2Model == null
              ? Center(
                  child: Text('No Data Found',
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: black,
                      )))
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: white,
                                    border: Border.all(
                                      color: lightGrey,
                                      width: 2.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(height: 6.h),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            'Division : ',
                                            style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            width: 260.w,
                                            child: Text(
                                              getCanDetailMItem2Model
                                                      ?.divnname ??
                                                  '',
                                              style: TextStyle(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.bold,
                                                color: primaryColor,
                                                overflow: TextOverflow.visible,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 8.h),
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            'Section : ',
                                            style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            // width: 160.w,
                                            child: Text(
                                              getCanDetailMItem2Model
                                                      ?.sectname ??
                                                  '',
                                              style: TextStyle(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.bold,
                                                color: primaryColor,
                                                overflow: TextOverflow.visible,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 6.h)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: white,
                                  border: Border.all(color: lightGrey),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(height: 16.h),
                                    _customNameMobileWidget(
                                      label: 'MANAGER',
                                      name:
                                          getCanDetailMItem2Model?.managername,
                                      mobileNo: getCanDetailMItem2Model
                                          ?.managermobileno,
                                    ),
                                    _customNameMobileWidget(
                                      label: 'DGM',
                                      name: getCanDetailMItem2Model?.dgmname,
                                      mobileNo:
                                          getCanDetailMItem2Model?.dgmmobileno,
                                    ),
                                    _customNameMobileWidget(
                                      label: 'GM',
                                      name: getCanDetailMItem2Model?.gmname,
                                      mobileNo:
                                          getCanDetailMItem2Model?.gmmobileno,
                                    ),
                                    _customNameMobileWidget(
                                      label: 'CGM',
                                      name: getCanDetailMItem2Model?.cgmname,
                                      mobileNo:
                                          getCanDetailMItem2Model?.cgmmobileno,
                                      isNotDividerReq: true,
                                    ),
                                    SizedBox(height: 16.h),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              launchUrlString('tel://04023300114');
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.call,
                                      size: 22.sp,
                                      color: white,
                                    ),
                                    SizedBox(width: 8.w),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          'Support',
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.bold,
                                            color: white,
                                          ),
                                        ),
                                        SizedBox(width: 4.h),
                                        Text(
                                          '04023300114',
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.bold,
                                            color: white,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: 18.w),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              launchUrlString('tel://155313');
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      '24X7',
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold,
                                        color: white,
                                      ),
                                    ),
                                    SizedBox(width: 8.w),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          'Customer Care',
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.bold,
                                            color: white,
                                          ),
                                        ),
                                        SizedBox(width: 4.h),
                                        Text(
                                          '155313',
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.bold,
                                            color: white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
    );
  }

  //? Custom name and label widget
  Widget _customNameMobileWidget({
    required String label,
    required String? name,
    required String? mobileNo,
    bool isNotDividerReq = false,
  }) {
    return Column(
      children: [
        SizedBox(height: 6.h),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        '$label : ',
                        style: TextStyle(
                            fontSize: 14.sp, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        // width: 160.w,
                        child: Text(
                          name ?? '',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                            overflow: TextOverflow.visible,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: <Widget>[
                      Text(
                        'Mobile No. : ',
                        style: TextStyle(
                            fontSize: 14.sp, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        // width: 160.w,
                        child: Text(
                          mobileNo ?? '',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                            overflow: TextOverflow.visible,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  if (mobileNo?.isNotEmpty ?? false) {
                    launchUrlString(
                      'tel://$mobileNo',
                    );
                  }
                },
                child: Container(
                  decoration: const BoxDecoration(
                    color: primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Icon(
                        Icons.call,
                        size: 20.sp,
                        color: white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (!isNotDividerReq)
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Divider(
              // height: 1,
              thickness: 0.6,
              color: lightBlack,
            ),
          ),
      ],
    );
  }
}
