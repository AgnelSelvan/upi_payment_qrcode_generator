enum UPIQRErrorCorrectLevel {
  low,
  medium,
  quality,
  high;

  int get value {
    switch (this) {
      case UPIQRErrorCorrectLevel.high:
        return 2;
      case UPIQRErrorCorrectLevel.low:
        return 1;
      case UPIQRErrorCorrectLevel.medium:
        return 0;
      case UPIQRErrorCorrectLevel.quality:
        return 3;
      default:
        return 0;
    }
  }
}
