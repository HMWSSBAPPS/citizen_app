import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hmwssb/core/extensions.dart';
import 'package:hmwssb/core/theme/app_color.dart';
import 'package:hmwssb/presentation/payment/payment_status.dart';
import 'package:url_launcher/url_launcher.dart';

class PaymentSuccess extends StatefulWidget {
  final PaymentStatus model;

  const PaymentSuccess(this.model, {super.key});

  @override
  State<PaymentSuccess> createState() => _PaymentSuccessState();
}

class _PaymentSuccessState extends State<PaymentSuccess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: primaryColor,
        title: const Text(
          'Payment Success',
          style: TextStyle(color: white),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 80,
              ),
              const Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 100.0,
              ),
              const SizedBox(height: 20),
              Text(
                widget.model.mItem1?.transactionErrorDesc ?? "",
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Text(
                'Transaction No : ${widget.model.mItem1?.transactionid}',
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Text(
                'Transaction Amount : ${widget.model.mItem1?.chargeAmount}',
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Text(
                widget.model.mItem1?.transactionDate.toString() != 'null' &&
                        (widget.model.mItem1?.transactionDate
                                .toString()
                                .isNotEmpty ??
                            false)
                    ? 'Transaction Date : ${widget.model.mItem1?.transactionDate?.toString().dmyFormatedDate ?? ''}-${widget.model.mItem1?.transactionDate?.toString().formatedTime ?? ''} '
                    : 'Transaction Date : null',
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Text(
                'Transaction Type : ${widget.model.mItem1?.transactionErrorType.toString().toUpperCase()}',
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Back to Home'),
              ),
              if (widget.model.mItem2?.receiptPdfLink != null)
                const SizedBox(height: 10),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(primaryColor),
                ),
                onPressed: () {
                  _launchURL(widget.model.mItem2!.receiptPdfLink!);
                },
                child: const Text(
                  'Download Pdf',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(content: Text('Failed to open')),
      // );
      EasyLoading.showError('Failed to open');
    }
  }
}
