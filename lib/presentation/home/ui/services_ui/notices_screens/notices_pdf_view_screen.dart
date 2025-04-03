import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:hmwssb/core/api/api.dart';

import 'package:hmwssb/core/theme/app_color.dart';
import 'package:hmwssb/data/models/notices_models/consumer_get_notices.dart';

class NoticesPDFViewScreen extends StatelessWidget {
  final NoticesModel details;

  const NoticesPDFViewScreen({
    required this.details,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Notices', style: TextStyle(color: white)),
      ),
      body: const PDF().cachedFromUrl(
        '${Api.mdmBaseUrl}${details.notice ?? ''}',
        placeholder: (double progress) => Center(child: Text('$progress %')),
        errorWidget: (dynamic error) => Center(child: Text(error.toString())),
      ),
    );
  }
}
