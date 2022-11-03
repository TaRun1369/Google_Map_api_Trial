import 'package:flutter/material.dart';
import 'package:screens_for_touristapp/themes/app_colors.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient:mainGradient(context)),
        child: Column(
          children: [
            Expanded(
                flex: 4,
                child: Center(
                  child: Container(
                    child: Image.asset("assets/loading_page/tourist_man.gif"),

                  ),
                )
            ),
            Expanded(
                flex: 1,
                child:Center(
                  child: const Text("Please Wait....",style: TextStyle(
                    fontSize: 30
                  ),),
                )
            ),
            Expanded(
                flex: 3,
                child: Center(
                  child: SizedBox(height: 40),
                )
            ),
          ],
        ),
      ),
    );
  }
}
