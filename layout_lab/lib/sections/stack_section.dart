import 'package:flutter/material.dart';

import '../widgets/section_card.dart';

/// 层叠角标：Stack + Positioned，做一个课程封面和头像在线状态。
class StackSection extends StatelessWidget {
  const StackSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const SectionCard(
      title: '3 · 层叠角标',
      subtitle: 'Stack 从底到顶绘制，Positioned 只影响定位子项，不影响 Stack 自身的尺寸。',
      child: Wrap(
        spacing: 24,
        runSpacing: 20,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          _CoverStack(),
          _AvatarStack(),
        ],
      ),
    );
  }
}

class _CoverStack extends StatelessWidget {
  const _CoverStack();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 420,
      height: 200,
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF3D7BFF), Color(0xFF8A6BFF)],
                ),
              ),
            ),
          ),
          const Positioned(
            left: 20,
            bottom: 18,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Flutter 布局实战',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  '第 6 课 · 层叠与角标',
                  style: TextStyle(fontSize: 12, color: Colors.white70),
                ),
              ],
            ),
          ),
          Positioned(
            top: 12,
            right: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFFFC53D),
                borderRadius: BorderRadius.circular(999),
              ),
              child: const Text(
                'NEW',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6B4B00),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AvatarStack extends StatelessWidget {
  const _AvatarStack();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      height: 200,
      child: Center(
        child: SizedBox(
          width: 140,
          height: 150,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              const CircleAvatar(
                radius: 48,
                backgroundColor: Color(0xFFE3E9FF),
                child: Icon(Icons.person, size: 52, color: Color(0xFF3D7BFF)),
              ),
              Positioned(
                right: 12,
                bottom: 32,
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: const Color(0xFF32C48D),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 3),
                  ),
                ),
              ),
              Positioned(
                top: 6,
                right: 6,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1F2430),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: const Text(
                    'LV.6',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
