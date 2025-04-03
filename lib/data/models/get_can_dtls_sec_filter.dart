// To parse this JSON data, do
//
//     final getCanDetailsWithoutSecFilterModel = getCanDetailsWithoutSecFilterModelFromJson(jsonString);

// import 'dart:convert';

// GetCanDetailsWithoutSecFilterModel getCanDetailsWithoutSecFilterModelFromJson(String str) => GetCanDetailsWithoutSecFilterModel.fromJson(json.decode(str));

// String getCanDetailsWithoutSecFilterModelToJson(GetCanDetailsWithoutSecFilterModel data) => json.encode(data.toJson());

class GetCanDetailsWithoutSecFilterModel {
    MItem1? mItem1;
    List<GetCanDetailMItem2Model>? mItem2;

    GetCanDetailsWithoutSecFilterModel({
        this.mItem1,
        this.mItem2,
    });

    factory GetCanDetailsWithoutSecFilterModel.fromJson(Map<String, dynamic> json) => GetCanDetailsWithoutSecFilterModel(
        mItem1: json["m_Item1"] == null ? null : MItem1.fromJson(json["m_Item1"]),
        mItem2: json["m_Item2"] == null ? [] : List<GetCanDetailMItem2Model>.from(json["m_Item2"]!.map((x) => GetCanDetailMItem2Model.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "m_Item1": mItem1?.toJson(),
        "m_Item2": mItem2 == null ? [] : List<dynamic>.from(mItem2!.map((x) => x.toJson())),
    };
}

class MItem1 {
    String? responseCode;
    String? responseType;
    String? description;

    MItem1({
        this.responseCode,
        this.responseType,
        this.description,
    });

    factory MItem1.fromJson(Map<String, dynamic> json) => MItem1(
        responseCode: json["ResponseCode"],
        responseType: json["ResponseType"],
        description: json["Description"],
    );

    Map<String, dynamic> toJson() => {
        "ResponseCode": responseCode,
        "ResponseType": responseType,
        "Description": description,
    };
}

class GetCanDetailMItem2Model {
    String? can;
    String? consumername;
    String? consumeraddress;
    String? spmobileno;
    String? category;
    String? pipesize;
    String? circlecode;
    String? circlename;
    int? circleouid;
    String? divncode;
    String? divnname;
    int? divnouid;
    String? subdivncode;
    String? subdivnname;
    int? subdivnouid;
    String? sectcode;
    String? sectname;
    int? sectouid;
    String? managername;
    String? managermobileno;
    String? dgmmobileno;
    String? dgmname;
    String? gmname;
    String? gmmobileno;
    String? cgmname;
    String? cgmmobileno;
    String? presentinlinemandata;
    String? latitude;
    String? longitude;

    GetCanDetailMItem2Model({
        this.can,
        this.consumername,
        this.consumeraddress,
        this.spmobileno,
        this.category,
        this.pipesize,
        this.circlecode,
        this.circlename,
        this.circleouid,
        this.divncode,
        this.divnname,
        this.divnouid,
        this.subdivncode,
        this.subdivnname,
        this.subdivnouid,
        this.sectcode,
        this.sectname,
        this.sectouid,
        this.managername,
        this.managermobileno,
        this.dgmmobileno,
        this.dgmname,
        this.gmname,
        this.gmmobileno,
        this.cgmname,
        this.cgmmobileno,
        this.presentinlinemandata,
        this.latitude,
        this.longitude,
    });

    factory GetCanDetailMItem2Model.fromJson(Map<String, dynamic> json) => GetCanDetailMItem2Model(
        can: json["CAN"],
        consumername: json["CONSUMERNAME"],
        consumeraddress: json["CONSUMERADDRESS"],
        spmobileno: json["SPMOBILENO"],
        category: json["CATEGORY"],
        pipesize: json["PIPESIZE"],
        circlecode: json["CIRCLECODE"],
        circlename: json["CIRCLENAME"],
        circleouid: json["CIRCLEOUID"],
        divncode: json["DIVNCODE"],
        divnname: json["DIVNNAME"],
        divnouid: json["DIVNOUID"],
        subdivncode: json["SUBDIVNCODE"],
        subdivnname: json["SUBDIVNNAME"],
        subdivnouid: json["SUBDIVNOUID"],
        sectcode: json["SECTCODE"],
        sectname: json["SECTNAME"],
        sectouid: json["SECTOUID"],
        managername: json["MANAGERNAME"],
        managermobileno: json["MANAGERMOBILENO"],
        dgmmobileno: json["DGMMOBILENO"],
        dgmname: json["DGMNAME"],
        gmname: json["GMNAME"],
        gmmobileno: json["GMMOBILENO"],
        cgmname: json["CGMNAME"],
        cgmmobileno: json["CGMMOBILENO"],
        presentinlinemandata: json["PRESENTINLINEMANDATA"],
        latitude: json["LATITUDE"],
        longitude: json["LONGITUDE"],
    );

    Map<String, dynamic> toJson() => {
        "CAN": can,
        "CONSUMERNAME": consumername,
        "CONSUMERADDRESS": consumeraddress,
        "SPMOBILENO": spmobileno,
        "CATEGORY": category,
        "PIPESIZE": pipesize,
        "CIRCLECODE": circlecode,
        "CIRCLENAME": circlename,
        "CIRCLEOUID": circleouid,
        "DIVNCODE": divncode,
        "DIVNNAME": divnname,
        "DIVNOUID": divnouid,
        "SUBDIVNCODE": subdivncode,
        "SUBDIVNNAME": subdivnname,
        "SUBDIVNOUID": subdivnouid,
        "SECTCODE": sectcode,
        "SECTNAME": sectname,
        "SECTOUID": sectouid,
        "MANAGERNAME": managername,
        "MANAGERMOBILENO": managermobileno,
        "DGMMOBILENO": dgmmobileno,
        "DGMNAME": dgmname,
        "GMNAME": gmname,
        "GMMOBILENO": gmmobileno,
        "CGMNAME": cgmname,
        "CGMMOBILENO": cgmmobileno,
        "PRESENTINLINEMANDATA": presentinlinemandata,
        "LATITUDE": latitude,
        "LONGITUDE": longitude,
    };
}
