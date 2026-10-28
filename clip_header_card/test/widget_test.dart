import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:clip_header_card/main.dart';

void main() {
  testWidgets('三种异形头图都被 ClipPath 渲染', (WidgetTester tester) async {
    await tester.pumpWidget(const ClipHeaderApp());

    expect(find.text('斜切角头图'), findsOneWidget);
    expect(find.text('波浪底边头图'), findsOneWidget);
    expect(find.text('底部内凹弧形'), findsOneWidget);
    expect(find.byType(ClipPath), findsNWidgets(3));
  });
}
