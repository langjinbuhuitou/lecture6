import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:layout_lab/main.dart';

void main() {
  testWidgets('布局练习册包含四个实验区块', (WidgetTester tester) async {
    // 页面是长列表，先把测试画布调高，保证四个区块都被构建出来。
    tester.view.physicalSize = const Size(1400, 3600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const LayoutLabApp());

    expect(find.text('1 · 对齐任务卡'), findsOneWidget);
    expect(find.text('2 · 弹性分配实验'), findsOneWidget);
    expect(find.text('3 · 层叠角标'), findsOneWidget);
    expect(find.text('4 · 容器美化'), findsOneWidget);
    expect(find.text('5 · AI 使用标注'), findsOneWidget);
  });
}
