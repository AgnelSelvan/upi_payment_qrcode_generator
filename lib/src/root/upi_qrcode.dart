import 'dart:io';

import 'package:barcode/barcode.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';

import '../../upi_payment_qrcode_generator.dart';

/// Generates the UP IPayment QRCode
class UPIPaymentQRCode extends StatefulWidget {
  const UPIPaymentQRCode({Key? key, required this.upiDetails, this.size})
      : super(key: key);

  /// The [upiDetails] is required, where we need to pass the object of the UPI Details contains in the UPI Object
  ///
  final UPIDetails upiDetails;

  /// The [size] parameter is completely a optional,
  ///
  /// Default value is null, It is basically for the QRCode width and height
  ///
  final double? size;

  @override
  _UPIPaymentQRCodeState createState() => _UPIPaymentQRCodeState();
}

class _UPIPaymentQRCodeState extends State<UPIPaymentQRCode> {
  bool isLoading = true;
  File? _barcodeFile;

  @override
  void initState() {
    askPermission();
    super.initState();
  }

  Future askPermission() async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      buildBarcode(Barcode.qrCode(), widget.upiDetails.qrCodeValue);
    } else {
      throw "Grant Permission to Show the Barcode";
    }
  }

  Future buildBarcode(
    Barcode bc,
    String data, {
    String? filename,
  }) async {
    /// Create the Barcode
    final svg = bc.toSvg(
      data,
      width: widget.size ?? MediaQuery.of(context).size.width * 0.7,
      height: widget.size ?? MediaQuery.of(context).size.width * 0.7,
    );
    try {
      final dir = await getTemporaryDirectory();
      // Save the image
      filename ??= bc.name.replaceAll(RegExp(r'\s'), '-').toLowerCase();
      File('${dir.path}/$filename.svg').writeAsStringSync(svg);
      _barcodeFile = File('${dir.path}/$filename.svg');
    } catch (e) {
      throw e;
    }
    isLoading = false;
    setState(() {});
  }

  Future<String?> _readSVGFile() async {
    if (_barcodeFile == null) {
      return null;
    }
    return await _barcodeFile!.readAsString();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: widget.size,
        height: widget.size,
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : _barcodeFile == null
                ? Text("Error in generating the barcode")
                : FutureBuilder(
                    future: _readSVGFile(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return SvgPicture.string('''${snapshot.data}''');
                      }
                      return Container();
                    }));
  }
}
