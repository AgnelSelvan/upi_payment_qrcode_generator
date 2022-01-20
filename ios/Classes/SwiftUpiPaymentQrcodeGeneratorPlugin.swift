import Flutter
import UIKit

public class SwiftUpiPaymentQrcodeGeneratorPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "upi_payment_qrcode_generator", binaryMessenger: registrar.messenger())
    let instance = SwiftUpiPaymentQrcodeGeneratorPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
