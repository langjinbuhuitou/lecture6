import 'package:flutter/material.dart';

import '../widgets/section_card.dart';

/// 六种对齐场景：五个主轴对齐 + 一个交叉轴对齐。
class AlignmentSection extends StatelessWidget {
  const AlignmentSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: '1 · 对齐任务卡',
      subtitle: '灰度容器代表父级给的约束，三个小方块是子组件。',
      child: Wrap(
        spacing: 16,
        runSpacing: 16,
        children: const [
          _AlignDemo(
            label: 'mainAxisAlignment: start',
            alignment: MainAxisAlignment.start,
          ),
          _AlignDemo(
            label: 'mainAxisAlignment: center',
            alignment: MainAxisAlignment.center,
          ),
          _AlignDemo(
            label: 'mainAxisAlignment: spaceBetween',
            alignment: MainAxisAlignment.spaceBetween,
          ),
          _AlignDemo(
            label: 'mainAxisAlignment: spaceAround',
            alignment: MainAxisAlignment.spaceAround,
          ),
          _AlignDemo(
            label: 'mainAxisAlignment: spaceEvenly',
            alignment: MainAxisAlignment.spaceEvenly,
          ),
          _AlignDemo(
            label: 'crossAxisAlignment: end',
            alignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
          ),
        ],
      ),
    );
  }
}

class _AlignDemo extends StatelessWidget {
  const _AlignDemo({
    required this.label,
    required this.alignment,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  });

  final String label;
  final MainAxisAlignment alignment;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 440,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF555C6E),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            height: 68,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFF7F8FC),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: alignment,
              crossAxisAlignment: crossAxisAlignment,
              children: const [
                _Block(height: 20),
                _Block(height: 32),
                _Block(height: 26),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Block extends StatelessWidget {
  const _Block({required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28,
      height: height,
      decoration: BoxDecoration(
        color: const Color(0xFF3D7BFF),
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}
