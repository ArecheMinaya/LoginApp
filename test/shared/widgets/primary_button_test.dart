import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_app/src/shared/widgets/primary_button.dart';

void main() {
  Widget wrap(Widget child) {
    return MaterialApp(
      home: Scaffold(body: Center(child: child)),
    );
  }

  testWidgets('muestra el texto y es presionable cuando no está cargando', (
    tester,
  ) async {
    var tapped = false;

    await tester.pumpWidget(
      wrap(
        PrimaryButton(
          text: 'Entrar',
          onPressed: () => tapped = true,
          isLoading: false,
        ),
      ),
    );

    // Renderiza el texto
    expect(find.text('Entrar'), findsOneWidget);

    // No muestra spinner ni "Cargando..."
    expect(find.text('Cargando...'), findsNothing);

    // Tap funciona
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();
    expect(tapped, isTrue);
  });

  testWidgets('muestra loading y se deshabilita cuando isLoading = true', (
    tester,
  ) async {
    await tester.pumpWidget(
      wrap(
        PrimaryButton(text: 'Entrar', onPressed: () => true, isLoading: true),
      ),
    );

    // Muestra spinner y texto "Cargando..."
    expect(find.text('Cargando...'), findsOneWidget);

    // // No muestra el label normal
    expect(find.text('Entrar'), findsNothing);

    // ElevatedButton deshabilitado
    final btn = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
    expect(btn.onPressed, isNull);
  });
}
