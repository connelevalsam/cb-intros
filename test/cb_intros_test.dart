import 'package:cb_intros/cb_intros.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

void main() {
  testWidgets('CbIntros renders correctly with basic configuration', (
    WidgetTester tester,
  ) async {
    // Define test data
    final List<Widget> items = [const Text('Item 1'), const Text('Item 2')];
    const List<Color> colors = [Colors.blue, Colors.green];
    const Color boxColor = Colors.white;
    const List<String> titles = ['Title 1', 'Title 2'];
    const List<String> descriptions = ['Description 1', 'Description 2'];
    double appPadding = 20.0;
    bool nextScreenCalled = false;

    // Build the widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CbIntros(
            items: items,
            colors: colors,
            boxColor: boxColor,
            titles: titles,
            desc: descriptions,
            appPadding: appPadding,
            moveToNextScreen: () {
              nextScreenCalled = true;
            },
            titleContainer: (BuildContext context, String content) {
              return Text(content);
            },
            descContainer: (BuildContext context, String content) {
              return Text(content);
            },
            boxHeight: 300.0,
            btnColor: Colors.pink,
            btnIconColor: Colors.white,
            btnIcon: Icons.add,
            animationEffects: [],
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Verify key elements are present
    expect(find.byType(PageView), findsOneWidget);
    expect(find.byType(AnimatedSmoothIndicator), findsOneWidget);
    expect(find.text('Item 1'), findsOneWidget);
    expect(find.text(titles[0]), findsOneWidget);
    expect(find.text(descriptions[0]), findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);

    // Test page change
    final pageView = find.byType(PageView).first;
    await tester.drag(pageView, const Offset(-400, 0)); // Drag to next page
    await tester.pumpAndSettle();

    expect(find.text('Item 2'), findsOneWidget);
    expect(find.text(titles[1]), findsOneWidget);
    expect(find.text(descriptions[1]), findsOneWidget);

    // Test button tap
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    // The button on the last page triggers the callback
    expect(nextScreenCalled, true);
  });
}
