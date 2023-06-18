import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:upi_payment_qrcode_generator/upi_payment_qrcode_generator.dart';

/// Generates the UP IPayment QRCode
class UPIPaymentQRCode extends StatelessWidget {
  const UPIPaymentQRCode({
    Key? key,
    required this.upiDetails,
    this.size,
    this.loader,
    this.noBarcodeWidget,
    this.embeddedImagePath,
    this.embeddedImageSize,
    this.upiQRErrorCorrectLevel,
    this.qrErrorStateBuilder,
    this.eyeStyle,
    this.dataModuleStyle,
    this.qrCodeLoader,
  }) : super(key: key);

  /// The [upiDetails] is required, where we need to pass the object of the UPI Details contains in the UPI Object
  ///
  final UPIDetails upiDetails;

  /// The [size] parameter is completely a optional,
  ///
  /// Default value is null, It is basically for the QRCode width and height
  ///
  final double? size;

  @Deprecated("Please avoid using loader, since its not used no where")

  /// The [loader] parameter is completely Optional,
  ///
  /// Default Circular Progress Loader will be shown
  ///
  final Widget? loader;

  @Deprecated("Please avoid using noBarcodeWidget, since its not used no where")

  /// The [noBarcodeWidget] paramete is used, If No Barcode gets generated in that case you need to provide a message
  ///
  /// Default value is a Text message No Data Found for Barcode", It is basically for the QRCode width and height
  ///
  final Widget? noBarcodeWidget;

  /// The [embeddedImagePath] parameter is used to generate embedded asset image in the QR Code
  ///
  /// Default value is null, If no paramter is passed the image won't show
  ///
  final String? embeddedImagePath;

  /// The [embeddedImagePath] parameter is used to give size to embedded image in QR Code
  ///
  ///Default Value is null, If image is passed and [embeddedImagePath] value is not passed then it default value is Size(40, 40)
  ///
  final Size? embeddedImageSize;

  /// The [upiQRErrorCorrectLevel] parameter is used to avoid error in QRCode, the more high the Correct Level
  /// less the error in QRCode data while scanning.
  final UPIQRErrorCorrectLevel? upiQRErrorCorrectLevel;

  /// The [qrErrorStateBuilder] parameter is used to when there is an error in rendering the QRCode
  final Widget Function(BuildContext, Object?)? qrErrorStateBuilder;

  /// The [eyeStyle] parameter is used to change the eye style of the QRCode
  final QrEyeStyle? eyeStyle;

  /// The [dataModuleStyle] parameter is used to change the data module style of the QRCode
  final QrDataModuleStyle? dataModuleStyle;

  /// The [qrCodeLoader] parameter is used to load the QRCode when it is being generated
  final Widget? qrCodeLoader;

  @override
  Widget build(BuildContext context) {
    final FutureBuilder<ui.Image> qrFutureBuilder = FutureBuilder<ui.Image>(
      future: embeddedImagePath == null ? null : _loadOverlayImage(),
      builder: (BuildContext ctx, AsyncSnapshot<ui.Image> snapshot) {
        if (snapshot.hasError) {
          return qrErrorStateBuilder?.call(ctx, snapshot.error) ??
              const Text("Error in loading QRCode");
        }
        if (!snapshot.hasData) {
          return qrCodeLoader ?? const CircularProgressIndicator();
        }
        return _qrPainter(snapshot.data);
      },
    );

    return SizedBox(
      width: size,
      height: size,
      child: embeddedImagePath == null ? _qrPainter(null) : qrFutureBuilder,
    );
  }

  CustomPaint _qrPainter(ui.Image? image) {
    return CustomPaint(
      size: Size.square(size ?? 320),
      painter: QrPainter(
        data: upiDetails.qrCodeValue,
        version: QrVersions.auto,
        eyeStyle: eyeStyle ??
            const QrEyeStyle(
              eyeShape: QrEyeShape.square,
              color: Colors.black,
            ),
        dataModuleStyle: dataModuleStyle ??
            const QrDataModuleStyle(
              dataModuleShape: QrDataModuleShape.square,
              color: Colors.black,
            ),
        embeddedImageStyle: QrEmbeddedImageStyle(
          size: embeddedImageSize ?? const Size(40, 40),
        ),
        errorCorrectionLevel:
            upiQRErrorCorrectLevel?.value ?? UPIQRErrorCorrectLevel.high.value,
        embeddedImage: image,
      ),
    );
  }

  Future<ui.Image> _loadOverlayImage() async {
    final Completer<ui.Image> completer = Completer<ui.Image>();
    final ByteData byteData = await rootBundle.load(embeddedImagePath!);
    ui.decodeImageFromList(byteData.buffer.asUint8List(), completer.complete);
    return completer.future;
  }
}
