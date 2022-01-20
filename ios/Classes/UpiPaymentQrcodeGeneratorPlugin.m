#import "UpiPaymentQrcodeGeneratorPlugin.h"
#if __has_include(<upi_payment_qrcode_generator/upi_payment_qrcode_generator-Swift.h>)
#import <upi_payment_qrcode_generator/upi_payment_qrcode_generator-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "upi_payment_qrcode_generator-Swift.h"
#endif

@implementation UpiPaymentQrcodeGeneratorPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftUpiPaymentQrcodeGeneratorPlugin registerWithRegistrar:registrar];
}
@end
