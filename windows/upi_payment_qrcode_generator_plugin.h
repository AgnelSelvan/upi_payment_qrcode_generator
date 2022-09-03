#ifndef FLUTTER_PLUGIN_UPI_PAYMENT_QRCODE_GENERATOR_PLUGIN_H_
#define FLUTTER_PLUGIN_UPI_PAYMENT_QRCODE_GENERATOR_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace upi_payment_qrcode_generator {

class UpiPaymentQrcodeGeneratorPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  UpiPaymentQrcodeGeneratorPlugin();

  virtual ~UpiPaymentQrcodeGeneratorPlugin();

  // Disallow copy and assign.
  UpiPaymentQrcodeGeneratorPlugin(const UpiPaymentQrcodeGeneratorPlugin&) = delete;
  UpiPaymentQrcodeGeneratorPlugin& operator=(const UpiPaymentQrcodeGeneratorPlugin&) = delete;

 private:
  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace upi_payment_qrcode_generator

#endif  // FLUTTER_PLUGIN_UPI_PAYMENT_QRCODE_GENERATOR_PLUGIN_H_
