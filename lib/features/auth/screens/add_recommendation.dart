import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ximo/constants/global_variables.dart';
import 'package:ximo/constants/utils.dart';
import 'package:ximo/features/auth/services/ScreenSize.dart';
import 'package:ximo/features/auth/services/auth_service.dart';
import 'package:ximo/models/post.dart';

import 'Xmo_screen.dart';

// ignore: camel_case_types
class addRecommendation extends StatefulWidget {
  static const String routeName = "/add-alarm";
  const addRecommendation({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _addRecommendationState();
}

// ignore: camel_case_types
class _addRecommendationState extends State<addRecommendation> with screenSize {
  final TextEditingController _recommendationController = TextEditingController();
  final AuthService authService = AuthService();

  void posting(String messageBody) {
    if (messageBody.isNotEmpty) {
      authService.post(messageBody, context);
    } else {
      showToast("message should not be empty");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBar(
            backgroundColor: globalV.backgroundColor,
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GestureDetector(
                  child: const Icon(Icons.post_add),
                  onTap: () => {
                    posting(_recommendationController.text)
                  },
                ),
              ),
            ],
          ),
          Expanded(
            child: TextField(
              maxLines: null,
              expands: true,
              controller: _recommendationController,
              keyboardType: TextInputType.multiline,
              decoration: const InputDecoration(
                hintText: "Enter your message here",
                contentPadding: EdgeInsets.all(30.0),
                isDense: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
