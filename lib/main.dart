import 'package:flutter/material.dart';

void main() {
  runApp(const CommunityApp());
}

class CommunityApp extends StatelessWidget {
  const CommunityApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NexCommunity',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0D1117),
        cardColor: const Color(0xFF161B22),
        primaryColor: Colors.deepPurpleAccent,
      ),
      home: const CommunityHomeScreen(),
    );
  }
}

class PostModel {
  final String author;
  final String content;
  final String time;
  int upvotes;
  bool isUpvoted;

  PostModel({
    required this.author,
    required this.content,
    required this.time,
    this.upvotes = 0,
    this.isUpvoted = false,
  });
}

class CommunityHomeScreen extends StatefulWidget {
  const CommunityHomeScreen({super.key});

  @override
  State<CommunityHomeScreen> createState() => _CommunityHomeScreenState();
}

class _CommunityHomeScreenState extends State<CommunityHomeScreen> {
  final List<PostModel> _posts = [
    PostModel(
      author: "SuperFan99",
      content: "Bhai log, community platform successfully active ho gaya hai! Naye discussions yahan shuru karein.",
      time: "Abhi abhi",
      upvotes: 12,
    ),
    PostModel(
      author: "AnimeMaster",
      content: "Kya kisi ne naya action episode dekha? Fight choreography ekdum top tier thi!",
      time: "20 min pehle",
      upvotes: 35,
    ),
  ];

  final TextEditingController _postController = TextEditingController();

  void _addNewPost() {
    if (_postController.text.trim().isEmpty) return;

    setState(() {
      _posts.insert(
        0,
        PostModel(
          author: "Main User",
          content: _postController.text.trim(),
          time: "Abhi",
          upvotes: 0,
        ),
      );
    });

    _postController.clear();
    Navigator.of(context).pop();
  }

  void _showCreatePostSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF161B22),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          left: 16,
          right: 16,
          top: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "Nayi Post Likhein",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _postController,
              maxLines: 4,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Community ke saath kya share karna chahte hain?",
                hintStyle: const TextStyle(color: Colors.grey),
                filled: true,
                fillColor: const Color(0xFF0D1117),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurpleAccent,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: _addNewPost,
              child: const Text("Publish Post", style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }

  void _showSummaryDialog(String content) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF161B22),
        title: const Row(
          children: [
            Icon(Icons.auto_awesome, color: Colors.deepPurpleAccent),
            SizedBox(width: 8),
            Text("AI Smart Summary", style: TextStyle(color: Colors.white)),
          ],
        ),
        content: Text(
          "Core Highlight: \"${content.length > 50 ? '${content.substring(0, 50)}...' : content}\"",
          style: const TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Band Karein", style: TextStyle(color: Colors.deepPurpleAccent)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("NexCommunity Hub", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF161B22),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.flash_on, color: Colors.amber),
            tooltip: "Pro Features Active",
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: _posts.length,
        itemBuilder: (context, index) {
          final post = _posts[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.deepPurple,
                        child: Text(post.author[0], style: const TextStyle(color: Colors.white)),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(post.author, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          Text(post.time, style: const TextStyle(color: Colors.grey, fontSize: 11)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(post.content, style: const TextStyle(color: Colors.white70, fontSize: 14)),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            post.isUpvoted = !post.isUpvoted;
                            post.upvotes += post.isUpvoted ? 1 : -1;
                          });
                        },
                        child: Row(
                          children: [
                            Icon(
                              post.isUpvoted ? Icons.thumb_up : Icons.thumb_up_alt_outlined,
                              size: 18,
                              color: post.isUpvoted ? Colors.deepPurpleAccent : Colors.grey,
                            ),
                            const SizedBox(width: 6),
                            Text("${post.upvotes}", style: const TextStyle(color: Colors.grey, fontSize: 12)),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      const Icon(Icons.mode_comment_outlined, size: 18, color: Colors.grey),
                      const Spacer(),
                      TextButton.icon(
                        icon: const Icon(Icons.auto_awesome, size: 16, color: Colors.deepPurpleAccent),
                        label: const Text("Summarize", style: TextStyle(color: Colors.deepPurpleAccent, fontSize: 12)),
                        onPressed: () => _showSummaryDialog(post.content),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurpleAccent,
        onPressed: _showCreatePostSheet,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
