import 'package:flutter/material.dart';

import '../widgets/section_card.dart';

/// 容器美化：圆角、阴影、ClipRRect 与 ClipOval 三种常见做法。
class DecorationSection extends StatelessWidget {
  const DecorationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const SectionCard(
      title: '4 · 容器美化',
      subtitle: 'Container 负责装饰，ClipRRect 与 ClipOval 负责把子组件剪成目标形状。',
      child: Wrap(
        spacing: 20,
        runSpacing: 20,
        children: [
          _ShadowCard(),
          _ClippedBanner(),
          _OvalAvatar(),
        ],
      ),
    );
  }
}

class _ShadowCard extends StatelessWidget {
  const _ShadowCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      height: 140,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A1F2430),
            blurRadius: 16,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.auto_awesome, color: Color(0xFF3D7BFF)),
          Spacer(),
          Text(
            '圆角 + 阴影',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text(
            'radius 18 / blur 16 / offset y8',
            style: TextStyle(fontSize: 11, color: Color(0xFF8A90A2)),
          ),
        ],
      ),
    );
  }
}

class _ClippedBanner extends StatelessWidget {
  const _ClippedBanner();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      height: 140,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF3D7BFF), Color(0xFF63C7FF)],
            ),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ClipRRect',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Spacer(),
              Text(
                '整块渐变按 18 圆角剪裁，子组件不会溢出边框。',
                style: TextStyle(fontSize: 11, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OvalAvatar extends StatelessWidget {
  const _OvalAvatar();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      height: 140,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F8FC),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          ClipOval(
            child: Container(
              width: 80,
              height: 80,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF8A6BFF), Color(0xFF3D7BFF)],
                ),
              ),
              child: const Icon(Icons.face, color: Colors.white, size: 40),
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'ClipOval',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  '正方形渐变被剪成圆形头像。',
                  style: TextStyle(fontSize: 11, color: Color(0xFF8A90A2)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
