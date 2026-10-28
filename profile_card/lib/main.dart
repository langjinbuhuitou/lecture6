import 'package:flutter/material.dart';

void main() {
  runApp(const ProfileCardApp());
}

class ProfileCardApp extends StatelessWidget {
  const ProfileCardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'profile_card',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF4C6FFF),
        scaffoldBackgroundColor: const Color(0xFFF4F5F9),
      ),
      home: const ProfileCardPage(),
    );
  }
}

class ProfileCardPage extends StatelessWidget {
  const ProfileCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('个人名片'),
        centerTitle: true,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // 头像区
                const CircleAvatar(
                  radius: 44,
                  backgroundColor: Color(0xFFE3E9FF),
                  child: Icon(
                    Icons.person,
                    size: 48,
                    color: Color(0xFF4C6FFF),
                  ),
                ),
                const SizedBox(height: 16),
                // 姓名与签名
                const Text(
                  '林金豪',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1F2430),
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Stay hungry, stay foolish.',
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF8A90A2),
                  ),
                ),
                const SizedBox(height: 24),
                // 统计条：三个 Expanded 数字块
                Row(
                  children: const [
                    Expanded(child: _StatItem(value: '128', label: '关注')),
                    Expanded(child: _StatItem(value: '2.4k', label: '粉丝')),
                    Expanded(child: _StatItem(value: '9.8k', label: '获赞')),
                  ],
                ),
                const SizedBox(height: 24),
                // 标签云
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  alignment: WrapAlignment.center,
                  children: const [
                    _TagLabel(text: 'Flutter'),
                    _TagLabel(text: '布局'),
                    _TagLabel(text: '交互设计'),
                    _TagLabel(text: '摄影'),
                    _TagLabel(text: '篮球'),
                    _TagLabel(text: '独立开发'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1F2430),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF8A90A2),
          ),
        ),
      ],
    );
  }
}

class _TagLabel extends StatelessWidget {
  const _TagLabel({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      color: const Color(0xFFF1F3F8),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12,
          color: Color(0xFF555C6E),
        ),
      ),
    );
  }
}
