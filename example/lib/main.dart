import 'package:cb_intros/cb_intros.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CBIntros Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'CBIntros Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Widget> items = [
    Image.network(
      'https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
      fit: BoxFit.cover,
      width: double.infinity,
    ),
    Image.network(
      'https://images.pexels.com/photos/376464/pexels-photo-376464.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
      fit: BoxFit.cover,
      width: double.infinity,
    ),
    const Icon(Icons.payment, size: 200, color: Colors.white),
    Image.network(
      'https://images.pexels.com/photos/958545/pexels-photo-958545.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
      fit: BoxFit.cover,
      width: double.infinity,
    ),
  ];
  final List<Color> colors = [
    Colors.black,
    Colors.orange,
    Colors.purple,
    Colors.red,
  ];
  final List<String> title = [
    "Healthy Food",
    "Fast Delivery",
    "Easy Payment",
    "Enjoy",
  ];
  final List<String> desc = [
    "Order healthy and fresh food online from the comfort of your home.",
    "We deliver your order to your doorstep in a very short time.",
    "Pay for your order using any of our easy payment methods.",
    "Enjoy your meal with your family and friends.",
  ];

  final List<List<Effect>> animationEffects = [
    [const FlipEffect(duration: Duration(seconds: 1))],
    [const FadeEffect(duration: Duration(seconds: 1))],
    [const SlideEffect(duration: Duration(seconds: 1))],
  ];

  void moveToNextScreen() {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Onboarding Finished!')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CbIntros(
        items: items,
        colors: colors,
        titles: title,
        desc: desc,
        moveToNextScreen: moveToNextScreen,
        appPadding: 20,
        boxHeight: 300,
        boxColor: Colors.white,
        btnColor: Colors.deepPurple,
        indicatorActiveColor: Colors.deepPurple,
        // The builder now receives the specific string for the current page
        titleContainer: (BuildContext context, String content) {
          return Text(
            content,
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          );
        },
        descContainer: (BuildContext context, String content) {
          return Text(
            content,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade600),
            textAlign: TextAlign.center,
          );
        },
        animationEffects: animationEffects,
        onPageChanged: (index) {
          // You can still track index here if needed, but it's not required for display
          debugPrint('Page changed to: $index');
        },
      ),
    );
  }
}
