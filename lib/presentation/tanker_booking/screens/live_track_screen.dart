import 'dart:async';
import 'dart:developer';
import 'dart:typed_data';
import 'package:hmwssb/core/api/shared_prefernce.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hmwssb/core/api/api.dart';
import 'package:hmwssb/core/api/network.dart';
import 'package:hmwssb/core/theme/app_color.dart';
import 'package:hmwssb/presentation/tanker_booking/models/track_status.dart';
import 'dart:ui' as ui;

class LocationTracking extends StatefulWidget {
  const LocationTracking({
    required this.lastLatlng,
    required this.previoustokenData,
    required this.callBackBunction,
    super.key,
  });
  final LatLng lastLatlng;
  final Booking? previoustokenData;
  final Function(Booking?) callBackBunction;

  @override
  LocationTrackingState createState() => LocationTrackingState();
}

class LocationTrackingState extends State<LocationTracking> {
  LatLng? sourceLocation;
  LatLng? destinationLatlng;
  Booking? tokenData;
  final Completer<GoogleMapController> _controller = Completer();

  late GoogleMapController mapController;
  double? _originLatitude;
  double? _originLongitude;

  Set<Marker> markers = <Marker>{};

  List<LatLng> polyLines = <LatLng>[];
  Timer? _timer;
  double currentLatitude = 0.0;
  double currentLongitude = 0.0;
  double zoom = 18.0;

  @override
  void initState() {
    super.initState();

    tokenData = widget.previoustokenData;
    if (tokenData?.bookingStatus == 3) {
      convertLatLngFunc();
    }

    callContinousTrackApiCall();
  }

  void convertLatLngFunc() async {
    if (widget.lastLatlng.latitude != 0.0 &&
        widget.lastLatlng.longitude != 0.0) {
      _originLatitude = widget.lastLatlng.latitude;
      _originLongitude = widget.lastLatlng.longitude;
      sourceLocation = widget.lastLatlng;
    }
    addMarkrPolyLineOnScreen();
  }

  void addMarkrPolyLineOnScreen() async {
    markers.clear();
    String lat = LocalStorages.getLatitude() ?? '';
    String lng = LocalStorages.getLongitude() ?? '';
    if ((lat.isNotEmpty && lat != '0.0') && (lng.isNotEmpty && lng != '0.0')) {
      destinationLatlng = LatLng(double.parse(lat), double.parse(lng));

      /// destination marker
      if (destinationLatlng != null) {
        _addMarker(destinationLatlng!, "destination", 1);
      }

      /// Current restaurant
      if (sourceLocation != null) {
        _addMarker(sourceLocation!, "restaurant", 2);
      }
      if (sourceLocation != null && destinationLatlng != null) {
        getPolyLines(
          sourceLocation: sourceLocation!,
          destinationLocation: destinationLatlng!,
        );
      }
    } else {
      if (_originLatitude != null && _originLongitude != null) {
        _addMarker(LatLng(_originLatitude!, _originLongitude!), "1", 1);
      }
    }
  }

  @override
  void didUpdateWidget(covariant LocationTracking oldWidget) {
    if (oldWidget.previoustokenData?.bookingStatus != 3) {
      String lat = LocalStorages.getLatitude() ?? '';
      String lng = LocalStorages.getLongitude() ?? '';
      if ((lat.isNotEmpty && lat != '0.0') &&
          (lng.isNotEmpty && lng != '0.0')) {
        polyLines.clear();
        markers.clear();
        LatLng des = LatLng(double.parse(lat), double.parse(lng));
        _originLatitude = double.parse(lat);
        _originLongitude = double.parse(lng);
        _addMarker(des, "1", 1);
      }
      _timer?.cancel();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    log("sourceLocation $sourceLocation ${LatLng(_originLatitude!, _originLongitude!)}");
    return Scaffold(
        body: GoogleMap(
            initialCameraPosition: CameraPosition(
                target: sourceLocation ??
                    LatLng(_originLatitude!, _originLongitude!),
                zoom: zoom),
            // myLocationEnabled: true,
            tiltGesturesEnabled: true,
            compassEnabled: true,
            scrollGesturesEnabled: true,
            zoomGesturesEnabled: true,
            onMapCreated: _onMapCreated,
            mapType: MapType.terrain,
            markers: markers,
            polylines: <Polyline>{
          Polyline(
              polylineId: const PolylineId('route'),
              points: polyLines,
              color: fourcolor,
              width: 5)
        }));
  }

  void updateCameraPosition() {
    if (tokenData?.bookingStatus == 4) {
      String lat = LocalStorages.getLatitude() ?? '';
      String lng = LocalStorages.getLongitude() ?? '';
      if ((lat.isNotEmpty && lat != '0.0') &&
          (lng.isNotEmpty && lng != '0.0')) {
        setState(() {
          _timer?.cancel();
          markers.clear();
          polyLines.clear();
          LatLng des = LatLng(double.parse(lat), double.parse(lng));
          _originLatitude = double.parse(lat);
          _originLongitude = double.parse(lng);
          _addMarker(des, "1", 1);
          final newCameraPosition = CameraPosition(
              target: LatLng(_originLatitude!, _originLongitude!), zoom: zoom);

          mapController
              .moveCamera(CameraUpdate.newCameraPosition(newCameraPosition));
        });
      }
    } else {
      final newCameraPosition = CameraPosition(
          target: sourceLocation ?? LatLng(_originLatitude!, _originLongitude!),
          zoom: zoom);

      mapController
          .moveCamera(CameraUpdate.newCameraPosition(newCameraPosition));
    }
  }

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    _controller.complete(controller);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void callContinousTrackApiCall() {
    if (tokenData?.bookingStatus == 3 && sourceLocation != destinationLatlng) {
      _timer = Timer.periodic(const Duration(seconds: 30), (timer) {
        trackDetails();
        addMarkrPolyLineOnScreen();
      });
    } else {
      String lat = LocalStorages.getLatitude() ?? '';
      String lng = LocalStorages.getLongitude() ?? '';
      if ((lat.isNotEmpty && lat != '0.0') &&
          (lng.isNotEmpty && lng != '0.0')) {
        setState(() {
          markers.clear();
          polyLines.clear();
          LatLng des = LatLng(double.parse(lat), double.parse(lng));
          _originLatitude = double.parse(lat);
          _originLongitude = double.parse(lng);
          _addMarker(des, "1", 1);
        });
      }
    }
  }

  trackDetails() async {
    try {
      var postData = {"can_number": LocalStorages.getCanno() ?? ""};
      var response = await NetworkApiService().commonApiCall(
          url: Api.baseUrlTanker, data: postData, isPostMethod: true);
      if (response.statusCode == 200) {
        var value = TrackStatus.fromJson(response.data);
        if (value.error == 0) {
          setState(() {
            tokenData = value.booking;
            widget.callBackBunction(tokenData);
            if (tokenData?.lastLatitude != null &&
                tokenData?.lastLatitude.toString() != "null") {
              _originLatitude =
                  double.parse(tokenData!.lastLatitude.toString());
            }
            if (tokenData?.lastLongitude != null &&
                tokenData?.lastLongitude.toString() != "null") {
              _originLongitude =
                  double.parse(tokenData!.lastLongitude.toString());
            }

            if (_originLatitude != null && _originLongitude != null) {
              sourceLocation = LatLng(_originLatitude!, _originLongitude!);
              updateCameraPosition();
            }
          });
        }
      }
    } on DioException catch (ex) {
      showException(ex);
    }
  }

  _addMarker(LatLng position, String id, int status) async {
    MarkerId markerId = MarkerId(id);
    BitmapDescriptor? icon;
    if (status == 1) {
      icon = await bitmapDescriptorFromSvgAsset(
        context: context,
        assetName: 'assets/svg/blue_tanker_marker.svg',
        imgHgt: 60,
        imgWdth: 40,
      );
    } else {
      icon = await bitmapDescriptorFromSvgAsset(
        context: context,
        assetName: 'assets/svg/blue_tanker.svg',
        imgHgt: 60,
        imgWdth: 30,
      );
    }
    markers.add(
      Marker(
        markerId: markerId,
        position: position,
        icon: icon,
        rotation: double.parse(tokenData?.bearing ?? "0.0"),
      ),
    );
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> getPolyLines({
    required LatLng sourceLocation,
    required LatLng destinationLocation,
  }) async {
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      'AIzaSyBQmbEY6whSwo-7vkQis0dYVEVY3bIdOKk',
      PointLatLng(
        sourceLocation.latitude,
        sourceLocation.longitude,
      ),
      PointLatLng(
        destinationLocation.latitude,
        destinationLocation.longitude,
      ),
    );

    if (result.points.isNotEmpty) {
      polyLines.clear();
      for (final PointLatLng point in result.points) {
        polyLines.add(LatLng(point.latitude, point.longitude));
      }
      if (mounted) {
        setState(() {});
      }
    }
  }
}

Future<BitmapDescriptor> bitmapDescriptorFromSvgAsset({
  required BuildContext context,
  required String assetName,
  double imgHgt = 50,
  double imgWdth = 50,
}) async {
  String svgString = await DefaultAssetBundle.of(context).loadString(assetName);
  final PictureInfo pictureInfo =
      await vg.loadPicture(SvgStringLoader(svgString), null);

  MediaQueryData queryData = MediaQuery.of(context);
  double devicePixelRatio = queryData.devicePixelRatio;

  double width = imgWdth * devicePixelRatio;
  double height = imgHgt * devicePixelRatio;

  final ui.PictureRecorder recorder = ui.PictureRecorder();
  final ui.Canvas canvas = ui.Canvas(recorder);

  canvas.scale(
      width / pictureInfo.size.width, height / pictureInfo.size.height);
  canvas.drawPicture(pictureInfo.picture);
  final ui.Picture scaledPicture = recorder.endRecording();

  final image = await scaledPicture.toImage(width.toInt(), height.toInt());

  ByteData? bytes = await image.toByteData(format: ui.ImageByteFormat.png);
  return BitmapDescriptor.bytes(bytes?.buffer.asUint8List()??Uint8List(0));
}
