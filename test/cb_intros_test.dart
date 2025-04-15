import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cb_intros/cb_intros.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

void main() {
  testWidgets('CbIntros renders correctly with basic configuration', (
    WidgetTester tester,
  ) async {
    // Define test data
    const List<String> images = [
      'assets/images/test_img1.JPG',
      'assets/images/test_img2.JPG',
    ];
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
            images: images,
            colors: colors,
            boxColor: boxColor,
            titles: titles,
            desc: descriptions,
            appPadding: appPadding,
            moveToNextScreen: () {
              nextScreenCalled = true;
            }, titleContainer: (BuildContext context) {
              return Text("data");
          }, descContainer: (BuildContext context) {
              return Text("data");
          },
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Verify key elements are present
    expect(find.byType(PageView), findsOneWidget);
    expect(find.byType(AnimatedSmoothIndicator), findsOneWidget);
    expect(find.text(titles[0]), findsOneWidget);
    expect(find.text(descriptions[0]), findsOneWidget);
    expect(find.byIcon(Icons.keyboard_arrow_right_outlined), findsOneWidget);

    // Test page change
    final pageView = find.byType(PageView).first;
    await tester.drag(pageView, const Offset(-400, 0)); // Drag to next page
    await tester.pumpAndSettle();

    expect(find.text(titles[1]), findsOneWidget);
    expect(find.text(descriptions[1]), findsOneWidget);

    // Test button tap
    await tester.tap(find.byIcon(Icons.keyboard_arrow_right_outlined));
    await tester.pumpAndSettle();

    // The button on the last page triggers the callback
    expect(nextScreenCalled, false); // Because we are not on the last page

    await tester.drag(pageView, const Offset(-400, 0)); // Drag to the next page
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.keyboard_arrow_right_outlined));
    await tester.pumpAndSettle();
    expect(nextScreenCalled, true); // Now it should be true
  });
}
