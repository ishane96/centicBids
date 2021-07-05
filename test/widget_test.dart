// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:centic_bids/main.dart';

import '../lib/Utilities/Validators.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());
  });

  test('Empty Name Test', () {
    var result = AuthValidator.validateName('');
    expect(result, 'Please fill name');
  });

  test('Empty Email Test', () {
    var result = AuthValidator.validateEmail('');
    expect(result, 'Please enter your email');
  });

  test('Empty Password Test', () {
    var result = AuthValidator.validatePassword('');
    expect(result, 'Please fill password');
  });

  test('Confirm Password Test', () {
    var result = AuthValidator.validateRetypePassword('', '');
    expect(result, 'Please fill same password');
  });
}
