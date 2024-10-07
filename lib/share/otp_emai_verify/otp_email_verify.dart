import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class SendOtpEmailVerify {
  static String username = 'dmtoakbar@gmail.com';
  static String password = 'gipu tipi tlvm tboi';
 static final smtpServer = gmail(username, password);

 static Message passEmailCredential ({required String recipient, required String otp}) {

   DateTime now = DateTime.now();
   DateTime date = DateTime(now.year, now.month, now.day, now.hour, now.minute);
   const String firstMessage = "<h1 style='color: black;'>Nexus Shop</h1><h4>Hello</h4><p>Thank you for choosing Nexus Shop for shopping. Use the following OTP to verify your email. OTP is valid for 5 minutes.</p></br>";
   final String middleMessage = "<p style='text-align: center;'><span style='background-color: blue; padding: 8px; font-weight: bold; border-radius: 4px; color: white; width: 100px; height: 60;'>$otp</span></p>";
   const String lastMessage = "<br/> <p>Regards: Nexus shop</p>";

   final message = Message()
     ..from = Address(username, 'Nexus Shop ${now.hour} : ${now.minute}')
     ..recipients.add(recipient)
     ..subject = 'Verify Your Email By Using OTP \n ${date.toString().replaceAll(":00.000", "")}'
     ..html = "$firstMessage $middleMessage $lastMessage";

   return message;
 }

}