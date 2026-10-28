import 'package:flutter/material.dart';

import '../widgets/section_card.dart';

/// 弹性分配实验：同样的父宽度，flex 比例不同，得到不同的宽度分配。
class FlexSection extends StatelessWidget {
  const FlexSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const SectionCard(
      title: '2 · 弹性分配实验',
      subtitle: 'Expanded 按 flex 占剩余空间；同一个容器换一组比例，宽度立刻重新分配。',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _FlexRow(label: 'flex 1 : 1 : 1', flexes: [1, 1, 1]),
          SizedBox(height: 14),
          _FlexRow(label: 'flex 1 : 2 : 1', flexes: [1, 2, 1]),
          SizedBox(height: 14),
          _FlexRow(label: 'flex 2 : 1 : 1', flexes: [2, 1, 1]),
          SizedBox(height: 10),
          Text(
            '三行对比说明：父级宽度不变，Expanded 只改分配比例，不改父级约束。',
            style: TextStyle(fontSize: 12, color: Color(0xFF8A90A2)),
          ),
        ],
      ),
    );
  }
}

class _FlexRow extends StatelessWidget {
  const _FlexRow({required this.label, required this.flexes});

  final String label;
  final List<int> flexes;

  @override
  Widget build(BuildContext context) {
    const palette = [Color(0xFF3D7BFF), Color(0xFF7C9BFF), Color(0xFFB7C8FF)];

    return Row(
      children: [
        SizedBox(
          width: 96,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF555C6E),
            ),
          ),
        ),
        Expanded(
          child: Row(
            children: [
              for (var i = 0; i < flexes.length; i++)
                Expanded(
                  flex: flexes[i],
                  child: Container(
                    height: 52,
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: palette[i],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'flex ${flexes[i]}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
