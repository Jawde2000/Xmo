import 'package:ximo/common/widgets/custom_navbar.dart';
import 'package:ximo/constants/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:ximo/features/auth/screens/add_recommendation.dart';

class XmoScreen extends StatefulWidget {
  static const String routeName = "/xmo";
  const XmoScreen({Key? key}) : super(key: key);

  @override
  State<XmoScreen> createState() => _XmoScreenState();
}

class _XmoScreenState extends State<XmoScreen> {
  // Offset _offset = Offset.zero;
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
      backgroundColor: globalV.backgroundColor,
      floatingActionButton: Stack(
        children: [
          Positioned(
            right: 10,
            bottom: 50,
            child: FloatingActionButton(
              onPressed: () {},
              backgroundColor: globalV.backgroundColor,
              child: GestureDetector(
                // onPanUpdate: (d) =>
                //     setState(() => _offset += Offset(d.delta.dx, d.delta.dy)),
                child: const Icon(Icons.add),
                onTap: () => {
                  Navigator.pushNamedAndRemoveUntil(
                      context,
                      addRecommendation.routeName,
                      (Route<dynamic> route) => true)
                },
              ),
            ),
          ),
        ],
      ),
      body: const NavBar(),
    );
  }
}
