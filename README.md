# cb_intros

A visually appealing and customizable onboarding/intro screen widget for your Flutter applications.

[![pub package](https://img.shields.io/pub/v/cb_intros.svg)](https://pub.dev/packages/cb_intros)
[![GitHub stars](https://img.shields.io/github/stars/connelevalsam/cb-intros.git)](https://github.com/connelevalsam/cb-intros.git)

## Features

* **Smooth Page Transition:**  Provides a smooth `PageView` for a seamless onboarding experience.
* **Customizable Appearance:** Control the background colors, image assets, text content (titles and
  descriptions), button color, and padding.
* **Animated Page Indicator:** Includes a visually appealing smooth page indicator to show progress.
* **Unique Design:** Features a distinctive "side-cut" design for the text and button area.
* **Easy Integration:** Simple to add to any Flutter project.
* **Animations:** Uses `flutter_animate` for subtle and engaging animations.

## Screenshots/GIFs (Replace with your actual media)

<!-- Add screenshots or GIFs here to showcase your package visually -->
<!-- For example:
<img src="https://your-github-repo/assets/screenshot1.png" width="300">
<img src="https://your-github-repo/assets/demo.gif" width="300">
-->

## Getting Started

1. **Add the dependency:**
2. **Install the package:**
3. **Import it:**

## Usage

Here's a basic example of how to use `CbIntros`:

    import 'package:cb_intros/cb_intros.dart';
    import 'package:flutter/material.dart';
    
    void main() {
    runApp(const MyApp());
    }
    
    class MyApp extends StatelessWidget {
        const MyApp({super.key});
    
        // This widget is the root of your application.
        @override
        Widget build(BuildContext context) {
            return MaterialApp(
                title: 'CBIntros Demo',
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
            List<String> img = [
                'assets/images/image1.jpg',
                'assets/images/image2.png',
                'assets/images/manu vs arsenal.jpeg',
                'assets/images/Osimhen.jpeg',
            ];
            List<Color> colors = [
                Colors.blue,
                Colors.orange,
                Colors.purple,
                Colors.red
            ];
            List<String> title = [
                "Balance",
                "Real",
                "Maintain",
                "Diverse",
            ];
            List<String> desc = [
                "This call to setState tells the Flutter framework that something has",
                "changed in this State, which causes it to rerun the build method below",
                "so that the display can reflect the updated values. If we changed",
                "_counter without calling setState(), then the build method would not",
            ];
            
            moveToNextScreen() {}
            
            @override
            Widget build(BuildContext context) {
                return Scaffold(
                    body: CbIntros(
                        images: img,
                        colors: colors,
                        titles: title,
                        desc: desc,
                        moveToNextScreen: moveToNextScreen,
                        appPadding: 20,
                        boxColor: Colors.blueAccent,
                    ), // This trailing comma makes auto-formatting nicer for build methods.
                );
        }
    }
    
    
    
