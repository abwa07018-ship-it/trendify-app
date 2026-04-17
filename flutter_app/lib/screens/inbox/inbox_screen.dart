import 'package:flutter/material.dart';
import '../../utils/trendify_theme.dart';

class InboxScreen extends StatelessWidget {
  const InboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TrendifyBrand.dark,
      appBar: AppBar(
        title: const Text('All activity', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
        centerTitle: true,
        actions: [IconButton(icon: const Icon(Icons.send_outlined), onPressed: () {})],
      ),
      body: ListView.separated(
        itemCount: 10,
        separatorBuilder: (context, index) => const Divider(color: Colors.white10, indent: 80),
        itemBuilder: (context, i) => ListTile(
          leading: CircleAvatar(backgroundColor: Colors.white12, child: Text('')),
          title: Text('User liked your video', style: const TextStyle(color: Colors.white, fontSize: 14)),
          subtitle: const Text('2h ago', style: TextStyle(color: Colors.white54, fontSize: 12)),
          trailing: Container(width: 40, height: 40, color: Colors.white10, child: const Icon(Icons.play_arrow_rounded, color: Colors.white24)),
        ),
      ),
    );
  }
}
