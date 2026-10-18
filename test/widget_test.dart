import 'package:flutter_test/flutter_test.dart';
import 'package:kopken_clone/main.dart';

void main() {
  testWidgets('Aplikasi Kopken dapat dibuka', (WidgetTester tester) async {
    await tester.pumpWidget(const KopkenApp());

    expect(find.text('KOPKEN'), findsOneWidget);
  });
}
