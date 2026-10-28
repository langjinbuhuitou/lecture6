import 'package:flutter_test/flutter_test.dart';

import 'package:profile_card/main.dart';

void main() {
  testWidgets('名片页展示姓名、统计与标签', (WidgetTester tester) async {
    await tester.pumpWidget(const ProfileCardApp());

    expect(find.text('林金豪'), findsOneWidget);
    expect(find.text('关注'), findsOneWidget);
    expect(find.text('粉丝'), findsOneWidget);
    expect(find.text('获赞'), findsOneWidget);
    expect(find.text('Flutter'), findsOneWidget);
  });
}
