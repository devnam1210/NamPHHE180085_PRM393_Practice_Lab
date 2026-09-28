import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News Feed UI',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const NewsFeedScreen(),
    );
  }
}

class NewsFeedScreen extends StatelessWidget {
  const NewsFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200], // Màu nền hơi xám để nổi bật các Card
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.5,
        title: const Text('News Feed', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          IconButton(icon: const Icon(Icons.notifications), onPressed: () {}),
        ],
      ),
      body: ListView(
        children: [
          // 1. Khối Tạo Bài Viết
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Row(
              children: [
                const CircleAvatar(
                  backgroundImage: NetworkImage('https://picsum.photos/100'),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    alignment: Alignment.centerLeft,
                    child: const Text('Bạn đang nghĩ gì?', style: TextStyle(color: Colors.grey)),
                  ),
                ),
                const SizedBox(width: 12),
                const Icon(Icons.image, color: Colors.green),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // 2. Khối Stories
          Container(
            color: Colors.white,
            height: 200,
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              itemCount: 5,
              itemBuilder: (context, index) {
                return Container(
                  width: 110,
                  margin: const EdgeInsets.symmetric(horizontal: 8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: NetworkImage('https://picsum.photos/200/300?random=$index'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 8,
                        left: 8,
                        child: CircleAvatar(
                          radius: 18,
                          backgroundColor: Colors.blue,
                          child: CircleAvatar(
                            radius: 16,
                            backgroundImage: NetworkImage('https://picsum.photos/100?random=${index + 10}'),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 8,
                        left: 8,
                        child: Text(
                          index == 0 ? 'Tạo tin' : 'User $index',
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),

          // 3. Khối Bài Viết (Post)
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header bài viết
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        backgroundImage: NetworkImage('https://picsum.photos/101'),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Lan Anh', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            Text('2 giờ trước • 🌍', style: TextStyle(color: Colors.grey, fontSize: 12)),
                          ],
                        ),
                      ),
                      IconButton(icon: const Icon(Icons.more_horiz), onPressed: () {}),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                
                // Nội dung Text
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Một buổi sáng thật đẹp! 🌿\nThiên nhiên luôn có cách khiến chúng ta cảm thấy bình yên và tràn đầy năng lượng.',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                const SizedBox(height: 12),
                
                // Nội dung Ảnh
                Image.network(
                  'https://picsum.photos/600/300',
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 12),
                
                // Thống kê tương tác
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('👍❤️ 345', style: TextStyle(color: Colors.grey)),
                      Text('48 bình luận • 12 lượt chia sẻ', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
                const Divider(height: 24, thickness: 1),
                
                // Các nút hành động
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildActionButton(Icons.thumb_up_alt_outlined, 'Thích'),
                    _buildActionButton(Icons.chat_bubble_outline, 'Bình luận'),
                    _buildActionButton(Icons.reply_outlined, 'Chia sẻ'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // Cần thiết khi có hơn 3 item
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Trang chủ'),
          BottomNavigationBarItem(icon: Icon(Icons.explore_outlined), label: 'Khám phá'),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle, color: Colors.blue, size: 36), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.notifications_none), label: 'Thông báo'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Cá nhân'),
        ],
      ),
    );
  }

  // Hàm hỗ trợ tạo nút bấm tương tác cho gọn code
  Widget _buildActionButton(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey[600], size: 20),
        const SizedBox(width: 8),
        Text(text, style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w500)),
      ],
    );
  }
}