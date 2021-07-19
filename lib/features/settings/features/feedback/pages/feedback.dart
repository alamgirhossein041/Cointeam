import 'dart:developer';

import 'package:coinsnap/features/settings/features/feedback/repos/feedback.dart';
import 'package:coinsnap/features/utils/colors_helper.dart';
import 'package:coinsnap/features/utils/sizes_helper.dart';
import 'package:coinsnap/features/widget_templates/title_bar.dart';
import 'package:coinsnap/ui_components/ui_components.dart';
import 'package:flutter/material.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({Key key}) : super(key: key);

  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final feedbackController = TextEditingController();

  @override
  void dispose() {
    feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryBlue,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Feedback"),
          ),
          backgroundColor: primaryBlue,
          body: Stack(
            children: <Widget> [
              TitleBar(title: "Feedback"),
              Container(
                margin: mainCardMargin(),
                decoration: mainCardDecoration(),
                padding: mainCardPadding(),
                width: displayWidth(context),
                child: Column(
                  children: <Widget> [
                    Text("Leave Feedback For Us"),
                    SizedBox(height: 50),
                    TextField(
                      controller: feedbackController,
                      maxLines: 5,
                      decoration: InputDecoration(
                        // contentPadding: EdgeInsets.only(bottom: 100),
                        border: OutlineInputBorder(),
                        labelText: 'Enter Feedback'
                      ),
                    ),
                    SizedBox(height: 50),
                    Align(
                      alignment: Alignment.center,
                      /// Replace GestureDetector with a Button (raisedbutton or our own button)
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                          height: 50,
                          width: 200,
                          color: Colors.blue[200],
                          child: Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Text("Send", style: TextStyle(fontSize: 20)),
                            ),
                          ),
                        ),
                        onTap: () => _callPostFeedbackRepo(feedbackController.text)
                        /// Add modal dialog saying "Thank you" and the navigate to previous
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _callPostFeedbackRepo(String _message) {
    log("Hi");
    FeedbackImpl feedbackRepository = FeedbackImpl();
    feedbackRepository.postFeedback(_message);
  }
}