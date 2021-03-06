import 'package:coinsnap/v2/helpers/sizes_helper.dart';
import 'package:coinsnap/v2/repo/db_repo/test/portfolio_post.dart';
import 'package:flutter/material.dart';

class ColourfulButton extends StatelessWidget {
  ColourfulButton({Key key}) : super(key: key);

  final DBPortfolioPostTest dbPortfolioPostTest = DBPortfolioPostTest();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: displayHeight(context) * 0.062,
      width: displayWidth(context) * 0.25,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(7)),
        ),
        child: InkWell(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              gradient: LinearGradient(
                begin: Alignment(-0.9, -1.3),
                end: Alignment(1.25, 1.25),
                colors: [Color(0xFF8300FF), Color(0xFF006BFF)]
              ),
            ),
            child: Align(
              alignment: Alignment.center,
              child: Text("Update", style: TextStyle(color: Colors.white))
            ),
          ),
          onTap: () => {
            // Navigator.pushNamed(context, '/hometest'),
            dbPortfolioPostTest.dbPortfolioPostTest(),
          },
        ),
        elevation: 2,
      ),
    );
  }
}