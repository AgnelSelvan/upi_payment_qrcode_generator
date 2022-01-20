import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:upi_payment_qrcode_generator/upi_payment_qrcode_generator.dart';

void main() {
  const MethodChannel channel = MethodChannel('upi_payment_qrcode_generator');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {

  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
  });
}
