class ValidateOtp {

  static Map<String, dynamic> validateOtp(
      {required int time,
      required int generatedOtp,
      required int userInterOtp}) {
    // check otp
    if (generatedOtp == userInterOtp) {
      final micros = DateTime.now().microsecondsSinceEpoch;
      final minutes = ((micros / 1000000) / 60).truncate() - time;
      // check time expiry
      if (minutes <= 5) {
        final data = {'status': 1, 'message': 'OTP verified successfully..'};
        return data;
      } else {
        final data = {'status': 2, 'message': 'OTP is expired..'};
        return data;
      }
    } else {
      final data = {
        'status': 3,
        'message': 'Wrong OTP, Check and enter again..'
      };
      return data;
    }
  }
  
}
