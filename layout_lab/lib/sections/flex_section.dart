import 'package:flutter/material.dart';

import '../widgets/section_card.dart';

/// 弹性分配实验：同样的父宽度，flex 比例不同，得到不同的宽度分配。
/// 多一个开关，用来观察"某一栏内容超长"时会发生什么。
class FlexSection extends StatefulWidget {
  const FlexSection({super.key});

  @override
  State<FlexSection> createState() => _FlexSectionState();
}

class _FlexSectionState extends State<FlexSection> {
  bool longContent = false;

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: '2 · 弹性分配实验',
      subtitle: 'Expanded 按 flex 占剩余空间；父级宽度不变，只改比例，宽度立刻重新分配。',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _FlexRow(label: 'flex 1 : 1 : 1', flexes: [1, 1, 1]),
          const SizedBox(height: 14),
          const _FlexRow(label: 'flex 2 : 1 : 1', flexes: [2, 1, 1]),
          const SizedBox(height: 14),
          const _FlexRow(label: 'flex 1 : 2 : 1', flexes: [1, 2, 1]),
          const SizedBox(height: 16),
          Row(
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '让中间那一栏塞进超长内容',
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 2),
                    Text(
                      '打开后中间栏放一段不允许换行的长文本，观察它的溢出表现。',
                      style: TextStyle(fontSize: 11.5, color: Color(0xFF8A90A2)),
                    ),
                  ],
                ),
              ),
              Switch(
                value: longContent,
                onChanged: (v) => setState(() => longContent = v),
              ),
            ],
          ),
          if (longContent) ...[
            _FlexRow(
              label: '内容超长',
              flexes: const [2, 1, 1],
              overflowDemo: true,
            ),
            const SizedBox(height: 10),
            const Text(
              '现象：中间栏的宽度由 flex 决定，里面四个固定宽度的小块加起来超过了这一栏的约束，'
              '于是调试模式下出现黄黑斜纹，提醒"约束给多少就只能用多少"。'
              '内容超过约束时要自己选策略（换行、省略号或 FittedBox 缩放），'
              '而不是指望 Expanded 自动兜底。',
              style: TextStyle(fontSize: 12, height: 1.7, color: Color(0xFF7A8194)),
            ),
          ],
        ],
      ),
    );
  }
}

class _FlexRow extends StatelessWidget {
  const _FlexRow({
    required this.label,
    required this.flexes,
    this.overflowDemo = false,
  });

  final String label;
  final List<int> flexes;
  final bool overflowDemo;

  @override
  Widget build(BuildContext context) {
    const palette = [Color(0xFF3D7BFF), Color(0xFF7C9BFF), Color(0xFFB7C8FF)];

    return Row(
      children: [
        SizedBox(
          width: 96,
          child: Text(
            label,
            style: const TextStyle(fontSize: 12, color: Color(0xFF555C6E)),
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
                    // 中间栏打开"超长内容"时，塞进一排固定宽度的小块：
                    // 它们的总宽度超过这一栏的约束，就会把这一栏撑破。
                    child: i == 1 && overflowDemo
                        ? Row(
                            children: [
                              for (var k = 0; k < 4; k++)
                                Container(
                                  width: 52,
                                  height: 22,
                                  margin: const EdgeInsets.only(right: 4),
                                  decoration: BoxDecoration(
                                    color: const Color(0x73FFFFFF),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                            ],
                          )
                        : Text(
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
