import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LikePage extends StatelessWidget {
  final String deviceId;

  const LikePage({super.key, required this.deviceId});

  Future<String> getUserName() async {
    // 名前を取得する
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('deviceId', isEqualTo: deviceId)
        .get();

    if (snapshot.docs.isNotEmpty) {
      return snapshot.docs.first['name'] ?? 'NoName';
    } else {
      return 'NoName';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<String>(
          future: getUserName(),
          builder: (context, snapshot) {
            final userName = snapshot.data!;
            return Text("$userName's favorites");
          },
        ),
      ),
    );
  }
}
