import 'package:flutter/material.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Feed',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    );
  }
}
