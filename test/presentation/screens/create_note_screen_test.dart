import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prueba_cyttek/presentation/presentation.dart';

void main() {
  testWidgets('displays title and description inputs', (tester) async {
    await tester.pumpWidget(
      ProviderScope(child: MaterialApp(home: CreateNoteScreen())),
    );

    expect(find.text('Título'), findsOneWidget);
    expect(find.text('Descripción'), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(2));
  });
}
