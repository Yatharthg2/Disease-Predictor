import 'package:flutter/material.dart';
import 'package:disease_predictor/imageupload.dart';
import 'package:flutter/services.dart';

// WELCOME PAGE

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 12.0, right: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 50, bottom: 30),
                height: 300,
                width: 300,
                child: Hero(
                  tag: 'profileImage',
                  child: ClipOval(
                    child: SizedBox.fromSize(
                      size: const Size.fromRadius(48), // Image radius
                      child: Image.asset(
                        "assets/Doc.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              const Text(
                "Check Your Skin -\nJust take a photo!",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              const Spacer(),
              Container(
                  margin: const EdgeInsets.only(bottom: 30),
                  height: 35,
                  width: 150,
                  child: ElevatedButton(
                      style: ButtonStyle(

                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0))),
                      ),
                      child: const Text("Next"),
                      onPressed: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                              return const ImageUploadPage();
                            }));
                      })),
            ],
          ),
        ),
      ),
    );
  }
}