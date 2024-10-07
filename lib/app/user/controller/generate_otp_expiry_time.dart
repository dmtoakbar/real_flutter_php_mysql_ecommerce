import 'dart:math';
class GenerateOtpAndExpiryTime {
  static Map<String, dynamic> generateOtpAndExpiry() {
    final otp = Random().nextInt(99999);
    final micros = DateTime.now().microsecondsSinceEpoch;
    final minutes = (( micros / 1000000) /60).truncate();
    final data = {
      'otp' : otp,
       'minutes' : minutes
    };
    return data;
  }
  }