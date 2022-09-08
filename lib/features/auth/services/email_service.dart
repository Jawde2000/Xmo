import 'package:flutter_email_sender/flutter_email_sender.dart';

void sendEmail(
    {required String body,
    required String subject,
    required List<String> recipients,
    required List<String> cc,
    required List<String> bcc,
    required List<String> atp}) async {
  final Email sendEmail = Email(
    body: body,
    subject: subject,
    recipients: recipients,
    cc: cc,
    bcc: bcc,
    attachmentPaths: atp,
    isHTML: false,
  );

  await FlutterEmailSender.send(sendEmail);
}
