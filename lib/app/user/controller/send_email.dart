import 'package:mailer/mailer.dart';
import '../../../share/otp_emai_verify/otp_email_verify.dart';

class SendEmailUser {
  static Future<bool> sendEmail({required String recipientEmail, required int otp}) async {
    try {
      final sendReport = await send(
          SendOtpEmailVerify.passEmailCredential(
              recipient: recipientEmail, otp: otp.toString()),
          SendOtpEmailVerify.smtpServer);
        return true;
    } on MailerException catch (e) {
      return false;
    }
  }
}
