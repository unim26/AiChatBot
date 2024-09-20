import 'package:aichatbot/consts.dart';
import 'package:aichatbot/chat_bubble.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  XFile? file;
  //load banner
  BannerAd? bannerAd;

  final ScrollController _scrollController = ScrollController();

  bool aityping = false;

  int count = 0;

  final banneradunit = "ca-app-pub-9963347352938544/8367922752";

  void loadbannerAd() {
    bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: banneradunit,
      listener: BannerAdListener(
        onAdLoaded: (ad) {},
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
      request: const AdRequest(),
    )..load();
  }

  //rewarded ad
  final rewardedadunit = "ca-app-pub-9963347352938544/3490737264";
  RewardedAd? myrewardedAd;

  void loadrewardedad() {
    RewardedAd.load(
      adUnitId: rewardedadunit,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          myrewardedAd = ad;
        },
        onAdFailedToLoad: (error) {},
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    loadbannerAd();
    loadrewardedad();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("AI Chat Bot"),
          actions: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Hive.box("chatbotbox").clear();
                    setState(() {});
                  },
                  icon: const Icon(
                    Icons.delete,
                    size: 35,
                  ),
                ),
              ],
            )
          ],
          backgroundColor: Colors.grey.shade400,
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 10,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // bannerAd != null
              //     ? Align(
              //         alignment: Alignment.bottomCenter,
              //         child: SafeArea(
              //             child: SizedBox(
              //           width: bannerAd!.size.width.toDouble(),
              //           height: bannerAd!.size.height.toDouble(),
              //           child: AdWidget(ad: bannerAd!),
              //         )),
              //       )
              //     :
              aityping
                  ? const Text(
                      "Typing......",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : const Text(""),
              //messages

              Hive.box("chatbotbox").isEmpty
                  ? const Expanded(
                      child: Center(
                        child: Text(
                          textAlign: TextAlign.center,
                          "Start a new conversation....!",
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        ),
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        controller: _scrollController,
                        itemCount: Hive.box("chatbotbox").length,
                        itemBuilder: (context, index) {
                          final alignment =
                              Hive.box("chatbotbox").get(index)?[1] == "you"
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft;
                          return Container(
                            alignment: alignment,
                            child: Column(
                              crossAxisAlignment:
                                  Hive.box("chatbotbox").get(index)?[1] == "you"
                                      ? CrossAxisAlignment.end
                                      : CrossAxisAlignment.start,
                              children: [
                                ChatBubble(
                                  iscurrentuser:
                                      Hive.box("chatbotbox").get(index)?[1] ==
                                          "you",
                                  message:
                                      Hive.box("chatbotbox").get(index)?[0],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),

              //textbox
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                child: TextFormField(
                  autocorrect: true,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                  controller: messagecontroller,
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: "Type you Question.......?",
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      suffixIcon: //send text
                          IconButton(
                        onPressed: () {
                          //ask question
                          askquestion();
                        },
                        icon: const Icon(Icons.send),
                      )
                      // suffix: Row(
                      //   mainAxisAlignment: MainAxisAlignment.end,
                      //   children: [
                      //     //send image

                      //     IconButton(
                      //       onPressed: () async {
                      //         ScaffoldMessenger.of(context).showSnackBar(
                      //           const SnackBar(
                      //             content: Text(
                      //               "Comming Soon!!!",
                      //             ),
                      //           ),
                      //         );
                      //         // //ask question
                      //         // ImagePicker picker = ImagePicker();
                      //         // file = await picker.pickImage(
                      //         //   source: ImageSource.gallery,
                      //         // );

                      //         // if (file != null) {
                      //         //   //add to list
                      //         //   messages.add(
                      //         //     [
                      //         //       "Describe this image",
                      //         //       file!.path,
                      //         //       "you",
                      //         //     ],
                      //         //   );

                      //         //   await Gemini.instance.textAndImage(
                      //         //     text: "Describe this image",
                      //         //     images: file!.readAsBytes(),
                      //         //   );
                      //         // }
                      //       },
                      //       icon: const Icon(Icons.image),
                      //     ),

                      //     //send text
                      //     IconButton(
                      //       onPressed: () {
                      //         //ask question
                      //         askquestion();
                      //       },
                      //       icon: const Icon(Icons.send),
                      //     ),
                      //   ],
                      // ),
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //askquestion
  void askquestion() {
    //check if their is something to ask
    if (messagecontroller.text.isNotEmpty) {
      if (count == 2) {
        //show ad
        // myrewardedAd!.show(
        //   onUserEarnedReward: (ad, reward) {
        //     loadrewardedad();
        //     count = 0;
        //   },
        // );

        //load ad
      }
      //create instance of user question

      final question = messagecontroller.text;
      //add user question to list and show to user
      // messages.add(
      //   [question, "you"],
      // );

      Hive.box("chatbotbox").add(
        [
          question,
          "you",
        ],
      ).then((_) {
        aityping = true;
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
        setState(() {});
      });

      //clear text controller
      messagecontroller.clear();

      //ask question to gemini

      Gemini.instance.streamGenerateContent(question).listen(
        (value) {
          // messages.add(
          //   //if gemini give us answer then also add thhis to list and show to user
          //   [
          //     value.output.toString(),
          //     "AI",
          //   ],
          // );

          Hive.box("chatbotbox").add(
            [
              value.output.toString(),
              "AI",
            ],
          ).then((_) {
            _scrollController
                .jumpTo(_scrollController.position.maxScrollExtent);
            setState(() {});
          });

          count++;
          aityping = false;

          setState(() {});
        },
      );

      setState(() {});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Please! Type your message first",
          ),
        ),
      );
    }
  }
}
