import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

abstract class IFeedbackRepository {
  void postFeedback(String _message);
}

class FeedbackImpl implements IFeedbackRepository {
  @override
  void postFeedback(String _message) async {
    String requestUrl = 'http://13.211.80.118:8888/feedback';

    var response = http.post(
      requestUrl,
      headers: <String, String> {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String> {
        'text': _message
      })
    );
    log(response.toString());
    log("Email sent");
  }
}