import 'package:flutter_test/flutter_test.dart';
import 'package:supersent_tiktoc_clone/app/app.dart';

void main() {
  testWidgets('App builds without error', (WidgetTester tester) async {
    await tester.pumpWidget(const App());
    expect(find.byType(App), findsOneWidget);
  });
}
