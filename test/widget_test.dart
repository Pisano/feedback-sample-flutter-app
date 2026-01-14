// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:pisano_feedback_remote_sample/main.dart';

void main() {
  testWidgets('App boots and navigates to feedback screen', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    // Home
    expect(find.text('Pisano'), findsOneWidget);
    expect(find.text('Getting Started'), findsOneWidget);

    // If no defines are provided in tests, init is skipped and this banner is shown.
    expect(find.textContaining('PisanoConfig is not set'), findsOneWidget);

    // Navigate
    await tester.tap(find.text('Getting Started'));
    await tester.pumpAndSettle();

    // Feedback screen basic UI
    expect(find.text('Get Feedback'), findsOneWidget);
    expect(find.text('Track'), findsOneWidget);
    expect(find.text('Clear'), findsOneWidget);
  });
}
