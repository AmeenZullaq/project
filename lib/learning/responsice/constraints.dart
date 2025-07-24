import 'package:flutter/material.dart';

class Constraints extends StatelessWidget {
  const Constraints({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                ),
                SizedBox(
                  width: 16,
                ),
                Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.sizeOf(context).width - 56,
                  ),
                  color: Colors.amber,
                  child: Text('hello world'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
