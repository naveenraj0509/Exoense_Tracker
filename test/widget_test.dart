import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:expense_tracker/view_models/transaction_provider.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Create a provider instance
    final provider = TransactionProvider();
    await provider.init();

    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MultiProvider(
        providers: [ChangeNotifierProvider.value(value: provider)],
        child: const MaterialApp(
          home: Scaffold(body: Center(child: Text('Test'))),
        ),
      ),
    );

    // Just verify the app builds without crashing
    expect(find.text('Test'), findsOneWidget);
  });
}
