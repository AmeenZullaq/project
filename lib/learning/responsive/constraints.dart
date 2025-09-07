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
                    maxWidth: MediaQuery.sizeOf(context).width - (20 * 2 - 16),
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

class FittedBoxEx extends StatelessWidget {
  const FittedBoxEx({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 90,
          height: 44,
          color: Colors.amber,
          child: FittedBox(
            child: Text(
              'this is a pretty long text',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
