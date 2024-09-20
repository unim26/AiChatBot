import 'package:aichatbot/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenheight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      barrierColor: Colors.grey,
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 15,
                              ),
                              //text
                              Text(
                                "Write a suggestion!",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),

                              const SizedBox(
                                height: 15,
                              ),

                              //textfield
                              TextFormField(
                                minLines: 3,
                                maxLines: 8,
                                controller: suggestioncontroller,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Write a suggestion....",
                                  labelStyle: TextStyle(fontSize: 18),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                ),
                              ),

                              const SizedBox(
                                height: 25,
                              ),

                              //sub,it button
                              ElevatedButton(
                                onPressed: () async {
                                  Navigator.pop(context);

                                  if (suggestioncontroller.text.isNotEmpty) {
                                    //email content
                                    final Email email = Email(
                                      body: suggestioncontroller.text,
                                      subject:
                                          'Suggestion regarding AI CHAT BOT',
                                      recipients: ['aniketsagar4323@gmail.com'],
                                      isHTML: false,
                                    );

                                    await FlutterEmailSender.send(email).then(
                                      (value) {
                                        Navigator.pop(context);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              "Thank You! for your suggestion \n We will try our level best..!",
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          "Please! type suggestion if any...!",
                                        ),
                                      ),
                                    );
                                  }
                                },
                                child: Text(
                                  "Submit",
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Text(
                      "Write any Suggestion...!",
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                  ),
                ),
              ),

              const Spacer(),
              //connect with me
              Text(
                "Connect with me :",
                style: TextStyle(
                  fontSize: screenheight * .03,
                  color: Colors.orange,
                ),
              ),

              const SizedBox(
                height: 30,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  //sms
                  GestureDetector(
                    onTap: () async {
                      final sms =
                          Uri.parse('sms:+91 9341307595?body=Hello%20Abhishek');
                      await launchUrl(sms);
                    },
                    child: CircleAvatar(
                      radius: screenheight * .04,
                      child: const Icon(
                        Icons.sms,
                        color: Colors.black,
                      ),
                    ),
                  ),

                  //linkedin url
                  GestureDetector(
                    onTap: () async {
                      final url = Uri.parse(
                          "https://www.linkedin.com/in/abhishek-kumar-3b6b84258/");

                      await launchUrl(
                        url,
                        mode: LaunchMode.inAppWebView,
                      );
                    },
                    child: CircleAvatar(
                      radius: screenheight * .04,
                      child: Image.asset(
                        "assets/linkedin.png",
                      ),
                    ),
                  ),

                  //insta url
                  GestureDetector(
                    onTap: () async {
                      final url = Uri.parse(
                          "https://www.instagram.com/abhishek934130/");

                      await launchUrl(
                        url,
                        mode: LaunchMode.inAppWebView,
                      );
                    },
                    child: CircleAvatar(
                      radius: screenheight * .04,
                      child: Image.asset(
                        "assets/insta.png",
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
