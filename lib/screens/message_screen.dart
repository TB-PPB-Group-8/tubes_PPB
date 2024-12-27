import 'package:flutter/material.dart';

class MessageScreen extends StatefulWidget {
  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  // Mock Database untuk pesan
  List<Map<String, String>> messages = [
    {"title": "Promo Terbatas", "content": "Diskon hingga 50% hanya hari ini!"},
    {"title": "Selamat Datang", "content": "Terima kasih telah bergabung di Lazada."},
    {"title": "Tips Belanja", "content": "Gunakan filter pencarian untuk menemukan produk lebih cepat."},
    {"title": "Pengingat", "content": "Jangan lupa cek LazFlash untuk penawaran menarik."},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pesan', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: ListView.builder(
        itemCount: messages.length,
        itemBuilder: (context, index) {
          final message = messages[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: ListTile(
              leading: Icon(Icons.message, color: Colors.blue),
              title: Text(
                message['title']!,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(message['content']!),
              onTap: () {
                // Navigasi ke detail pesan
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MessageDetailScreen(
                      title: message['title']!,
                      content: message['content']!,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class MessageDetailScreen extends StatelessWidget {
  final String title;
  final String content;

  MessageDetailScreen({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Pesan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              content,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
