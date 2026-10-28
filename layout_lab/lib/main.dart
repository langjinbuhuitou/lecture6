import 'package:flutter/material.dart';

import 'sections/alignment_section.dart';
import 'sections/flex_section.dart';
import 'sections/stack_section.dart';

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
              SizedBox(height: 8),
            ],
          ),
        ),
      ),
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
