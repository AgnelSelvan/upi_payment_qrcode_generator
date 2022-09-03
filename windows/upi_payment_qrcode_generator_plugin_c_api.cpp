#include "include/upi_payment_qrcode_generator/upi_payment_qrcode_generator_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "upi_payment_qrcode_generator_plugin.h"

void UpiPaymentQrcodeGeneratorPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  upi_payment_qrcode_generator::UpiPaymentQrcodeGeneratorPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
