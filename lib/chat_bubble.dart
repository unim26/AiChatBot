import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final  message;

  final bool iscurrentuser;

  const ChatBubble({
    super.key,
    required this.iscurrentuser,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: iscurrentuser ? Colors.grey.shade200 : Colors.grey.shade400,
        borderRadius: BorderRadius.circular(12).copyWith(
          bottomLeft: iscurrentuser
              ? const Radius.circular(12)
              : const Radius.circular(0),
          bottomRight: iscurrentuser
              ? const Radius.circular(0)
              : const Radius.circular(12),
        ),
      ),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
      child: Column(
        crossAxisAlignment:
            iscurrentuser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          //message
          Text(
            message.toString(),
            style: const TextStyle(
              fontSize: 17,
            ),
          ),
        ],
      ),
    );
  }
}
