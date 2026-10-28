import 'package:flutter/material.dart';

import 'sections/alignment_section.dart';
import 'sections/decoration_section.dart';
import 'sections/flex_section.dart';
import 'sections/stack_section.dart';
import 'widgets/section_card.dart';

void main() {
  runApp(const LayoutLabApp());
}

class LayoutLabApp extends StatelessWidget {
  const LayoutLabApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'layout_lab',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF3D7BFF),
        scaffoldBackgroundColor: const Color(0xFFF2F4F8),
      ),
      home: const LayoutLabPage(),
    );
  }
}

class LayoutLabPage extends StatelessWidget {
  const LayoutLabPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('布局练习册'),
        centerTitle: true,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: const [
              _PageHeader(),
              AlignmentSection(),
              SizedBox(height: 20),
              FlexSection(),
              SizedBox(height: 20),
              StackSection(),
              SizedBox(height: 20),
              DecorationSection(),
              SizedBox(height: 20),
              AiNoteSection(),
              SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}

class AiNoteSection extends StatelessWidget {
  const AiNoteSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const SectionCard(
      title: '5 · AI 使用标注',
      subtitle: '按作业要求，如实标注 AI 参与的部分与我自己的验证方式。',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _AiNoteRow(
            usage: '参数名确认',
            detail: '写 Wrap 时忘了流式间距的参数名，AI 提示是 spacing 与 runSpacing；'
                '改完后在页面上确认标签的横向、纵向间距都生效。',
          ),
          SizedBox(height: 10),
          _AiNoteRow(
            usage: '层叠定位写法',
            detail: 'Stack 里角标位置拿不准，AI 给了 Positioned(right/bottom) 的示例；'
                '我按自己的卡片尺寸重写了数值，并用 Inspector 确认角标没有超出父级。',
          ),
          SizedBox(height: 10),
          _AiNoteRow(
            usage: '未使用 AI 的部分',
            detail: '四个实验的页面结构、配色与布局参数由本人独立设计；'
                'AI 没有直接生成整段代码，所有建议都经过运行验证后才保留。',
          ),
        ],
      ),
    );
  }
}

class _AiNoteRow extends StatelessWidget {
  const _AiNoteRow({required this.usage, required this.detail});

  final String usage;
  final String detail;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 2),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFFEEF3FF),
            borderRadius: BorderRadius.circular(999),
          ),
          child: Text(
            usage,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF3D7BFF),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            detail,
            style: const TextStyle(
              fontSize: 13,
              height: 1.6,
              color: Color(0xFF555C6E),
            ),
          ),
        ),
      ],
    );
  }
}

class _PageHeader extends StatelessWidget {
  const _PageHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '基础组件与布局系统 · 自主实践',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 6),
          Text(
            '六种对齐、弹性分配、层叠角标、容器美化，四个实验都在这一页里。',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFF7A8194),
                ),
          ),
        ],
      ),
    );
  }
}
