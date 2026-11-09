import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:excess_baggage_calculator/main.dart';

void main() {

  // TEST 1 - CHECK HOME PAGE

  testWidgets('Home page displays correctly', (tester) async {

    await tester.pumpWidget(const MyApp());

    expect(
      find.text('Baggage Fee Calculator'),
      findsOneWidget,
    );

    expect(
      find.byType(TextField),
      findsNWidgets(2),
    );

    expect(
      find.text('Calculate'),
      findsOneWidget,
    );

    expect(
      find.text('Clear'),
      findsOneWidget,
    );
  });

  // TEST 2 - CHECK BAGGAGE CALCULATION

  testWidgets('Economy baggage calculation works', (tester) async {

    await tester.pumpWidget(const MyApp());

    // Enter baggage weight
    await tester.enterText(
      find.byType(TextField).at(0),
      '25',
    );

    // Enter excess baggage rate
    await tester.enterText(
      find.byType(TextField).at(1),
      '15',
    );

    // Press calculate
    await tester.ensureVisible(find.text('Calculate'));
    await tester.tap(find.text('Calculate'));
    await tester.pumpAndSettle();

    // Check results
    expect(
      find.text('Excess Baggage Weight: 5.00 kg'),
      findsOneWidget,
    );

    expect(
      find.text('Excess Baggage Charge: RM 75.00'),
      findsOneWidget,
    );

    expect(
      find.text('Total Amount Payable: RM 81.00'),
      findsOneWidget,
    );
  });
}
