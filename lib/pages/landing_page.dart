import 'package:flutter/material.dart';
import 'package:news_app/pages/login.dart';
import 'package:news_app/pages/signup.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: Column(
            children: [
              Material(
                elevation: 3.0,
                borderRadius: BorderRadius.circular(30),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.asset(
                    "images/landingPage.png",
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 1.5,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                "News From Around the\n         World for you! ",
                style: TextStyle(
                    color: Colors.green,
                    fontSize: 26.0,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                "Unlock a world of stories, start exploring today\n                         with TimesNews",
                style: TextStyle(
                    color: Colors.black45,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 40.0,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.2,
                child: Material(
                  borderRadius: BorderRadius.circular(30),
                  elevation: 5.0,
                  child: GestureDetector(
                    onTap: () {
                      // Navigate to the SignupPage
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => SignupPage()),
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      padding: EdgeInsets.symmetric(vertical: 15.0),
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(30)),
                      child: Center(
                        child: Text(
                          "Get Started! ",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17.0,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0), // Add some space
              GestureDetector(
                onTap: () {
                  // Navigate to the LoginPage
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: Text(
                  "Already have an account? Log in!",
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
